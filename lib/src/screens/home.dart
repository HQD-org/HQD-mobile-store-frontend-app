import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:mobile_store/src/common/shared_preference_user.dart';
import 'package:mobile_store/src/providers/user_provider.dart';
import 'package:mobile_store/src/repository/user_repo.dart';
import 'package:mobile_store/src/screens/cart/cart_screen.dart';
import 'package:mobile_store/src/screens/favorite_screen.dart';
import 'package:mobile_store/src/screens/home_screen.dart';
import 'package:mobile_store/src/screens/list_user_screen.dart';
import 'package:mobile_store/src/screens/login_screen.dart';
import 'package:mobile_store/src/screens/profile_screen.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _index = 2;
  String userName = "a"; //lấy UserName của current user
  String userEmail = "a";
  Icon cusIcon = Icon(Icons.search);
  Widget cusSearchBar = Text("HQR Mobile");
  Widget child = Text("CMM");
  double _drawerIconSize = 24;

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
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable

    switch (_index) {
      case 0:
        child = ListUserScreen(); // list
        break;
      case 1:
        child = FavoriteScreent(); // profile
        break;
      case 2:
        child = HomeScreen(); // yêu thích
        break;
      case 3:
        child = Text("Thông tin về HQD"); // yêu thích
        break;
      default:
        child = Text('Liên lạc với chúng tôi'); // giỏ hàng
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
                      },
                      icon: Icon(Icons.search),
                    ),
                  ),
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
                Icon(Icons.filter_list_alt),
                SizedBox(
                  width: 10.0,
                ),
                IconButton(
                  onPressed: () {
                    print("Giỏ hàng");
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => CartScreen()));
                  },
                  icon: Icon(Icons.shopping_cart),
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
                  print("Chuyển đến Trang cá nhân");
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ProfileScreen()));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.people,
                  size: _drawerIconSize,
                  color: Colors.purple.withOpacity(0.8),
                ),
                title: Text(
                  "Giỏ hàng",
                  style: TextStyle(
                      fontSize: 17, color: Colors.purple.withOpacity(0.8)),
                ),
                onTap: () {
                  print("Chuyển đến Trang cá nhân");
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => CartScreen()));
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
                  print("Chuyển đến Trang Login");
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
          Container(
            margin: EdgeInsets.all(3.0),
            child: FloatingActionButton(
              heroTag: null,
              onPressed: () {
                print('message here');
              },
              child: Icon(
                Icons.message,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(3.0),
            child: FloatingActionButton(
              heroTag: null,
              onPressed: () {
                print('Notification herea');
              },
              child: Icon(
                Icons.notifications,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.react,
        backgroundColor: Colors.green[200],
        items: [
          TabItem(icon: Icons.list, title: "Lịch sử"),
          TabItem(icon: Icons.favorite_border, title: "Yêu thích"),
          TabItem(icon: Icons.home, title: "Home"),
          TabItem(icon: Icons.info_rounded, title: "Thông tin"),
          TabItem(icon: Icons.contact_mail, title: "Liên lạc"),
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