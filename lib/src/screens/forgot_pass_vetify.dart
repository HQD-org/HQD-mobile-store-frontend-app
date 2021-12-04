import 'dart:async';

import 'package:flutter/material.dart';

import 'package:mobile_store/src/repository/authentication_repository.dart';

import 'package:mobile_store/src/screens/login_screen.dart';
import 'package:mobile_store/src/widgets/header_widget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ForgotPasswordVetify extends StatefulWidget {
  final String emailCurrent;

  ForgotPasswordVetify(this.emailCurrent);

  @override
  _ForgotPasswordVetifyState createState() => _ForgotPasswordVetifyState();
}

class _ForgotPasswordVetifyState extends State<ForgotPasswordVetify> {
  TextEditingController textEditingController = TextEditingController();
  // ..text = "123456";

  // ignore: close_sinks
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  double _headerHeight = 250;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();

    super.dispose();
  }

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
      backgroundColor: Colors.white, //Constants.PRIMARY_COLOR,
      body: GestureDetector(
        onTap: () {},
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: <Widget>[
              // Container( // cái icon Email chỗ này
              //   height: MediaQuery.of(context).size.height / 3,
              //   child: ClipRRect(
              //       borderRadius: BorderRadius.circular(30),
              //       child: Icon(
              //         Icons.email_rounded,
              //         size: 60,
              //       ) //Image.asset("${Constants.OTP_GIF_IMAGE}"),
              //       ),
              // ),
              Container(
                height: _headerHeight,
                child: HeaderWidget(
                    _headerHeight, true, Icons.privacy_tip_outlined),
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Xác thực OTP',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
                child: RichText(
                  text: TextSpan(
                      text: "Nhập mã OTP đã gửi tới ",
                      children: [
                        TextSpan(
                            text: "${widget.emailCurrent}",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15)),
                      ],
                      style: TextStyle(color: Colors.black54, fontSize: 15)),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Form(
                key: formKey,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 30),
                    child: PinCodeTextField(
                      appContext: context,
                      pastedTextStyle: TextStyle(
                        color: Colors.green.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                      length: 4,
                      obscureText: true,
                      obscuringCharacter: '*',
                      obscuringWidget: FlutterLogo(
                        size: 24,
                      ),
                      blinkWhenObscuring: true,
                      animationType: AnimationType.fade,
                      validator: (v) {
                        if (v!.length < 3) {
                          return "Nhập OTP";
                        } else {
                          return null;
                        }
                      },
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        activeFillColor: Colors.white,
                      ),
                      cursorColor: Colors.black,
                      animationDuration: Duration(milliseconds: 300),
                      enableActiveFill: true,
                      errorAnimationController: errorController,
                      controller: textEditingController,
                      keyboardType: TextInputType.number,
                      boxShadows: [
                        BoxShadow(
                          offset: Offset(0, 1),
                          color: Colors.black12,
                          blurRadius: 10,
                        )
                      ],
                      onCompleted: (v) {
                        print("Completed");
                      },
                      // onTap: () {
                      //   print("Pressed");
                      // },
                      onChanged: (value) {
                        print(value);
                        setState(() {
                          currentText = value;
                        });
                      },
                      beforeTextPaste: (text) {
                        print("Allowing to paste $text");
                        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                        //but you can show anything you want here, like your pop up saying wrong paste format or etc
                        return true;
                      },
                    )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  hasError ? "*Mã OTP sai" : "",
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Chưa nhận được mã OTP? ",
                    style: TextStyle(color: Colors.black54, fontSize: 15),
                  ),
                  TextButton(
                      onPressed: () => snackBar("OTP resend!!"),
                      child: Text(
                        "Gửi lại",
                        style: TextStyle(
                            color: Color(0xFF91D3B3),
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ))
                ],
              ),
              SizedBox(
                height: 14,
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
                child: ButtonTheme(
                  height: 50,
                  child: TextButton(
                    onPressed: () async {
                      formKey.currentState!.validate();
                      // conditions for validating => currentText.length != 4 || currentText != "1234"
                      var status = await AuthenticationRepository()
                          .sendNewPassAPI(
                              email: widget.emailCurrent,
                              otp: textEditingController.text);

                      if (status.statusCode == 200) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Lấy lại mật khẩu thành công'),
                                content: Text(
                                    'Vui lòng kiểm tra mật khẩu mới tại email'),
                                actions: [
                                  TextButton(
                                    child: Text(
                                      "OK",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.black38)),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            });
                      } else if (status.statusCode == 404) {
                        snackBar("Tài khoản không tồn tại");
                      } else if (status.statusCode == 403) {
                        snackBar("Mã OTP không đúng");
                      } else {
                        snackBar("Mã OPT không đúng");
                      }
                    },
                    child: Center(
                        child: Text(
                      "VERIFY".toUpperCase(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
                decoration: BoxDecoration(
                    color: Colors.green.shade300,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.green.shade200,
                          offset: Offset(1, -2),
                          blurRadius: 5),
                      BoxShadow(
                          color: Colors.green.shade200,
                          offset: Offset(-1, 2),
                          blurRadius: 5)
                    ]),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                      child: TextButton(
                    child: Text("Clear"),
                    onPressed: () {
                      textEditingController.clear();
                    },
                  )),
                  Flexible(
                    child: TextButton(
                      child: Text("Login now"),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LoginScreen()));
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
