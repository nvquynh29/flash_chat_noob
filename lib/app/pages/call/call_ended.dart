import 'package:flash/app/constants/colors.dart';
import 'package:flash/app/pages/call/success.dart';
import 'package:flash/app/pages/home/home_page.dart';
import 'package:flash/app/utils/media.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class CallEnded extends StatelessWidget {
  static final String routeName = '/callend';
  @override
  Widget build(BuildContext context) {
    Media media = Media(context);
    double r = media.ratio;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF06C044),
        centerTitle: true,
        title: Text('Rate your call'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Get.offAllNamed(HomePage.routeName),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: r * 4,
            vertical: r * 20,
          ),
          child: Column(
            children: [
              Text(
                'Rate your experience',
                style: TextStyle(
                  fontSize: r * 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: r * 20),
              Center(
                child: SmoothStarRating(
                  color: primary,
                  allowHalfRating: true,
                  onRated: (v) {},
                  starCount: 5,
                  size: r * 40,
                  isReadOnly: false,
                  spacing: r * 14,
                ),
              ),
              SizedBox(height: r * 30),
              Divider(height: r * 3, color: Colors.grey),
              SizedBox(height: r * 15),
              Text(
                'Tell us what can be Improved?',
                style: TextStyle(
                  fontSize: r * 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: r * 20),
              Wrap(
                children: [
                  RatingBubble(r: r, content: 'Overall Service'),
                  RatingBubble(r: r, content: 'Customer Support'),
                  RatingBubble(r: r, content: 'Speed and Efficiency'),
                  RatingBubble(r: r, content: 'Repair Quality'),
                  RatingBubble(r: r, content: 'Transperancy'),
                ],
                spacing: r * 14,
                runSpacing: r * 14,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: r * 10),
                child: Divider(height: r * 3, color: Colors.grey),
              ),
              Text(
                'Comment',
                style: TextStyle(
                  fontSize: r * 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(r * 10),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: r * 10),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: TextField(
                    style: TextStyle(fontSize: r * 17),
                    keyboardType: TextInputType.multiline,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: 'Type your comment',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              ActionButton(
                ratio: r,
                label: 'Submit',
                press: () {
                  Get.toNamed(Success.routeName);
                },
                bgColor: primary,
              ),
              ActionButton(
                ratio: r,
                label: 'Not Now',
                press: () {
                  Get.offAllNamed(HomePage.routeName);
                },
                bgColor: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RatingBubble extends StatefulWidget {
  RatingBubble({
    Key key,
    @required this.r,
    @required this.content,
  }) : super(key: key);

  final double r;
  final String content;

  @override
  _RatingBubbleState createState() => _RatingBubbleState();
}

class _RatingBubbleState extends State<RatingBubble> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.all(widget.r * 14),
        decoration: BoxDecoration(
          color: _isSelected ? primary : Colors.grey.withOpacity(0.3),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          widget.content,
          style: TextStyle(
            color: _isSelected ? Colors.white : Colors.black,
            fontSize: widget.r * 16,
          ),
        ),
      ),
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
        });
      },
    );
  }
}

class ActionButton extends StatelessWidget {
  final String label;
  final VoidCallback press;
  final double ratio;
  final Color bgColor;
  ActionButton(
      {@required this.label,
      @required this.press,
      @required this.ratio,
      this.bgColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(ratio * 14),
      child: Container(
        width: ratio * 140,
        child: TextButton(
          onPressed: press,
          style: TextButton.styleFrom(
              backgroundColor: bgColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(
                  vertical: ratio * 10, horizontal: ratio * 20)),
          child: Text(label,
              style: TextStyle(fontSize: ratio * 20, color: Colors.white)),
        ),
      ),
    );
  }
}
