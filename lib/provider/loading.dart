import 'package:flutter/cupertino.dart';

class IsLoading with ChangeNotifier {
  bool isLoading = false;
  void notLoading() {
    isLoading = false;
    notifyListeners();
  }
  void Loading() {
    isLoading = true;
    notifyListeners();
  }
}
