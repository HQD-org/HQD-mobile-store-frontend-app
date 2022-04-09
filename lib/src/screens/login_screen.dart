import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_store/src/app.dart';
import 'package:mobile_store/src/common/shared_preference_user.dart';
import 'package:mobile_store/src/common/theme_helper.dart';

import 'package:mobile_store/src/repository/authentication_repository.dart';
import 'package:mobile_store/src/screens/forgot_password_screen.dart';

import 'package:mobile_store/src/screens/registration_screen.dart';
import 'package:mobile_store/src/screens/vetification_screen.dart';
import 'package:mobile_store/src/widgets/dialog_loading.dart';
import 'package:mobile_store/src/widgets/header_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  var _headerHeight = 250.0;
  final _formKey = GlobalKey<FormState>();
  TextEditingController email = new TextEditingController();
  TextEditingController pass = new TextEditingController();

// snackBar Widget
  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: _headerHeight,
              child: HeaderWidget(_headerHeight, true,
                  Icons.login_rounded), // tạo cái header widget dùng chung
            ),
            SafeArea(
              // bắt đầu code form Login
              child: Container(
                padding: EdgeInsets.only(
                    left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
                margin: EdgeInsets.only(
                    left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
                child: Column(
                  children: [
                    Text(
                      "Welcome to HQD Mobile",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text("Please! login first",
                        style: TextStyle(fontSize: 16, color: Colors.grey)),
                    SizedBox(
                      height: 20.0,
                    ),
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: email,
                              validator: (value) {
                                if (value == null) {
                                  return "Email not empty";
                                }
                                return null;
                              },
                              decoration: ThemeHelper()
                                  .textInputDecoration("Email", "Enter Email"),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            TextFormField(
                              controller: pass,
                              validator: (value) {
                                if (value == null) {
                                  return "Password not empty";
                                }
                                return null;
                              },
                              decoration: ThemeHelper().textInputDecoration(
                                  "Password", "Enter Password"),
                              obscureText: true,
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(40, 8, 40, 8),
                              decoration:
                                  ThemeHelper().buttonBoxDecoration(context),
                              child: ElevatedButton(
                                style: ThemeHelper().buttonStyle(),
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    showDialogLoading(context);
                                    var status =
                                        await AuthenticationRepository()
                                            .loginAPI(
                                      username: email.text,
                                      password: pass.text,
                                    );
                                    Navigator.pop(context);
                                    if (status.statusCode == 200) {
                                      var dataResponse =
                                          jsonDecode(status.body);
                                      UserSharedPreference.setAccessToken(
                                          dataResponse['data']['accessToken']);
                                      Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              AppMobileStore(),
                                        ),
                                        (route) => false,
                                      );
                                    } else if (status.statusCode == 401) {
                                      // khúc này yêu cầu người dùng verify tài khoản trước khi Login
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text('Verify account'),
                                              content: Text(
                                                  'Please Press "OK" Verify Account'),
                                              actions: [
                                                TextButton(
                                                  child: Text(
                                                    "OK",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(Colors
                                                                  .black38)),
                                                  onPressed: () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                PinCodeVerificationScreen(
                                                                    email
                                                                        .text)));
                                                  },
                                                ),
                                              ],
                                            );
                                          });
                                      //snackBar("Please Verify Account");
                                    } else if (status.statusCode == 404 ||
                                        status.statusCode == 400) {
                                      snackBar("Email not exits");
                                    } else if (status.statusCode == 403) {
                                      snackBar("Password incorrect");
                                    }
                                  }
                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(15.0),
                              child: GestureDetector(
                                child: Text("Quên mật khẩu"),
                                onTap: () {
                                  print("Forgot Password");
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          ForgotPasswordScreen()));
                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(8.0),
                              child: GestureDetector(
                                child: Text("Chưa có tài khoản? Đăng ký ngay"),
                                onTap: () {
                                  print("Don't have an account? Create");
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          RegistrationScreen()));
                                },
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
