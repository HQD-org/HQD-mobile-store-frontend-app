import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_store/src/common/theme_helper.dart';
import 'package:mobile_store/src/controllers/location_controller.dart';
import 'package:mobile_store/src/models/district.dart';
import 'package:mobile_store/src/models/province.dart';
import 'package:mobile_store/src/models/village.dart';
import 'package:mobile_store/src/screens/login_screen.dart';

import 'package:mobile_store/src/screens/vetification_screen.dart';
import 'package:mobile_store/src/widgets/header_widget.dart';
import 'package:http/http.dart' as http;

class RegistrationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegistrationScreenState();
  }
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  bool checkedValue = false;
  bool checkboxValue = false;
  TextEditingController name = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  TextEditingController addressDetail = new TextEditingController();
  TextEditingController pass = new TextEditingController();
  TextEditingController confirmPass = new TextEditingController();
  String province = "";
  String district = "";
  String village = "";

  String idProvince = "";
  String idDistrict = "";
  bool _isObscure = true;
  bool _isObscureConfirm = true;
  bool isSelectedProvince = false;
  bool isSelectedDistrict = false;

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
        child: Stack(
          children: [
            Container(
              height: 150,
              child: HeaderWidget(150, false, Icons.person_add_alt_1_rounded),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(25, 50, 25, 10),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        GestureDetector(
                          child: Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border:
                                      Border.all(width: 5, color: Colors.white),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 20,
                                      offset: const Offset(5, 5),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.black26,
                                  size: 80.0,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(80, 80, 0, 0),
                                child: Icon(
                                  Icons.add_circle,
                                  color: Colors.grey.shade700,
                                  size: 25.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          child: TextFormField(
                            decoration: ThemeHelper()
                                .textInputDecoration('Họ tên', 'Nhập họ tên'),
                            controller: name,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Nhập họ tên';
                              }
                              if (!RegExp('^[a-zA-Z]').hasMatch(val)) {
                                return 'Họ tên sai định dạng, nhập lại';
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          child: TextFormField(
                            decoration: ThemeHelper()
                                .textInputDecoration('Địa chỉ', 'Nhập địa chỉ'),
                            controller: addressDetail,
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: DropdownSearch<Province>(
                            showSelectedItems: true,
                            compareFn: (i, s) => i?.isEqual(s!) ?? false,
                            dropdownSearchDecoration: ThemeHelper()
                                .textInputDecorationDrop(
                                    "Chọn tỉnh thành", " "),
                            // ignore: non_constant_identifier_names
                            onFind: (String) => LocationController()
                                .getProvince(), //(String? filter) => getData(filter),
                            onChanged: (data) {
                              //print(data!.code);
                              setState(() {
                                idProvince = data!.code;
                                province = data.nameWithType;
                                isSelectedProvince = true;
                              });
                            },
                            showSearchBox: true,
                            validator: (data) {
                              if (data == null) {
                                return "Chọn tỉnh thành";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          child: DropdownSearch<District>(
                            showSelectedItems: true,
                            compareFn: (i, s) => i?.isEqual(s!) ?? false,
                            enabled: isSelectedProvince == true ? true : false,
                            dropdownSearchDecoration: ThemeHelper()
                                .textInputDecorationDrop(
                                    "Chọn huyện/thành phố", " "),
                            // ignore: non_constant_identifier_names
                            onFind: (String) {
                              return LocationController()
                                  .getDistrict(idProvince);
                            }, //(String? filter) => getData(filter),
                            onChanged: (data) {
                              // print(data!.code);
                              setState(() {
                                idDistrict = data!.code;
                                district = data.nameWithType;
                                isSelectedDistrict = true;
                              });
                            },
                            showSearchBox: true,
                            validator: (data) {
                              if (data == null) {
                                return "Chọn huyện/thành phố";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          child: DropdownSearch<Village>(
                            showSelectedItems: true,
                            enabled: isSelectedDistrict == true ? true : false,
                            compareFn: (i, s) => i?.isEqual(s!) ?? false,
                            dropdownSearchDecoration: ThemeHelper()
                                .textInputDecorationDrop("Chọn xã/phường", " "),
                            // ignore: non_constant_identifier_names
                            onFind: (String) => LocationController().getVillage(
                                idDistrict), //(String? filter) => getData(filter),
                            onChanged: (data) {
                              //print(data!.code);
                              setState(() {
                                idDistrict = data!.code;
                                village = data.nameWithType;
                              });
                            },
                            showSearchBox: true,
                            validator: (data) {
                              if (data == null) {
                                return "Chọn xã/phường";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration(
                                "Email", "Nhập địa chỉ Email"),
                            controller: email,
                            keyboardType: TextInputType.emailAddress,
                            validator: (val) {
                              // if ((val!.isEmpty) &&
                              //     !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                              //             r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                              //             r"{0,253}[a-zA-Z0-9])?)*$")
                              //         .hasMatch(val)) {
                              //   return "Enter a valid email address";
                              // }
                              // return null;
                              bool _isvalid = EmailValidator.validate(val!);
                              var result;
                              _isvalid
                                  ? result = null
                                  : result = "Địa chỉ Email không đúng";
                              return result;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration(
                                "Số điện thoại", "Nhập số điện thoại"),
                            controller: phone,
                            keyboardType: TextInputType.phone,
                            validator: (val) {
                              if ((val!.isEmpty) &&
                                  !RegExp(r"^(\d+)*$").hasMatch(val)) {
                                return "Số điện thoại không đúng";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            obscureText: _isObscure,
                            controller: pass,
                            decoration: InputDecoration(
                              labelText: "Mật khẩu",
                              hintText: "Nhập mật khẩu",
                              filled: true,
                              contentPadding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100.0),
                                  borderSide: BorderSide(color: Colors.grey)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100.0),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade400)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100.0),
                                  borderSide: BorderSide(
                                      color: Colors.red, width: 2.0)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100.0),
                                  borderSide: BorderSide(
                                      color: Colors.red, width: 2.0)),
                              suffixIcon: IconButton(
                                icon: Icon(_isObscure
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    _isObscure = !_isObscure;
                                  });
                                },
                              ),
                            ),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Vui lòng nhập mật khẩu";
                              }
                              if ((!RegExp(
                                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$')
                                  .hasMatch(val))) {
                                return "Mật khẩu sai định dạng";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            obscureText: _isObscureConfirm,
                            controller: confirmPass,
                            decoration: InputDecoration(
                              labelText: "Nhập lại mật khẩu",
                              hintText: "Nhập lại mật khẩu",
                              filled: true,
                              contentPadding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100.0),
                                  borderSide: BorderSide(color: Colors.grey)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100.0),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade400)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100.0),
                                  borderSide: BorderSide(
                                      color: Colors.red, width: 2.0)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100.0),
                                  borderSide: BorderSide(
                                      color: Colors.red, width: 2.0)),
                              suffixIcon: IconButton(
                                icon: Icon(_isObscureConfirm
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    _isObscureConfirm = !_isObscureConfirm;
                                  });
                                },
                              ),
                            ),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Vui lòng nhập lại mật khẩu";
                              }
                              if ((!RegExp(
                                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$')
                                  .hasMatch(val))) {
                                return "Mật khẩu sai định dạng";
                              }
                              if (val != pass.text) {
                                return "Nhập lại mật khẩu không đúng";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        FormField<bool>(
                          builder: (state) {
                            return Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Checkbox(
                                        value: checkboxValue,
                                        onChanged: (value) {
                                          setState(() {
                                            checkboxValue = value!;
                                            state.didChange(value);
                                          });
                                        }),
                                    Text(
                                      "Tôi đồng ý các điều kiện",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    state.errorText ?? '',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Theme.of(context).errorColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                          validator: (value) {
                            if (!checkboxValue) {
                              return 'Bạn phải đồng ý các điều kiện';
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          decoration:
                              ThemeHelper().buttonBoxDecoration(context),
                          child: ElevatedButton(
                            style: ThemeHelper().buttonStyle(),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(40, 10, 40, 10),
                              child: Text(
                                "Đăng ký".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                var status = await registerAPI();
                                if (status.statusCode == 409 ||
                                    status.statusCode == 400) {
                                  snackBar('Email or Phone is exist');
                                } else if (status.statusCode == 200) {
                                  print("Register success");
                                  showDialog(
                                      context: context,
                                      builder: (contex) {
                                        return AlertDialog(
                                          title: Text('Register Successful'),
                                          content: Text(
                                              'Press "OK" to verify Account'),
                                          actions: [
                                            TextButton(
                                              child: Text(
                                                "OK",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Colors.black38)),
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            PinCodeVerificationScreen(
                                                                email.text)));
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                }
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 30.0),
                        GestureDetector(
                          child: Text(
                            "Have an account! Login now",
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                          },
                        ),
                        SizedBox(height: 25.0),
                        Text(
                          "Or create account using social media",
                          style: TextStyle(color: Colors.black),
                        ),
                        SizedBox(height: 25.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              child: FaIcon(
                                FontAwesomeIcons.googlePlus,
                                size: 35,
                                color: HexColor("#EC2D2F"),
                              ),
                              onTap: () {
                                setState(() {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return ThemeHelper().alartDialog(
                                          "Google Plus",
                                          "You tap on GooglePlus social icon.",
                                          context);
                                    },
                                  );
                                });
                              },
                            ),
                            SizedBox(
                              width: 30.0,
                            ),
                            GestureDetector(
                              child: Container(
                                padding: EdgeInsets.all(0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                      width: 5, color: HexColor("#40ABF0")),
                                  color: HexColor("#40ABF0"),
                                ),
                                child: FaIcon(
                                  FontAwesomeIcons.twitter,
                                  size: 23,
                                  color: HexColor("#FFFFFF"),
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return ThemeHelper().alartDialog(
                                          "Twitter",
                                          "You tap on Twitter social icon.",
                                          context);
                                    },
                                  );
                                });
                              },
                            ),
                            SizedBox(
                              width: 30.0,
                            ),
                            GestureDetector(
                              child: FaIcon(
                                FontAwesomeIcons.facebook,
                                size: 35,
                                color: HexColor("#3E529C"),
                              ),
                              onTap: () {
                                setState(() {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return ThemeHelper().alartDialog(
                                          "Facebook",
                                          "You tap on Facebook social icon.",
                                          context);
                                    },
                                  );
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // gọi API auth/register đăng ký tài khoản
  Future<http.Response> registerAPI() async {
    var url = 'hqd-mobile-store-api.herokuapp.com';
    Map dataBody = {
      "email": email.text,
      "phone": phone.text,
      "name": name.text,
      "password": pass.text,
      "address": {
        "detail": addressDetail.text,
        "village": village,
        "district": district,
        "province": province,
      }
    };
    var response = await http.post(Uri.https(url, "/auth/register"),
        body: jsonEncode(dataBody),
        headers: {
          "Content-type": "application/json",
          "Accept": "application/json",
        });

    print("Data status: ${response.statusCode}");
    //print(h);
    return response;
  }
}
