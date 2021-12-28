import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:mobile_store/src/common/shared_preference_user.dart';
import 'package:mobile_store/src/models/branch_model.dart';
import 'package:mobile_store/src/models/cart_model.dart';
import 'package:mobile_store/src/providers/user_provider.dart';
import 'package:mobile_store/src/repository/branch_repository.dart';
import 'package:mobile_store/src/repository/cart_repository.dart';
import 'package:mobile_store/src/repository/user_repo.dart';
import 'package:mobile_store/src/screens/Order/history_order_screen.dart';
import 'package:mobile_store/src/screens/cart/cart_screen.dart';
import 'package:mobile_store/src/screens/favorite_screen.dart';
import 'package:mobile_store/src/screens/feedback/feedback_screen.dart';
import 'package:mobile_store/src/screens/home_screen.dart';
import 'package:mobile_store/src/screens/list_user_screen.dart';
import 'package:mobile_store/src/screens/login_screen.dart';
import 'package:mobile_store/src/screens/profile_screen.dart';
import 'package:mobile_store/src/screens/question_screen.dart';
import 'package:mobile_store/src/screens/search_by_price_screen.dart';
import 'package:mobile_store/src/screens/search_screen.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

//enum choise { one, two, three }

class _MyHomePageState extends State<MyHomePage> {
  int _index = 2;
  String userName = "a"; //lấy UserName của current user
  String userEmail = "a";
  TextEditingController search = new TextEditingController();
  Icon cusIcon = Icon(Icons.search);
  Widget cusSearchBar = Text("HQR Mobile");
  Widget child = Text("CMM");
  double _drawerIconSize = 24;
  List<int> groupSelect = [1, 2, 3];
  int select = 1;
  double totalPrice = 0;
  @override
  void initState() {
    super.initState();
    UserRepository().getMyProfile().then((user) {
      if (user != null) {
        userProvider.setUser = user;
        setState(() {
          userName = user.name;
          userEmail = user.email;
        });
      }
    });
    getDataCart();
    getDataBranch();
  }

  @override
  void dispose() {
    super.dispose();
    search.dispose();
  }

  // mới thêm đoạn này nha
  getDataCart() async {
    var model = Provider.of<UserProvider>(context, listen: false);
    CartModel? cartModel = await CartRepository().getdataCartAPI();
    var dataPrice = cartModel!.products;
    dataPrice.forEach((e) {
      totalPrice = totalPrice + (e.price.toDouble() * e.quantity);
    });
    if (totalPrice > 0) {
      model.setHasCart = true;
    }
  }

  getDataBranch() async {
    var model = Provider.of<UserProvider>(context, listen: false);
    List<BranchModel> list = [];
    List<BranchModel>? getFromAPI = await BranchRepository().getDataBranch();
    getFromAPI!.forEach((element) {
      if (element.status == 'open') {
        list.add(element);
      }
    });
    if (list.length > 0) {
      model.setAllBranch = list;
    }
  }

  showFilterPrice(BuildContext context) => showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Tìm sản phẩm theo giá tiền'),
          content: Container(
            height: 300,
            child: Column(
              children: [
                ListTile(
                  title: Text('Nhỏ hơn 9.000.000 VNĐ'),
                  leading: Radio(
                      value: 1,
                      groupValue: select,
                      onChanged: (value) {
                        print(value);
                        setState(() {
                          select = 1;
                        });
                        Navigator.of(context).pop();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SearchByPriceScreen(
                                  selected: select,
                                )));
                      }),
                ),
                ListTile(
                  title: Text('9.000.000 - 20.000.000 VNĐ'),
                  leading: Radio(
                      value: 2,
                      groupValue: select,
                      onChanged: (value) {
                        print(value);
                        setState(() {
                          select = 2;
                        });
                        Navigator.of(context).pop();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SearchByPriceScreen(
                                  selected: select,
                                )));
                      }),
                ),
                ListTile(
                  title: Text('Lớn hơn 20.000.000 VNĐ'),
                  leading: Radio(
                      value: 3,
                      groupValue: select,
                      onChanged: (value) {
                        print(value);
                        setState(() {
                          select = 3;
                        });
                        Navigator.of(context).pop();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SearchByPriceScreen(
                                  selected: select,
                                )));
                      }),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                "Hủy",
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black38)),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      });
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable

    switch (_index) {
      case 0:
        child = ListUserScreen();
        break;
      case 1:
        child = FavoriteScreent();
        break;
      case 2:
        child = HomeScreen();
        break;
      case 3:
        child = Text("Thông tin của app");
        break;
      default:
        child = FeedbackScreen();
        break;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Container(
          padding: EdgeInsets.only(right: 3.0),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Tìm kiếm...",
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100.0),
                        borderSide: BorderSide(color: Colors.grey)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100.0),
                        borderSide: BorderSide(color: Colors.grey.shade400)),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100.0),
                        borderSide: BorderSide(color: Colors.red, width: 2.0)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100.0),
                        borderSide: BorderSide(color: Colors.red, width: 2.0)),
                    suffixIcon: IconButton(
                      onPressed: () {
                        print("Search nè");
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SearchScreen(
                                  searchText: search.text,
                                )));
                      },
                      icon: Icon(Icons.search),
                    ),
                  ),
                  controller: search,
                ),
              ),
            ],
          ),
        ),
        actions: [
          Container(
            padding: EdgeInsets.all(7.0),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    showFilterPrice(context);
                  },
                  icon: Icon(
                    Icons.filter_list_alt,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                IconButton(
                  onPressed: () {
                    print("Giỏ hàng");
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => CartScreen()));
                  },
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  Theme.of(context).accentColor.withOpacity(0.2),
                  Colors.white
                ]),
          ),
          child: ListView(
            children: [
              DrawerHeader(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[
                          Theme.of(context).primaryColor.withOpacity(0.2),
                          Theme.of(context).accentColor.withOpacity(0.7)
                        ]),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 50.0,
                        width: 50.0,
                        child: CircleAvatar(
                          backgroundImage: AssetImage("asset/banner/avata.jpg"),
                        ),
                      ),
                      SizedBox(
                        height: 7.0,
                      ),
                      Container(
                        child: Text(
                          "Xin chào, $userName",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 7.0,
                      ),
                      Container(
                        child: Text(
                          "$userEmail",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )),
              ListTile(
                leading: Icon(
                  Icons.home,
                  size: _drawerIconSize,
                  color: Colors.purple.withOpacity(0.8),
                ),
                title: Text(
                  "Home Page",
                  style: TextStyle(
                      fontSize: 17, color: Colors.purple.withOpacity(0.8)),
                ),
                onTap: () {
                  print("Chuyển đến Home Page");
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.people,
                  size: _drawerIconSize,
                  color: Colors.purple.withOpacity(0.8),
                ),
                title: Text(
                  "Trang cá nhân",
                  style: TextStyle(
                      fontSize: 17, color: Colors.purple.withOpacity(0.8)),
                ),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ProfileScreen()));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.history_edu,
                  size: _drawerIconSize,
                  color: Colors.purple.withOpacity(0.8),
                ),
                title: Text(
                  "Lịch sử mua hàng",
                  style: TextStyle(
                      fontSize: 17, color: Colors.purple.withOpacity(0.8)),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => HistoryOrderScreen()));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.shopping_bag,
                  size: _drawerIconSize,
                  color: Colors.purple.withOpacity(0.8),
                ),
                title: Text(
                  "Giỏ hàng",
                  style: TextStyle(
                      fontSize: 17, color: Colors.purple.withOpacity(0.8)),
                ),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => CartScreen()));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.info,
                  size: _drawerIconSize,
                  color: Colors.purple.withOpacity(0.8),
                ),
                title: Text(
                  "Câu hỏi",
                  style: TextStyle(
                      fontSize: 17, color: Colors.purple.withOpacity(0.8)),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => QuestionScreen()));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.logout,
                  size: _drawerIconSize,
                  color: Colors.purple.withOpacity(0.8),
                ),
                title: Text(
                  "Thoát",
                  style: TextStyle(
                      fontSize: 17, color: Colors.purple.withOpacity(0.8)),
                ),
                onTap: () {
                  UserSharedPreference.clearAccessToken();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                      (route) => false);
                },
              ),
            ],
          ),
        ),
      ),
      body: child,
      floatingActionButton: Wrap(
        direction: Axis.vertical,
        children: [
          // Container(
          //   margin: EdgeInsets.all(3.0),
          //   child: FloatingActionButton(
          //     heroTag: null,
          //     backgroundColor: Colors.blue,
          //     onPressed: () {
          //       print('message here');
          //     },
          //     child: Icon(
          //       Icons.message,
          //       color: Colors.white,
          //     ),
          //   ),
          // ),
          Container(
            margin: EdgeInsets.only(top: 10, right: 10),
            child: Stack(
              children: [
                FloatingActionButton(
                  heroTag: null,
                  backgroundColor: Colors.blue,
                  onPressed: () {
                    print('message here');
                  },
                  child: Icon(
                    Icons.message,
                    color: Colors.white,
                  ),
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints:
                        BoxConstraints(minWidth: 14.0, minHeight: 14.0),
                    child: Text(
                      "1",
                      style: TextStyle(color: Colors.white, fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10, right: 10),
            child: Stack(
              children: [
                FloatingActionButton(
                  heroTag: null,
                  backgroundColor: Colors.orange[400],
                  onPressed: () {
                    print('Notification herea');
                  },
                  child: Icon(
                    Icons.notifications,
                    color: Colors.white,
                  ),
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints:
                        BoxConstraints(minWidth: 14.0, minHeight: 14.0),
                    child: Text(
                      "1",
                      style: TextStyle(color: Colors.white, fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.react,
        backgroundColor: Colors.purple[400],
        items: [
          TabItem(
              icon: Icon(
                Icons.list,
                color: Colors.white,
              ),
              title: "Lịch sử"),
          TabItem(
              icon: Icon(Icons.favorite_border, color: Colors.white),
              title: "Yêu thích"),
          TabItem(
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              title: "Home"),
          TabItem(
              icon: Icon(
                Icons.info_rounded,
                color: Colors.white,
              ),
              title: "Thông tin"),
          TabItem(
              icon: Icon(
                Icons.contact_mail,
                color: Colors.white,
              ),
              title: "Liên lạc"),
        ],
        initialActiveIndex: 2,
        onTap: (int i) {
          print('click index = $i');
          setState(() {
            _index = i;
          });
        },
      ),
    );
  }
}

/*bottomNavigationBar: BottomNavigationBar(
          onTap: (newIndex) => setState(() => _index = newIndex),
          currentIndex: _index,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_balance), label: "You"),
            BottomNavigationBarItem(icon: Icon(Icons.list), label: "About")
          ]), */

/* */