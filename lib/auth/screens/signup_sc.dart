import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:leamapp/auth/services/login_services.dart';
import 'package:leamapp/auth/services/signup_services.dart';
import 'package:leamapp/common/models/app_colors.dart';
import 'package:leamapp/common/widgets/custom_flush_bar.dart';
import 'package:leamapp/common/widgets/rich_text_field.dart';
import 'package:leamapp/common/widgets/rounded_button.dart';
import 'package:leamapp/tab_view_main.dart';

import 'login_sc.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  bool loading = false;
  // String _password;
  final ScrollController _controller = ScrollController();
  final TextEditingController _fnameController = TextEditingController();
  final TextEditingController _lnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  /// Sign up with new account
  _signUp(BuildContext context) {
    FocusScope.of(context).unfocus();
    if (loading) return;
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      setState(() {
        loading = true;
      });

      signup(
        fname: _fnameController.text,
        lname: _lnameController.text,
        email: _emailController.text,
        password: _passwordController.text,
      ).then((value) {
        if (mounted) {
          if (value) {
            /// Make an auto login
            _autoLogin();
          } else {
            setState(() {
              loading = false;
            });
            toastError(context);
          }
        }
      });
    }
  }

  _autoLogin() {
    login().then((value) {
      if (value) {
        /// if success go into the app
        Get.to(() => const TabViewMain());
      } else {
        /// if login not successed go to login page
        /// and auto fill the email
        Get.to(() => LoginScreen(
              email: _emailController.text,
            ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: const Icon(
                Icons.keyboard_backspace,
                color: Color(0xff444444),
                size: 26,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: Builder(
            builder: (context) => SingleChildScrollView(
              controller: _controller,
              child: Container(
                height: MediaQuery.of(context).size.height,
                color: Colors.white,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, right: 16, bottom: 16),
                  child: Column(
                    children: <Widget>[
                      if (!isKeyboardVisible) const SizedBox(height: 32),
                      isKeyboardVisible
                          ? const Center()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                    "Create your account \nand enjoy Leam Food"
                                        .toUpperCase(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Color(0xff444444),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.normal,
                                      letterSpacing: -0.5,
                                    )),
                              ],
                            ),
                      if (!isKeyboardVisible)
                        const SizedBox(
                          height: 32,
                        ),
                      Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            RichTextField(
                              controller: _fnameController,
                              textCapitalization: TextCapitalization.words,
                              hintText: "First Name",
                              validator: (val) {
                                if (val.isEmpty) {
                                  return "Please enter your first name";
                                } else if (val.length > 100) {
                                  return 'First name length should not exceed 100 characters';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            RichTextField(
                              controller: _lnameController,
                              textCapitalization: TextCapitalization.words,
                              hintText: "Last Name",
                              validator: (val) {
                                if (val.isEmpty) {
                                  return "Please enter your real last name";
                                } else if (val.length > 100) {
                                  return "Last name length should not exceed 100 characters";
                                }
                                return null;
                              },

//
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            RichTextField(
                              keyboardType: TextInputType.emailAddress,
                              controller: _emailController,
                              hintText: "Email*",
                              validator: (value) {
                                if (!EmailValidator.validate(value?.trim())) {
                                  return 'Please enter a valid email address';
                                }

                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            RichTextField(
                              controller: _passwordController,
                              hintText: "Password",
                              obscureText: true,
                              validator: (val) {
                                if (val.isEmpty) {
                                  return "Please enter a Password";
                                } else if (val.length < 8) {
                                  return 'Password length should not be less then 8 characters';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      isKeyboardVisible ? SizedBox(height: 30) : const Spacer(),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: Align(
                                  alignment: FractionalOffset.topCenter,
                                  child: RoundedButton(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 20.0),
                                    content: loading
                                        ? const SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2.5,
                                              backgroundColor:
                                                  MyColors.appMain100,
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      Colors.white),
                                            ),
                                          )
                                        : Text("Sign Up".toUpperCase(),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              fontStyle: FontStyle.normal,
                                              letterSpacing: -0.3,
                                            )),
                                    onPressed: () {
                                      _signUp(context);
                                    },
                                  )),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          ));
    });
  }
}
