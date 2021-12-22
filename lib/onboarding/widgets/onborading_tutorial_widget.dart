import 'package:flutter/material.dart';
import 'package:leamapp/common/helpers/device_info.dart';

class OnboardingTutorial extends StatelessWidget {
  final String title;
  final String message;
  final String imageURL;
  final int step;
  final Color imageColor;

  const OnboardingTutorial(
      {Key key,
      this.title,
      this.message,
      this.imageURL,
      @required this.step,
      this.imageColor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(),
          ),
          SizedBox(
            width: double.infinity,
            child: Text(
              title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontFamily: 'PlayfairDisplay',
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.6),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            width: double.infinity,
            child: Text(
              message,
              style: TextStyle(
                color: const Color(0xffffffff).withOpacity(0.8),
                fontWeight: FontWeight.w500,
                fontFamily: "SourceSansPro",
                fontSize: 18,
                fontStyle: FontStyle.normal,
              ),
            ),
          ),
          const SizedBox(
            height: 23,
          ),
          Image.asset(
            imageURL,
            height: getScreenWidth(context, 0.8),
            color: imageColor,
          ),
          Expanded(
            flex: 3,
            child: Container(),
          ),
        ],
      ),
    );
  }
}
