import 'package:flutter/material.dart';
import 'package:uza_sales/app/retailer/widget/colors.dart';

class BookerNotificationScreen extends StatelessWidget {
  const BookerNotificationScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgScreen2,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                  // SizedBox(width: 2,),
                  Text(
                    "Notiifications",
                    style: TextStyle(
                        fontSize: 16,
                        color: AppColor.title,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 65,
                child: ListTile(
                  tileColor: Colors.white,
                  leading: CircleAvatar(
                    radius: 8,
                    backgroundColor: AppColor.preBase,
                  ),
                  title: Text("Today's Promotions",
                      style: TextStyle(fontSize: 14)),
                  subtitle: Text(
                    "Lorem ipsum dolor sit amet, ",
                    style: TextStyle(fontSize: 12),
                  ),
                  trailing: Text(
                    "6 July",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                // tileColor: Colors.white,
                leading: CircleAvatar(
                  radius: 8,
                  backgroundColor: AppColor.preBase,
                ),
                title:
                    Text("Today's Promotions", style: TextStyle(fontSize: 14)),
                subtitle: Text(
                  "Lorem ipsum dolor sit amet, ",
                  style: TextStyle(fontSize: 12),
                ),
                trailing: Text(
                  "6 July",
                  style: TextStyle(fontSize: 12),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                height: 65,
                child: ListTile(
                  tileColor: Colors.white,
                  leading: CircleAvatar(
                    radius: 8,
                    backgroundColor: AppColor.preBase,
                  ),
                  title: Text("Today's Promotions",
                      style: TextStyle(fontSize: 14)),
                  subtitle: Text(
                    "Lorem ipsum dolor sit amet, ",
                    style: TextStyle(fontSize: 12),
                  ),
                  trailing: Text(
                    "6 July",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
              Container(
                child: ListTile(
                  // tileColor: Colors.transparent,
                  leading: CircleAvatar(
                    radius: 8,
                    backgroundColor: AppColor.preBase,
                  ),
                  title: Text("Today's Promotions",
                      style: TextStyle(fontSize: 14)),
                  subtitle: Text(
                    "Lorem ipsum dolor sit amet, ",
                    style: TextStyle(fontSize: 12),
                  ),
                  trailing: Text(
                    "6 July",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                height: 65,
                child: ListTile(
                  tileColor: Colors.white,
                  leading: CircleAvatar(
                    radius: 8,
                    backgroundColor: AppColor.preBase,
                  ),
                  title: Text("Today's Promotions",
                      style: TextStyle(fontSize: 14)),
                  subtitle: Text(
                    "Lorem ipsum dolor sit amet, ",
                    style: TextStyle(fontSize: 12),
                  ),
                  trailing: Text(
                    "6 July",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
