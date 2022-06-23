import 'package:flutter/material.dart';
import 'package:uza_sales/app/retailer/widget/colors.dart';
import 'package:uza_sales/app/retailer/widget/utils.dart';

class AgreeTermsDialog extends StatefulWidget {
  const AgreeTermsDialog({
    Key key,
  }) : super(key: key);

  @override
  _AgreeTermsDialogState createState() => _AgreeTermsDialogState();
}

class _AgreeTermsDialogState extends State<AgreeTermsDialog> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      // elevation: 0,
      backgroundColor: Colors.white,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Container(
              // padding: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 20),
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // height: 60,
                // width: Utils.displayWidth(context),
                decoration: BoxDecoration(color: AppColor.base),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Uzza App",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text("Vigezo na mashariti"),
              )
            ],
          )),
        ),
      ],
    );
  }

  navigate(BuildContext context) {}
}
