import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';

import 'package:church_clique/core/constants/palette.dart';
import 'package:church_clique/features/settings/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({super.key, required this.onPickedImage});
  final void Function(File pickedImage) onPickedImage;

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImageFile;
  
   Uint8List toByte( File? imageBytes){
    return imageBytes!  as Uint8List; 
  }
  

  void _pickedImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 150,
    );
    
    if (pickedImage == null) {
      return;
    }
    setState(() {
      _pickedImageFile = File(pickedImage.path);
    });
    widget.onPickedImage(_pickedImageFile!);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white,
            backgroundImage: _pickedImageFile != null
                ? FileImage(_pickedImageFile!) 
                : AssetImage('assets/images/user-icon.png'),
          ),
          IconButton(
            onPressed: _pickedImage,
            icon: Icon(
              Icons.image,
              color: Palette.textColor1,
            ),
          )
        ],
      ),
    );
  }
}
