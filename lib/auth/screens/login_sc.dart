import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:leamapp/auth/screens/signup_sc.dart';
import 'package:leamapp/auth/services/login_services.dart';
import 'package:leamapp/common/models/app_colors.dart';
import 'package:leamapp/common/widgets/custom_flush_bar.dart';
import 'package:leamapp/common/widgets/rich_text_field.dart';
import 'package:leamapp/common/widgets/rounded_button.dart';
import 'package:leamapp/main_store.dart';
import 'package:leamapp/tab_view_main.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  final String email;
  const LoginScreen({
    Key key,
    this.email,
  }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    if (widget.email != null) {
      _emailController.text = widget.email;
    }
    super.initState();
    Future.delayed(Duration.zero, () {});
  }

  setLoadingState(bool newState) {
    if (mounted && (loading != newState)) {
      setState(() {
        loading = newState;
      });
    }
  }

  _signIn(MainStore mainStore) async {
    FocusScope.of(context).requestFocus(FocusNode());
    final form = _formKey.currentState;

    if (!loading && form.validate()) {
      setState(() {
        loading = true;
      });

      form.save();
      login(
        email: _emailController.text,
        password: _passwordController.text,
      ).then((value) {
        if (value) {
          Get.offAll(() => const TabViewMain());
        } else {
          setState(() {
            loading = false;
          });
          toastAlert(context, 'Check you credentiels please');
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mainStore = Provider.of<MainStore>(context);
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return Scaffold(
          body: Builder(
        builder: (context) => SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 24),
                  Expanded(
                    flex: isKeyboardVisible ? 4 : 9,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          height: isKeyboardVisible ? 100 : 150.0,
                          child: Image.asset(
                            "assets/icons/logo.png",
                            color: MyColors.appMain100,
                            height: isKeyboardVisible ? 100 : 150.0,
                          ),
                        ),
                        //if (!isKeyboardVisible)
                        const Text(
                          "Leam Food",
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'PlayfairDisplay',
                            letterSpacing: 1.4,
                            color: MyColors.appMain100,
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 12,
                    child: Column(
                      children: <Widget>[
                        Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              RichTextField(
                                keyboardType: TextInputType.emailAddress,
                                controller: _emailController,
                                hintText: "Email",
                                validator: (value) {
                                  if (!EmailValidator.validate(value?.trim())) {
                                    return 'Please enter a valid email address';
                                  }

                                  return null;
                                },
                              ),
                              const SizedBox(height: 10),
                              RichTextField(
                                keyboardType: TextInputType.text,
                                controller: _passwordController,
                                hintText: "Password",
                                obscureText: true,
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Please enter a valid password';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),
                        RoundedButton(
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 20.0),
                          content: loading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    backgroundColor: MyColors.appMain100,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  ),
                                )
                              : const Text("SIGN IN",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                    letterSpacing: -0.3,
                                  )),
                          onPressed: () async {
                            FocusScope.of(context).requestFocus(FocusNode());
                            _signIn(mainStore);
                          },
                        ),
                        const SizedBox(height: 32),
                        InkWell(
                          onTap: () {
                            if (loading) return;
                            Get.to(() => const SignupScreen());
                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: const Text("Don't have an accout ?\nSign up",
                                style: TextStyle(
                                    color: Color(0xff8d8d8d),
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 16.0),
                                textAlign: TextAlign.center),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ));
    });
  }
}
