import 'package:flutter/material.dart';

class ExplanationData {
  final String title;
  final String description;
  final String localImageSrc;
  final Color backgroundColor;

  ExplanationData(
      {this.title, this.description, this.localImageSrc, this.backgroundColor});
}

class ExplanationPage extends StatelessWidget {
  final ExplanationData data;

  ExplanationPage({this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Container(
        //     margin: EdgeInsets.only(top: 24, bottom: 16),
        //     child: Image.asset(data.localImageSrc),
        //         height: MediaQuery.of(context).size.height * 0.33,
        //         alignment: Alignment.center),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Text(
              //   data.title,
              //   style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w600, color: Colors.white),
              //   textAlign: TextAlign.center,
              // ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 40,vertical: 50),
                  child: Text(
                    data.description,
                    style: TextStyle(fontSize: 20.0, height: 1.3, color: Colors.white, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ))
            ],
          ),
        ),
      ],
    );
  }
}
