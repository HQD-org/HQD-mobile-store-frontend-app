import 'package:flutter/material.dart';

import 'package:dropdown_search/dropdown_search.dart';

import 'package:mobile_store/src/common/theme_helper.dart';
import 'package:mobile_store/src/controllers/location_controller.dart';

import 'package:mobile_store/src/models/district.dart';
import 'package:mobile_store/src/models/province.dart';
import 'package:mobile_store/src/models/user_model.dart';
import 'package:mobile_store/src/models/village.dart';
import 'package:mobile_store/src/providers/user_provider.dart';
import 'package:mobile_store/src/repository/authentication_repository.dart';
import 'package:mobile_store/src/repository/user_repo.dart';
import 'package:mobile_store/src/screens/profile_screen.dart';
import 'package:mobile_store/src/widgets/dialog_loading.dart';

import 'package:mobile_store/src/widgets/header_widget.dart';

class UpdateInfoScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UpdateInfoScreenState();
  }
}

class _UpdateInfoScreenState extends State<UpdateInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  bool checkedValue = false;
  bool checkboxValue = false;
  TextEditingController name = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  TextEditingController addressDetail = new TextEditingController();
  String province = "null";
  String district = "null";
  String village = "null";

  String idProvince = "";
  String idDistrict = "";

  bool isSelectedProvince = false;
  bool isSelectedDistrict = false;

  late UserModel user;

  @override
  void initState() {
    super.initState();
    user = userProvider.getUser!;
    name.text = user.name;
    addressDetail.text = user.address.detail;
    phone.text = user.phone;
  }

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
              child: HeaderWidget(150, false, Icons.security_update_good),
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
                            decoration: ThemeHelper().textInputDecoration(
                                'Fullname', 'Enter your Fullname'),
                            controller: name,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Enter fullname';
                              }
                              if (!RegExp('^[a-zA-Z]').hasMatch(val)) {
                                return 'Invalid fullname';
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
                                'Address', 'Enter your Address'),
                            controller: addressDetail,
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: DropdownSearch<Province>(
                            dropdownBuilderSupportsNullItem: true,
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
                            dropdownBuilderSupportsNullItem: true,
                            enabled: isSelectedProvince == true ? true : false,
                            showSelectedItems: true,
                            compareFn: (i, s) => i?.isEqual(s!) ?? false,
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
                            dropdownBuilderSupportsNullItem: true,
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
                                "Mobile Number", "Enter your mobile number"),
                            controller: phone,
                            keyboardType: TextInputType.phone,
                            validator: (val) {
                              if ((val!.isEmpty) &&
                                  !RegExp(r"^(\d+)*$").hasMatch(val)) {
                                return "Enter a valid phone number";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
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
                                  "Update".toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  showDialogLoading(context);
                                  var status = await AuthenticationRepository()
                                      .updateProfile(
                                          fullName: name.text,
                                          detail: addressDetail.text,
                                          province: province,
                                          district: district,
                                          village: village,
                                          phone: phone.text);
                                  Navigator.pop(context);
                                  if (status.statusCode == 200) {
                                    await UserRepository()
                                        .getMyProfile()
                                        .then((user) {
                                      if (user != null) {
                                        userProvider.setUser = user;
                                      }
                                    });
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProfileScreen()));
                                  } else if (status.statusCode == 404) {
                                    snackBar("Không tìm thầy user");
                                  } else {
                                    snackBar("Lỗi API");
                                  }
                                }
                              }),
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
}
