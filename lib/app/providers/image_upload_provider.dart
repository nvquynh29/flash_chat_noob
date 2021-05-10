import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash/app/models/message.dart';
import 'package:flash/app/utils/enum.dart';
import 'package:flash/repositories/message_repository.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as fs;
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as Im;
import 'package:image_picker/image_picker.dart';

class ImageUploadProvider with ChangeNotifier {
  ViewState _viewState = ViewState.IDLE;
  ViewState get getViewState => _viewState;

  void setToLoading() {
    _viewState = ViewState.LOADING;
    notifyListeners();
  }

  void setToIdle() {
    _viewState = ViewState.IDLE;
    notifyListeners();
  }

  fs.Reference _storage;
  fs.UploadTask _uploadTask;
  final messageRepository = MessageRepository();

  Future<File> pickImage({@required ImageSource source}) async {
    PickedFile pickedFile = await ImagePicker().getImage(source: source);
    if (pickedFile != null) {
      File selectedImage = File(pickedFile.path);
      return await compressImage(selectedImage);
    }
    return null;
  }

  Future<File> compressImage(File imageToCompress) async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    int rand = Random().nextInt(10000);

    Im.Image image = Im.decodeImage(imageToCompress.readAsBytesSync());
    Im.copyResize(image, width: 500, height: 500);

    return new File('$path/img_$rand.jpg')
      ..writeAsBytesSync(Im.encodeJpg(image, quality: 85));
  }

  Future<String> uploadImageToStorage(File image) async {
    String url = '';
    if (image != null) {
      try {
        _storage = fs.FirebaseStorage.instance
            .ref()
            .child('${DateTime.now().millisecondsSinceEpoch}');
        _uploadTask = _storage.putFile(image);
        fs.TaskSnapshot taskSnapshot =
            await _uploadTask.whenComplete(() => null);
        url = await taskSnapshot.ref.getDownloadURL();
        return url;
      } catch (ex) {
        print(ex);
        return null;
      }
    }
  }

  void setImageMsg({
    String url,
    String senderId,
    String receiverId,
  }) async {
    Message message;

    message = Message.image(
        message: "IMAGE",
        receiverId: receiverId,
        senderId: senderId,
        photoUrl: url,
        timestamp: Timestamp.now(),
        type: 'image');
    messageRepository.sendMessage(message: message);
  }

  void uploadImageMessage({
    File image,
    String receiverId,
    String senderId,
  }) async {
    // Set some loading value to db and show it to user
    setToLoading();

    // Get url from the image bucket
    String url = await uploadImageToStorage(image);

    // Hide loading
    setToIdle();

    if (url != null) {
      setImageMsg(url: url, senderId: senderId, receiverId: receiverId);
    }
  }

  
}
