import 'package:flutter/material.dart';
import 'package:mobile_store/src/common/theme_helper.dart';
import 'package:mobile_store/src/screens/forgot_password_screen.dart';
import 'package:mobile_store/src/screens/profile_screen.dart';
import 'package:mobile_store/src/screens/registration_screen.dart';
import 'package:mobile_store/src/widgets/header_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  var _headerHeight = 250.0;
  Key _formKey = GlobalKey<FormState>();
  TextEditingController email = new TextEditingController();
  TextEditingController pass = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
                            TextField(
                              controller: email,
                              decoration: ThemeHelper()
                                  .textInputDecoration("Email", "Enter Email"),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            TextField(
                              controller: pass,
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
                                onPressed: () {
                                  print("email: " + email.text);
                                  print("Password: " + pass.text);
                                  // chuyển sang trang Profile
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ProfileScreen()));
                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(15.0),
                              child: GestureDetector(
                                child: Text("Forgot Password"),
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
                                child: Text("Don't have an account? Create"),
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
