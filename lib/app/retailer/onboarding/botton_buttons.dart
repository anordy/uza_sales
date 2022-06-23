import 'package:flutter/material.dart';
import 'package:uza_sales/app/retailer/pages/auth/splash_screen.dart';
import 'package:uza_sales/app/retailer/widget/utils.dart';

class BottomButtons extends StatefulWidget {
  final int currentIndex;
  final int dataLength;
  final PageController controller;

  const BottomButtons(
      {Key key, this.currentIndex, this.dataLength, this.controller})
      : super(key: key);

  @override
  _BottomButtonsState createState() => _BottomButtonsState();
}

class _BottomButtonsState extends State<BottomButtons> {
  _navigateToLoginPage() {
    return Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => SplashScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: widget.currentIndex == widget.dataLength - 1
          ? [
              Padding(
                padding: const EdgeInsets.only(left: 200.0, top: 20),
                child: MaterialButton(
                    onPressed: () {
                      _navigateToLoginPage();
                    },
                    color: Colors.white,
                    minWidth: Utils.displayWidth(context) * 0.3,
                    height: MediaQuery.of(context).size.height * 0.065,
                    materialTapTargetSize:
                        MaterialTapTargetSize.shrinkWrap, // add this
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                        side: BorderSide.none),
                    child: Container(
                        child: Text(
                      "Next",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ))),
              )
            ]
          : [
              // MaterialButton(
              //   minWidth: 0.0,
              //   onPressed: () {
              //     _navigateToLoginPage();
              //   },
              //   child: Text(
              //     "Skip",
              //     style: TextStyle(
              //         fontSize: 16.0,
              //         height: 1.3,
              //         color: Colors.white,
              //         fontWeight: FontWeight.w400),
              //   ),
              // ),
              // Row(
              //   children: [
              //     MaterialButton(
              //       padding: EdgeInsets.zero,
              //       minWidth: 0.0,
              //       onPressed: () {
              //         widget.controller.nextPage(
              //             duration: Duration(milliseconds: 200),
              //             curve: Curves.easeInOut);
              //       },
              //       child: Text(
              //         "Next",
              //         style: TextStyle(
              //             fontSize: 16.0,
              //             height: 1.3,
              //             color: Colors.white,
              //             fontWeight: FontWeight.w400),
              //       ),
              //     ),
              //     Container(
              //         alignment: Alignment.center,
              //         child: Icon(
              //           Icons.arrow_right_alt,
              //           color: Colors.white,
              //         ))
              //   ],
              // )
            ],
    );
  }
}
