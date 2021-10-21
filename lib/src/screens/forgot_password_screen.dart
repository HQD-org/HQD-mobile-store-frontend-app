import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_store/src/common/theme_helper.dart';
import 'package:mobile_store/src/screens/forgot_password_vetification_screen.dart';
import 'package:mobile_store/src/screens/vetification_screen.dart';
import 'package:mobile_store/src/widgets/header_widget.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ForgotPasswordScreen();
  }
}

class _ForgotPasswordScreen extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController email = new TextEditingController();
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
    double _headerHeight = 300;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: _headerHeight,
                child:
                    HeaderWidget(_headerHeight, true, Icons.password_rounded),
              ),
              SafeArea(
                child: Container(
                  margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Forgot Password?',
                              style: TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                              // textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Enter the email address associated with your account.',
                              style: TextStyle(
                                  // fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                              // textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'We will email you a verification code to check your authenticity.',
                              style: TextStyle(
                                color: Colors.black38,
                                // fontSize: 20,
                              ),
                              // textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40.0),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: TextFormField(
                                decoration: ThemeHelper().textInputDecoration(
                                    "Email", "Enter your email"),
                                controller: email,
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "Email can't be empty";
                                  } else if (!RegExp(
                                          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                      .hasMatch(val)) {
                                    return "Enter a valid email address";
                                  }
                                  return null;
                                },
                              ),
                              decoration:
                                  ThemeHelper().inputBoxDecorationShaddow(),
                            ),
                            SizedBox(height: 40.0),
                            Container(
                              decoration:
                                  ThemeHelper().buttonBoxDecoration(context),
                              child: ElevatedButton(
                                style: ThemeHelper().buttonStyle(),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(40, 10, 40, 10),
                                  child: Text(
                                    "Send".toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    var status = await forgotPasswordAPI();
                                    if (status.statusCode == 404) {
                                      snackBar("Account not exist");
                                    } else if (status.statusCode == 200) {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PinCodeVerificationScreen(
                                                    email.text.trim())),
                                      );
                                    }
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }

  // bắt API ForgotPassWord
  Future<http.Response> forgotPasswordAPI() async {
    var url = 'hqd-mobile-store-api.herokuapp.com';
    Map dataBody = {"uername": email.text.trim()};
    var response = await http.post(Uri.https(url, "/auth/forgotPassword"),
        body: jsonEncode(dataBody),
        headers: {
          "Content-type": "application/json",
          "Accept": "application/json",
        });
    print('StatusCode forgotPass: ${response.statusCode}');
    //print("email: ${jsonEncode(response.body)}");
    return response;
  }
}
