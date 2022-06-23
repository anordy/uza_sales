import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:uza_sales/app/retailer/widget/faq.dart';
import 'package:uza_sales/app/retailer/widget/privacy_policy.dart';
import 'package:uza_sales/app/retailer/widget/terms_condition.dart';

class PoliciesWidget extends StatefulWidget {
  @override
  _PoliciesWidgetState createState() => _PoliciesWidgetState();
}

class _PoliciesWidgetState extends State<PoliciesWidget> {
  @override
  Widget build(BuildContext context) {
    String _value;
    final lists = ['Faq', 'Privacy Policy', 'Terms & Condition'];
    return DropdownButtonHideUnderline(
        child: DropdownButton<String>(
      items: [
        DropdownMenuItem<String>(
          value: "1",
          child: Text(
            "Faq",
          ),
        ),
        DropdownMenuItem<String>(
          value: "2",
          child: Text(
            "Privacy Policy",
          ),
        ),
        DropdownMenuItem<String>(
          value: "3",
          child: Text(
            "Terms & Condition",
          ),
        ),
      ],
      onChanged: (value) {
        setState(() {
          _value = value;
          if (_value == "1") {
            navigate(context, FaqWidget(), true);
          } else if (_value == "2") {
            navigate(context, PrivacyWidget(), true);
          } else {
            navigate(context, TermsConditionWidget(), true);
          }
        });
      },
      icon: Icon(Icons.chevron_right),
      value: _value,
      // elevation: 2,
      // style: TextStyle(color: PURPLE, fontSize: 30),
      // isDense: true,
      // iconSize: 40.0,
    ));
  }

  navigate(BuildContext context, Widget screen, bool nav) {
    pushNewScreen(
      context,
      screen: screen,
      withNavBar: true, // OPTIONAL VALUE. True by default.
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }
}
