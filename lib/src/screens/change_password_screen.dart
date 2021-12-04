import 'package:flutter/material.dart';
import 'package:mobile_store/src/common/shared_preference_user.dart';
import 'package:mobile_store/src/common/theme_helper.dart';
import 'package:mobile_store/src/repository/authentication_repository.dart';
import 'package:mobile_store/src/screens/login_screen.dart';
import 'package:mobile_store/src/widgets/header_widget.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ChangePasswordScreenState();
  }
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController oldPassword = new TextEditingController();
  TextEditingController newPassword = new TextEditingController();
  TextEditingController comfirmPassword = new TextEditingController();
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
                    HeaderWidget(_headerHeight, true, Icons.security_rounded),
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
                              'Đổi mật khẩu',
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
                              'Nhập mật khẩu cũ và cung cấp mật khẩu mới',
                              style: TextStyle(
                                  // fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                              // textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30.0),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: TextFormField(
                                decoration: ThemeHelper().textInputDecoration(
                                    "Mật khẩu cũ", "Nhập mật khẩu cũ"),
                                controller: oldPassword,
                                obscureText: true,
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "Vui lòng nhập mật khẩu cũ";
                                  } else if (!RegExp(
                                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$')
                                      .hasMatch(val)) {
                                    return "Mật khẩu cũ sai";
                                  }
                                  return null;
                                },
                              ),
                              decoration:
                                  ThemeHelper().inputBoxDecorationShaddow(),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              child: TextFormField(
                                decoration: ThemeHelper().textInputDecoration(
                                    "Mật khẩu mới", "Nhập mật khẩu mới"),
                                controller: newPassword,
                                obscureText: true,
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "Vui lòng nhập mật khẩu mới";
                                  } else if (!RegExp(
                                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$')
                                      .hasMatch(val)) {
                                    return "Mật khẩu sai định dạng";
                                  }
                                  return null;
                                },
                              ),
                              decoration:
                                  ThemeHelper().inputBoxDecorationShaddow(),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              child: TextFormField(
                                decoration: ThemeHelper().textInputDecoration(
                                    "Nhập lại mật khẩu", "Nhập lại mật khẩu"),
                                controller: comfirmPassword,
                                obscureText: true,
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "Vui lòng nhập lại mật khẩu";
                                  } else if (!RegExp(
                                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$')
                                      .hasMatch(val)) {
                                    return "Mật khẩu sai định dạng";
                                  } else if (val != newPassword.text) {
                                    return "Nhập lại mật khẩu không trùng khớp";
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
                                    "Đổi mật khẩu".toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    // call API change-Password
                                    var status =
                                        await AuthenticationRepository()
                                            .changePassAPI(
                                                oldPassword: oldPassword.text,
                                                newPassword: newPassword.text);
                                    if (status.statusCode == 200) {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text(
                                                  'Đổi mật khẩu thành công'),
                                              content: Text(
                                                  'Bấm "OK" để đăng nhập lại '),
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
                                                    UserSharedPreference
                                                        .clearAccessToken();
                                                    Navigator.of(context)
                                                        .pushAndRemoveUntil(
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        LoginScreen()),
                                                            (route) => false);
                                                  },
                                                ),
                                              ],
                                            );
                                          });
                                    } else if (status.statusCode == 404) {
                                      // tài khoản không tồn tại
                                      snackBar("Tài khoản không tồn tại");
                                    } else if (status.statusCode == 403) {
                                      // sai mật khẩu cũ
                                      snackBar("Sai mật khẩu cũ");
                                    } else {
                                      // lỗi gì đó thì server
                                      snackBar("Lỗi server API");
                                    }
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
