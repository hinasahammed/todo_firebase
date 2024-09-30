import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  void showToast(String message) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
      msg: message,
    );
  }
}
