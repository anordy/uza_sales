import 'package:flutter/material.dart';
import 'package:uza_sales/app/retailer/widget/colors.dart';

class AboutUza extends StatelessWidget {
  const AboutUza({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.base,
        title: Text("Abou Uzza"),
      ),
      body: Center(
        child: Text("About Uzza"),
      ),
    );
  }
}
