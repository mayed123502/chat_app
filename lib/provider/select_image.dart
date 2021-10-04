import 'dart:io';

import 'package:flutter/cupertino.dart';

class SelectImage with ChangeNotifier {
  bool isSelectImage;
  File image;
  void notSelect() {
    isSelectImage = false;
    notifyListeners();
  }

  void isSelect() {
    isSelectImage = true;
    notifyListeners();
  }

  void getImage(File images) {
    image = images;
    notifyListeners();
  }
}
