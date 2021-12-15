import 'package:flutter/material.dart';
import 'package:mobile_store/src/models/order_model.dart';
import 'package:mobile_store/src/repository/order_repository.dart';
import 'package:mobile_store/src/widgets/order_card_widget.dart';

class HistoryOrderScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HistoryOrderScreenState();
  }
}

class _HistoryOrderScreenState extends State<HistoryOrderScreen> {
  bool isLoading = true;
  List<OrderModel> list1 = [];
  List<OrderModel> list2 = [];
  List<OrderModel> list3 = [];
  List<OrderModel> list4 = [];
  List<OrderModel> list5 = [];
  getDataOrder() async {
    var data1 = await OrderRepository().getDataOrderAPI("status=wait");
    var data2 = await OrderRepository().getDataOrderAPI("status=confirmed");
    var data3 = await OrderRepository().getDataOrderAPI("status=delivering");
    var data4 = await OrderRepository().getDataOrderAPI("status=delivered");
    var data5 = await OrderRepository().getDataOrderAPI("status=cancel");

    if (data1 != null) {
      data1.forEach((element) {
        list1.add(element);
      });
    }
    if (data2 != null) {
      data2.forEach((element) {
        list2.add(element);
      });
    }
    if (data3 != null) {
      data3.forEach((element) {
        list3.add(element);
      });
    }
    if (data4 != null) {
      data4.forEach((element) {
        list4.add(element);
      });
    }
    if (data5 != null) {
      data5.forEach((element) {
        list5.add(element);
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getDataOrder();
  }

  // wiget Chờ lấy hàng
  Widget state1(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 5.0, top: 10.0),
            child: Row(
              children: [
                Text(
                  "Các đơn hàng đang chờ duyệt",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 600,
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemBuilder: (context, index) {
                      return OrderCard(
                        order: list1[index],
                      );
                    },
                    itemCount: list1.length,
                  ),
          )
        ],
      ),
    );
  }

  // wiget Chờ lấy hàng
  Widget state2(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 5.0, top: 10.0),
            child: Row(
              children: [
                Text(
                  "Các đơn hàng đang chờ lấy hàng",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 600,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return OrderCard(
                  order: list2[index],
                );
              },
              itemCount: list2.length,
            ),
          )
        ],
      ),
    );
  }

  // widget đang giao
  Widget state3(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 5.0, top: 10.0),
            child: Row(
              children: [
                Text(
                  "Các đơn hàng đang vận chuyển",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 600,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return OrderCard(
                  order: list3[index],
                );
              },
              itemCount: list3.length,
            ),
          )
        ],
      ),
    );
  }

  // widget đã giao
  Widget state4(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 5.0, top: 10.0),
            child: Row(
              children: [
                Text(
                  "Các đơn hàng đang đã giao",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 600,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return OrderCard(
                  order: list4[index],
                );
              },
              itemCount: list4.length,
            ),
          )
        ],
      ),
    );
  }

  // widget Đã hủy
  Widget state5(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 5.0, top: 10.0),
            child: Row(
              children: [
                Text(
                  "Các đơn hàng đã hủy",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 600,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return OrderCard(
                  order: list5[index],
                );
              },
              itemCount: list5.length,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Lịch sử mua hàng",
            style: TextStyle(color: Colors.white),
          ),
          elevation: 20,
          titleSpacing: 20,
          bottom: TabBar(
            labelColor: Colors.white,
            indicatorColor: Colors.red,
            tabs: [
              Tab(
                icon: Icon(Icons.history),
                text: "Chờ xác nhận",
              ),
              Tab(
                icon: Icon(Icons.lock_clock_rounded),
                text: "Chờ lấy hàng",
              ),
              Tab(
                icon: Icon(Icons.bike_scooter),
                text: "Đang giao",
              ),
              Tab(
                icon: Icon(Icons.check_circle),
                text: "Đã giao",
              ),
              Tab(
                icon: Icon(Icons.cancel),
                text: "Đã hủy",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            state1(context),
            state2(context),
            state3(context),
            state4(context),
            state5(context)
          ],
        ),
      ),
    );
  }
}
