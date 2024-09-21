// import 'dart:io';

// import 'package:church_clique/core/constants/palette.dart';
// import 'package:church_clique/features/settings/providers/theme_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:icons_flutter/icons_flutter.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';

// class UserImagePicker extends StatefulWidget {
//   const UserImagePicker({super.key, required this.onPickedImage});
//   final void Function(File pickedImage) onPickedImage;

//   @override
//   State<UserImagePicker> createState() => _UserImagePickerState();
// }

// class _UserImagePickerState extends State<UserImagePicker> {
//   File? _pickedImageFile;

//   Future<void> _showDialog() {
//     return showDialog(
//         context: context,
//         builder: (context) {
//           return Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               AlertDialog(
//                 title: const Text('Choose image'),
//                 content: Padding(
//                   padding: const EdgeInsets.only(left: 30),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       OutlinedButton.icon(
//                         onPressed: () {
//                           _pickImage();
//                           Navigator.pop(context);
//                         },
//                         label: const Text('Camera'),
//                         icon: const Icon(Icons.camera),
//                       ),
//                       const SizedBox(height: 25),
//                       OutlinedButton.icon(
//                         onPressed: () {
//                           _pickedImage();
//                           Navigator.pop(context);
//                         },
//                         label: const Text('Gallery'),
//                         icon: const Icon(MaterialCommunityIcons
//                             .picture_in_picture_top_right_outline),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           );
//         });
//   }

//   Future<void> _pickImage() async {
//     final pickedImage = await ImagePicker().pickImage(
//       source: ImageSource.camera,
//       maxWidth: 150,
//     );
//     if (pickedImage == null) {
//       return;
//     }

//     setState(() {
//       _pickedImageFile = File(pickedImage.path);
//     });

//     widget.onPickedImage(_pickedImageFile!);
//   }

//   void _pickedImage() async {
//     final pickedImage = await ImagePicker().pickImage(
//       source: ImageSource.gallery,
//       maxWidth: 150,
//     );

//     if (pickedImage == null) {
//       return;
//     }
//     setState(() {
//       _pickedImageFile = File(pickedImage.path);
//     });
//     widget.onPickedImage(_pickedImageFile!);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         children: [
//           CircleAvatar(
//             radius: 40,
//             backgroundColor: context.watch<ThemeProvider>().isDarkTheme ||
//                     context.watch<ThemeProvider>().isDarkMode
//                 ? Colors.grey.shade800
//                 : Colors.white,
//             backgroundImage: _pickedImageFile != null
//                 ? FileImage(_pickedImageFile!)
//                 : const AssetImage('assets/images/user-icon.png'),
//           ),
//           IconButton(
//             onPressed: _showDialog,
//             icon: const Icon(
//               Icons.image,
//               color: Palette.textColor1,
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
