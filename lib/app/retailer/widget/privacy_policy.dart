import 'package:flutter/material.dart';

class PrivacyWidget extends StatelessWidget {
  const PrivacyWidget({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Privacy and Poliicy"),
      ),
      body: Center(
        child: Text("Lorem ipsum"),
      ),
    );
  }
}