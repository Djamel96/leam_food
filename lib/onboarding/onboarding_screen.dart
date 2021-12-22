import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leamapp/auth/screens/login_sc.dart';
import 'package:leamapp/common/const.dart';
import 'package:leamapp/common/helpers/device_info.dart';
import 'package:leamapp/common/models/app_colors.dart';
import 'package:leamapp/common/widgets/my_inkwell.dart';
import 'package:leamapp/common/widgets/rounded_button.dart';
import 'package:leamapp/common/widgets/safe_area_widget.dart';
import 'package:leamapp/onboarding/widgets/scrolleBehavior.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'widgets/onborading_tutorial_widget.dart';

/// An indicator showing the currently selected page of a PageController
class DotsIndicator extends AnimatedWidget {
  DotsIndicator({
    this.controller,
    this.itemCount,
    this.onPageSelected,
    this.color = MyColors.appMain100,
  }) : super(listenable: controller);

  /// The PageController that this DotsIndicator is representing.
  final PageController controller;

  /// The number of items managed by the PageController
  final int itemCount;

  /// Called when a dot is tapped
  final ValueChanged<int> onPageSelected;

  /// The color of the dots.
  ///
  /// Defaults to `Colors.white`.
  final Color color;

  // The base size of the dots
  static const double _kDotSize = 8.0;

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((controller.page ?? controller.initialPage) - index).abs(),
      ),
    );

    return Container(
      margin: const EdgeInsets.only(right: 15),
      width: _kDotSize,
      child: Material(
        color: selectedness > 0 ? color : Color(0xffffffff).withOpacity(0.8),
        type: MaterialType.circle,
        child: SizedBox(
          width: _kDotSize,
          height: _kDotSize,
          child: InkWell(
            onTap: () => onPageSelected(index),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(itemCount, _buildDot),
    );
  }
}

class FirstOnboardingScreen extends StatefulWidget {
  @override
  State createState() => new FirstOnboardingScreenState();
}

class FirstOnboardingScreenState extends State<FirstOnboardingScreen> {
  final _controller = new PageController();

  static const _kDuration = const Duration(milliseconds: 300);

  static const _kCurve = Curves.ease;

  final _kArrowColor = Colors.black.withOpacity(0.8);

  int pageNum = 0;
  bool firstTimeInfoGot = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {});
  }

  Future _verifyIfFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isfirst = prefs.getBool(firstAppInstall);

    //if isfirst == null so there is no data saved, so its the first time

    if (isfirst == null) {
      firstTimeInfoGot = true;
      // save the data so next time the onbaording won't shown
      await prefs.setBool(firstAppInstall, true);

      if (mounted) setState(() {});
    } else {
      Future.delayed(Duration(seconds: 2)).then((value) {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeAreaWidget(
      child: Scaffold(
        backgroundColor: MyColors.appMain100,
        body: IconTheme(
          data: IconThemeData(color: _kArrowColor),
          child: Stack(
            children: <Widget>[
              Container(
                alignment: Alignment.topCenter,
                height: MediaQuery.of(context).size.height,
                child: ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: PageView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    controller: _controller,
                    onPageChanged: (val) {
                      setState(() {
                        pageNum = val;
                      });
                    },
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topCenter,
                        child: const OnboardingTutorial(
                          step: 1,
                          title: "Find \nBest Recips",
                          message: "Our app group the best food recips ever !",
                          imageURL: "assets/elustrations/two_cooks.png",
                        ),
                      ),
                      Container(
                        alignment: Alignment.topCenter,
                        child: const OnboardingTutorial(
                          step: 2,
                          title: "Only \nDelicious Meals",
                          message:
                              "Our recips suggests you the most delicious meals with simple ingredience",
                          imageURL: "assets/elustrations/good_cook.png",
                        ),
                      ),
                      Container(
                        alignment: Alignment.topCenter,
                        child: const OnboardingTutorial(
                          step: 3,
                          title: "Enjoy \nCooking",
                          message:
                              "Delicious and detailed restaurant recipes on your phone",
                          imageURL: "assets/elustrations/cook.png",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 100,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: DotsIndicator(
                      controller: _controller,
                      itemCount: 3,
                      color: Colors.white,
                      onPageSelected: (int page) {
                        setState(() {
                          pageNum = page;
                        });

                        _controller.animateToPage(
                          page,
                          duration: _kDuration,
                          curve: _kCurve,
                        );
                      },
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RoundedButton(
                      width: getScreenWidth(context, .8),
                      height: 59,
                      backgroundColor: Colors.white,
                      content: const Text("Get Started",
                          style: TextStyle(
                            color: Color(0xff9c080a),
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            letterSpacing: -0.3,
                          )),
                      onPressed: () {
                        Get.offAll(const LoginScreen());
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
