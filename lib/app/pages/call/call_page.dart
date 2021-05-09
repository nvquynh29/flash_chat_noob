import 'dart:async';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:flash/app/constants/agora_settings.dart';
import 'package:flash/app/controllers/auth_controller.dart';
import 'package:flash/app/models/call.dart';
import 'package:flash/app/pages/call/call_ended.dart';
import 'package:flash/app/pages/call/dial_screen.dart';
import 'package:flash/app/pages/call/video_call.dart';
import 'package:flash/app/pages/call/voice_call.dart';
import 'package:flash/app/pages/home/home_page.dart';
import 'package:flash/app/pages/loading.dart';
import 'package:flash/app/utils/call_utils.dart';
import 'package:flash/repositories/call_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CallPage extends StatefulWidget {
  static final String routeName = '/callpage';

  final String channelName;

  final ClientRole role;

  final Call call;

  const CallPage({Key key, this.channelName, this.role, this.call})
      : super(key: key);

  @override
  _CallPageState createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  var joined = false.obs;
  final _users = <int>[];
  final _infoStrings = <String>[];
  bool muted = false;
  RtcEngine _engine;

  @override
  void dispose() {
    // clear users
    _users.clear();
    // destroy sdk
    _engine.leaveChannel();
    _engine.destroy();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // initialize agora sdk
    initialize();
  }

  Future<void> initialize() async {
    if (APP_ID.isEmpty) {
      setState(() {
        _infoStrings.add(
          'APP_ID missing, please provide your APP_ID in settings.dart',
        );
        _infoStrings.add('Agora Engine is not starting');
      });
      return;
    }

    await _initAgoraRtcEngine();
    _addAgoraEventHandlers();
    await _engine.enableWebSdkInteroperability(true);
    VideoEncoderConfiguration configuration = VideoEncoderConfiguration();
    configuration.dimensions = VideoDimensions(1920, 1080);
    await _engine.setVideoEncoderConfiguration(configuration);
    await _engine.joinChannel(token, defaultChannel, null, 0);
  }

  // Create agora sdk instance and initialize
  Future<void> _initAgoraRtcEngine() async {
    _engine = await RtcEngine.create(APP_ID);
    await _engine.enableAudio();
    await _engine.enableVideo();
    await _engine.setAudioProfile(
        AudioProfile.MusicStandard, AudioScenario.MEETING);
    await _engine.setChannelProfile(ChannelProfile.Communication);
    await _engine.setClientRole(widget.role);
  }

  // Add agora event handlers
  void _addAgoraEventHandlers() {
    _engine.setEventHandler(RtcEngineEventHandler(error: (code) {
      setState(() {
        final info = 'onError: $code';
        _infoStrings.add(info);
      });
    }, joinChannelSuccess: (channel, uid, elapsed) {
      setState(() {
        final info = 'onJoinChannel: $channel, uid: $uid';
        _infoStrings.add(info);
      });
    }, leaveChannel: (stats) {
      setState(() {
        _infoStrings.add('onLeaveChannel');
        _users.clear();
      });
    }, userJoined: (uid, elapsed) {
      setState(() {
        final info = 'userJoined: $uid';
        _infoStrings.add(info);
        _users.add(uid);
      });
    }, userOffline: (uid, elapsed) {
      setState(() {
        final info = 'userOffline: $uid';
        _infoStrings.add(info);
        _users.remove(uid);
      });
    }, firstRemoteVideoFrame: (uid, width, height, elapsed) {
      setState(() {
        final info = 'firstRemoteVideo: $uid ${width}x $height';
        _infoStrings.add(info);
      });
    }));
  }

  // Helper function to get list of native views
  List<Widget> _getRenderViews() {
    final List<StatefulWidget> list = [];
    if (widget.role == ClientRole.Broadcaster) {
      list.add(RtcLocalView.SurfaceView());
    }
    _users.forEach((int uid) => list.add(RtcRemoteView.SurfaceView(uid: uid)));
    return list;
  }

  // Video view wrapper
  Widget _videoView(view) {
    return Expanded(child: Container(child: view));
  }

  // Video view row wrapper
  Widget _expandedVideoRow(List<Widget> views) {
    final wrappedViews = views.map<Widget>(_videoView).toList();
    return Expanded(
      child: Row(
        children: wrappedViews,
      ),
    );
  }

  // Video layout wrapper
  Widget _viewRows() {
    final views = _getRenderViews();
    switch (views.length) {
      case 1:
        return Container(
            child: Column(
          children: <Widget>[_videoView(views[0])],
        ));
      case 2:
        return Container(
            child: Column(
          children: <Widget>[
            _expandedVideoRow([views[0]]),
            _expandedVideoRow([views[1]])
          ],
        ));
      default:
    }
    return Container();
  }

  // Toolbar layout
  Widget _toolbar() {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          RawMaterialButton(
            onPressed: _onToggleMute,
            child: Icon(
              muted ? Icons.mic_off : Icons.mic,
              color: muted ? Colors.white : Colors.blueAccent,
              size: 30,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: muted ? Colors.blueAccent : Colors.white,
            padding: const EdgeInsets.all(12.0),
          ),
          RawMaterialButton(
            onPressed: () async {
              _onCallEnd(context);
              _users.clear();
              Get.offAllNamed(Loading.routeName);
              await CallRepository()
                  .endCall(call: widget.call)
                  .whenComplete(() => Get.offAllNamed(HomePage.routeName));
            },
            child: Icon(
              Icons.call_end,
              color: Colors.white,
              size: 40.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.redAccent,
            padding: const EdgeInsets.all(15.0),
          ),
          RawMaterialButton(
            onPressed: _onSwitchCamera,
            child: Icon(
              Icons.switch_camera,
              color: Colors.blueAccent,
              size: 30.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.white,
            padding: const EdgeInsets.all(12.0),
          )
        ],
      ),
    );
  }

  void _onCallEnd(BuildContext context) {
    Navigator.pop(context);
  }

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    _engine.muteLocalAudioStream(muted);
  }

  void _onSwitchCamera() {
    _engine.switchCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: widget.role != ClientRole.Audience
          ? videoRouting()
          : voiceRouting(),
    );
  }

  Widget videoRouting() {
    final views = _getRenderViews();
    switch (views.length) {
      case 0:
        if (joined.value) {
          return CallEnded();
        } else {
          // return VideoCall(
          //     call: widget.call, viewRows: _viewRows(), toolbar: _toolbar());
          if (CallUtils.hasDial(
              call: widget.call, uid: Get.find<AuthController>().user.uid)) {
            return DialScreen(call: widget.call);
          } else {
            return VideoCall(
                call: widget.call, viewRows: _viewRows(), toolbar: _toolbar());
          }
        }
        break;
      case 1:
      case 2:
        joined.value = true;
        return VideoCall(
            call: widget.call, viewRows: _viewRows(), toolbar: _toolbar());
      default:
        joined.value = false;
        break;
    }
    return Scaffold(
      body: Center(
        child: Text('Calling error'),
      ),
    );
  }

  Widget voiceRouting() {
    final views = _getRenderViews();
    switch (views.length) {
      case 0:
        if (joined.value) {
          return CallEnded();
        } else {
          if (CallUtils.hasDial(
              call: widget.call, uid: Get.find<AuthController>().user.uid)) {
            return DialScreen(call: widget.call);
          } else {
            return VoiceCall(call: widget.call, toolbar: _toolbar());
          }
        }
        break;
      case 1:
        joined.value = true;
        return VoiceCall(call: widget.call, toolbar: _toolbar());
      default:
        joined.value = false;
        break;
    }
    return Scaffold();
  }
}