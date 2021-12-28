import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_store/src/common/theme_helper.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_store/src/models/user_model.dart';
import 'package:mobile_store/src/providers/user_provider.dart';

class FeedbackScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FeedbackScreenState();
  }
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  String myFeedBackText = "Tệ quá";
  var sliderValue = 0.0;
  IconData myFeedBack = FontAwesomeIcons.sadCry;
  Color myFeedBackColor = Colors.red;
  TextEditingController question = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  late UserModel user;

  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    user = userProvider.getUser!;
  }

  Future sendMail(
      {required String name,
      required String email,
      required String phone,
      required String message}) async {
    var dataBody = {
      "service_id": "service_xt8mo7t",
      "template_id": "template_n8l8lls",
      "user_id": "user_ZmPJ09VlYiQSQV0QsH8pN",
      "template_params": {
        "email": email,
        "fullname": name,
        "message": message,
        "sdt": phone,
        "to_email": "hqdmobilestorecontact@gmail.com"
      }
    };
    final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'origin': 'http://localhost'
        },
        body: jsonEncode(dataBody));
    print("sendmail: " + response.body);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Container(
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Container(
                  child: Text(
                    "Bạn thấy dịch vụ của chúng tôi tốt không? Mời bạn đánh giá",
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Container(
              child: Align(
                child: Material(
                  color: Colors.white,
                  elevation: 12.0,
                  borderRadius: BorderRadius.circular(24.0),
                  shadowColor: Color(0x802196F3),
                  child: Container(
                    height: 550.0,
                    width: 350.0,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(14.0),
                          child: Container(
                            child: Text(
                              myFeedBackText,
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            myFeedBack,
                            color: myFeedBackColor,
                            size: 80.0,
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Container(
                              child: Slider(
                                value: sliderValue,
                                min: 0.0,
                                max: 5.0,
                                divisions: 5,
                                activeColor: Color(0xfffff520d),
                                onChanged: (newValue) {
                                  setState(() {
                                    sliderValue = newValue;
                                    if (sliderValue >= 0.0 &&
                                        sliderValue <= 1.0) {
                                      myFeedBack = FontAwesomeIcons.sadCry;
                                      myFeedBackColor = Colors.red;
                                      myFeedBackText = "Quá tệ";
                                    }
                                    if (sliderValue >= 1.1 &&
                                        sliderValue <= 2.0) {
                                      myFeedBack = FontAwesomeIcons.frown;
                                      myFeedBackColor = Colors.yellow;
                                      myFeedBackText = "Không tốt";
                                    }
                                    if (sliderValue >= 2.1 &&
                                        sliderValue <= 3.0) {
                                      myFeedBack = FontAwesomeIcons.meh;
                                      myFeedBackColor = Colors.amber;
                                      myFeedBackText = "Bình thường";
                                    }
                                    if (sliderValue >= 3.1 &&
                                        sliderValue <= 4.0) {
                                      myFeedBack = FontAwesomeIcons.smile;
                                      myFeedBackColor = Colors.green.shade400;
                                      myFeedBackText = "Cũng được";
                                    }
                                    if (sliderValue >= 4.1 &&
                                        sliderValue <= 5.0) {
                                      myFeedBack = FontAwesomeIcons.laugh;
                                      myFeedBackColor = Colors.green.shade600;
                                      myFeedBackText = "Quá tốt";
                                    }
                                  });
                                },
                              ),
                            )),
                        Padding(
                          padding: EdgeInsets.all(14.0),
                          child: Container(
                            child: Text(
                              "Đánh giá: $sliderValue",
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(14.0),
                          child: Container(
                            child: TextField(
                              keyboardType: TextInputType.multiline,
                              minLines: 1,
                              maxLines: 3,
                              controller: question,
                              decoration: ThemeHelper().textInputDecoration(
                                  'Nhập câu hỏi', 'Thắc mắc'),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(14.0),
                          child: Container(
                            child: TextField(
                              controller: phone,
                              decoration: ThemeHelper().textInputDecoration(
                                  'Số điện thoại', 'Phone'),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Container(
                              child: Align(
                            alignment: Alignment.bottomCenter,
                            child: ElevatedButton(
                              onPressed: () async {
                                sendMail(
                                    email: user.email,
                                    message:
                                        "Đánh giá: $sliderValue .Câu hỏi: " +
                                            question.text,
                                    name: user.name,
                                    phone: phone.text);
                                snackBar("Gửi đánh giá thành công");
                              },
                              child: Text(
                                "Gửi",
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.orange,
                              ),
                            ),
                          )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
