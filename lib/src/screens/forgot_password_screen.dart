import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_store/src/common/theme_helper.dart';
import 'package:mobile_store/src/repository/authentication_repository.dart';
import 'package:mobile_store/src/screens/forgot_pass_vetify.dart';
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
        duration: Duration(seconds: 3),
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
                              'Quên mật khẩu',
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
                              'Nhập địa chỉ email.',
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
                              'Chúng tôi sẽ gửi mã xác thực về email trước khi làm mới mật khẩu của bạn.',
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
                                    var status =
                                        await AuthenticationRepository()
                                            .forgotPassAPI(email: email.text);
                                    if (status.statusCode == 200) {
                                      // trường hợp gửi mã otp thành công
                                      // Chuyển sang trang ForgotPasswordVetify
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text(
                                                  'Một mã xác thực đã được gửi đến mail của bạn'),
                                              content: Text(
                                                  'Bấm "OK" để nhập mã OTP '),
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
                                                    Navigator.of(context)
                                                        .pushAndRemoveUntil(
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    ForgotPasswordVetify(
                                                                        email
                                                                            .text)),
                                                            (route) => false);
                                                  },
                                                ),
                                              ],
                                            );
                                          });
                                    } else if (status.statusCode == 404) {
                                      snackBar("Tài khoản không tồn tại");
                                    } else {
                                      snackBar("Tài khoản không tồn tại");
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
