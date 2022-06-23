import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uza_sales/app/retailer/pages/home_page.dart';
import 'package:uza_sales/app/retailer/widget/colors.dart';
import 'package:uza_sales/app/retailer/widget/utils.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreen createState() => _ChatScreen();
}

class _ChatScreen extends State<ChatScreen> {
  List _items;
  SharedPreferences sharedPreferences;
  final List<String> _list = [
    'Order Delayed',
    'Payment Issue',
    'Wrong Item',
    'Others',
  ];
  double _fontSize = 14;

  @override
  void initState() {
    super.initState();
    _items = _list.toList();
    // if you store data on a local database (sqflite), then you could do something like this
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFE5E5E5),
        appBar: AppBar(
          backgroundColor: Color(0xFFE5E5E5),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              )),
          title: Text(
            "Chat",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: (Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                        color: Color(0xFF8BCAC0),
                        borderRadius: BorderRadius.circular(45)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image(
                        image: AssetImage("assets/icons/chat_icon.png"),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10))),
                        child: Center(child: Text("Hello Mangi")),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 40,
                        width: 150,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10))),
                        child: Center(child: Text("How can I help you?")),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          color: Colors.transparent,
                          height: 180,
                          width: Utils.displayWidth(context) * 0.7,
                          padding: EdgeInsets.all(10),
                          child: SingleChildScrollView(
                              child: Tags(
                            key: _tagStateKey,
                            textField: null,
                            columns: 0,
                            horizontalScroll: false,
                            itemCount: _items.length, // required
                            itemBuilder: (int index) {
                              final item = _items[index];
                              return ItemTags(
                                // Each ItemTags must contain a Key. Keys allow Flutter to
                                // uniquely identify widgets.
                                key: Key(index.toString()),
                                index: index, // required
                                title: item,
                                active: false,
                                color: Color(0xFFFFFFFF),
                                textColor: Color(0xFF000000),
                                elevation: 0,
                                padding: EdgeInsets.fromLTRB(25, 12, 25, 12),
                                border: Border.all(color: Color(0xFF9B9C9B)),
                                borderRadius: BorderRadius.circular(10),
                                customData: item,
                                textStyle: TextStyle(
                                  fontSize: _fontSize,
                                ),
                                combine: ItemTagsCombine.withTextBefore,
                                image: null, // OR null,
                                icon: null, // OR null,
                                removeButton: null, // OR null,
                                onPressed: (item) {
                                  _getAllItem();
                                },
                                onLongPressed: (item) => print(item),
                              );
                            },
                          ))),
                    ],
                  )
                ],
              ),
              Container(
                  height: 120,
                  width: Utils.displayWidth(context) * 0.8,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      // controller: ,
                      maxLines: 4,
                      // expands: true,
                      textAlignVertical: TextAlignVertical.top,
                      decoration: InputDecoration(border: InputBorder.none),
                    ),
                  )),
            ],
          ),
        )));
  }

  signIn(BuildContext context) {
    pushNewScreen(
      context,
      screen: HomePage(),
      withNavBar: true, // OPTIONAL VALUE. True by default.
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }

  resendSms() {}

  final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();
// Allows you to get a list of all the ItemTags
  _getAllItem() async {
    sharedPreferences = await SharedPreferences.getInstance();
    List<Item> lst = _tagStateKey.currentState?.getAllItem;
    print("•••••••  active items ••••••••••");
    if (lst != null)
      lst.where((a) => a.active == true).forEach((a) {
        print(a.title);
        sharedPreferences.setStringList("categories", [a.title]);
      });
  }
}
