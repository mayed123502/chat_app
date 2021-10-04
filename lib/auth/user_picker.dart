import 'dart:io';

import 'package:chat/provider/select_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UserImagePicker extends StatefulWidget {
  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File pickedImage;
  final ImagePicker picker = ImagePicker();
  void pickImage(ImageSource src) async {
    final pickedImageFile = await picker.getImage(source: src);
    if (pickedImageFile != null) {
      Provider.of<SelectImage>(context, listen: false).isSelect();
      Provider.of<SelectImage>(context, listen: false).getImage(pickedImage);
      setState(() {
        pickedImage = File(pickedImageFile.path);
      });

    } else {
      print("No Image Selected");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage: pickedImage != null ? FileImage(pickedImage) : null,
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FlatButton.icon(
              textColor: Theme.of(context).primaryColor,

              onPressed: () =>pickImage(ImageSource.camera),
              icon: Icon(Icons.photo_camera_outlined),
              label: Text(
                "Add Image\nfrom Camera",
                textAlign: TextAlign.center,
              ),
            ),
            FlatButton.icon(
              textColor: Theme.of(context).primaryColor,
              onPressed: () =>pickImage(ImageSource.gallery),
              icon: Icon(Icons.image_outlined),
              label: Text(
                "Add Image\nfrom Gallery",
                textAlign: TextAlign.center,
              ),
            ),
          ],
        )
      ],
    );
  }
}
