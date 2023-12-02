import 'package:flutter/widgets.dart';

class ScreenSize {
  static late double screenWidth;
  static late double screenHeight;
  static late Orientation orientation;

  static void init(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width; // Get width of the screen
    screenHeight = MediaQuery.of(context).size.height;  // Get height of the screen
    orientation = MediaQuery.of(context).orientation;  // Get orientation of the screen
  }

  static bool isLandscape() {
    return orientation.name == "landscape";
  }
}
