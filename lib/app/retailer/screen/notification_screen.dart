import 'package:flutter/material.dart';
import 'package:uza_sales/app/retailer/widget/colors.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgScreen2,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        title: Text(
          "Notifications",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Column(
          children: [
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
              title: Text("Today's Promotions", style: TextStyle(fontSize: 14)),
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
            ),
            Container(
              child: ListTile(
                // tileColor: Colors.transparent,
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
            ),
          ],
        ),
      ),
    );
  }
}
