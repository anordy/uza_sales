import 'package:flutter/material.dart';

class Utils {
  // get screen height and width size
  static Size displaySize(BuildContext context) {
    return MediaQuery.of(context).size;
  }
  
  // get screen  width
  static double displayWidth(BuildContext context) {
    return displaySize(context).width;
  }
  // displget screen height 
  static double displayHeight(BuildContext context){
    return displaySize(context).height;
  }

}