import 'package:flutter/material.dart';
import 'package:uza_sales/app/retailer/onboarding/explanation.dart';
import 'package:uza_sales/app/retailer/widget/colors.dart';

import 'botton_buttons.dart';

final List<ExplanationData> data = [
  ExplanationData(
      description:
          "Labore do ex cillum fugiat anim nulla pariatur est. Elit laboris eiusmod ex occaecat do ea officia esse culpa.",
      title: "Buy From All Shops Online",
      // localImageSrc: "assets/icons/1.png",
      backgroundColor: AppColor.base),
  ExplanationData(
      description:
          "Sit ullamco anim deserunt aliquip mollit id. Occaecat labore laboris magna reprehenderit sint in sunt ea.",
      title: "Deliver Next To Your Door",
      // localImageSrc: "assets/icons/2.png",
      backgroundColor: AppColor.base),
  ExplanationData(
      description:
          "Eiusmod aliqua laboris duis eiusmod ea ea commodo dolore. Ullamco nulla nostrud et officia.",
      title: "Superstore All The Way Home",
      // localImageSrc: "assets/icons/3.png",
      backgroundColor: AppColor.base),
];

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState
    extends State<OnBoardingScreen> /*with ChangeNotifier*/ {
  final _controller = PageController();

  int _currentIndex = 0;

  // OpenPainter _painter = OpenPainter(3, 1);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: data[_currentIndex].backgroundColor,
        child: SafeArea(
            child: Container(
          padding: EdgeInsets.all(16),
          color: data[_currentIndex].backgroundColor,
          alignment: Alignment.center,
          child: Column(children: [
            Expanded(
              child: Column(
                children: [
                  BottomButtons(
                    currentIndex: _currentIndex,
                    dataLength: data.length,
                    controller: _controller,
                  ),
                  Expanded(
                      child: Container(
                          alignment: Alignment.center,
                          child: PageView(
                              scrollDirection: Axis.horizontal,
                              controller: _controller,
                              onPageChanged: (value) {
                                // _painter.changeIndex(value);
                                setState(() {
                                  _currentIndex = value;
                                });
                                // notifyListeners();
                              },
                              children: data
                                  .map((e) => ExplanationPage(data: e))
                                  .toList())),
                      flex: 4),
                  Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              margin: const EdgeInsets.symmetric(vertical: 24),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(data.length,
                                    (index) => createCircle(index: index)),
                              )),
                        ],
                      ))
                ],
              ),
            )
          ]),
        )));
  }

  createCircle({int index}) {
    return AnimatedContainer(
        duration: Duration(milliseconds: 100),
        margin: EdgeInsets.only(right: 4),
        height: 5,
        width: _currentIndex == index ? 15 : 5,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(3)));
  }
}
