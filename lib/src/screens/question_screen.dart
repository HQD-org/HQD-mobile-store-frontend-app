import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:mobile_store/src/models/question_model.dart';
import 'package:mobile_store/src/repository/question_repository.dart';

class QuestionScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _QuestionScreenState();
  }
}

class _QuestionScreenState extends State<QuestionScreen> {
  bool isLoading = true;
  List<QuestionModel>? listQuestion;
  getDataQuestion() async {
    listQuestion = await QuestionRepository().getAllQuestionAPI();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getDataQuestion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Các câu hỏi",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
              height: MediaQuery.of(context).size.height / 3,
              alignment: Alignment.center,
              child: Image.asset(
                'asset/intro/shopping.png',
                fit: BoxFit.cover,
              )),
          SizedBox(
            width: 10.0,
          ),
          Container(
            padding: EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Nơi thảo luận",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(5.0),
            child: Text(
              "Trong quá trình sử dụng app chắc các quý khách cũng gặp nhiều khó khăn trong qua trình sử dụng! Đây sẽ là nơi trả lời các câu hỏi của khách hàng trong qua trình sử dụng app",
              style: TextStyle(fontSize: 17.0),
            ),
          ),
          Container(
            padding: EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Các câu hỏi thường gặp",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width - 100,
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 0.8, color: Colors.black)),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width - 50.0,
              height: 700,
              child: isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemBuilder: (context, index) {
                        return Container(
                          width: MediaQuery.of(context).size.width - 100,
                          padding: EdgeInsets.all(5.0),
                          margin:
                              EdgeInsets.only(top: 10.0, right: 5.0, left: 5.0),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 0.8,
                                  color: index % 2 == 0
                                      ? Colors.green
                                      : Colors.orange),
                              borderRadius: BorderRadius.circular(8.0)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Câu hỏi: " +
                                    listQuestion![index].questionSentence,
                                style: TextStyle(fontSize: 16.5),
                              ),
                              SizedBox(
                                height: 3.5,
                              ),
                              Text(
                                "Trả lời: " + listQuestion![index].answer,
                                style: TextStyle(fontSize: 16.5),
                              )
                            ],
                          ),
                        );
                      },
                      itemCount: listQuestion!.length,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                    )),
        ],
      )),
    );
  }
}
