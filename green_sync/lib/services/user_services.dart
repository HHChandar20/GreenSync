import 'package:green_sync/models/user.dart';
import 'package:hive/hive.dart';

class UserServices {
  static void setArea(String newArea) {
    final usersBox = Hive.box<User>("usersBox");
    User user = User(area: newArea);

    if (usersBox.isEmpty) {
      usersBox.add(user);
      return;
    }

    usersBox.putAt(0, user);
  }

  static String getArea() {
    final usersBox = Hive.box<User>("usersBox");

    if (usersBox.isEmpty) return "";

    return usersBox.values.isEmpty ? "" : usersBox.values.first.area;
  }
}
