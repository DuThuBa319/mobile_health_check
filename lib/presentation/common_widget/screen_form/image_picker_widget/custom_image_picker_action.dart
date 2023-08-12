part of 'custom_image_picker.dart';

// ignore: library_private_types_in_public_api
extension ImagePickerAction on _ImagePickerSingleState {
  Future<XFile?> sourceCamera(ImageSource source) async {
    final pickedFile =
        await picker.pickImage(imageQuality: 100, source: source);
    return pickedFile;
  }

  Future<XFile?> sourceGallery(ImageSource source) async {
    final pickedFile =
        await picker.pickImage(imageQuality: 100, source: source);
    return pickedFile;
  }

  // Future<XFile?> pickImagesFromAssetFolder(String folderPath) async {
  //   final List<String> imagePaths =
  //       await AssetImagePicker.pickImagePathsFromAssetFolder(folderPath);
  //   XFile? pickedFile;
  //   for (final imagePath in imagePaths) {
  //     final byteData = await rootBundle.load(imagePath);
  //     final uint8List = byteData.buffer.asUint8List();
  //     final tempDir = await getTemporaryDirectory();
  //     final tempPath = '${tempDir.path}/${basename(imagePath)}';
  //     await File(tempPath).writeAsBytes(uint8List);
  //     pickedFile = XFile(tempPath);
  //   }
  //   return pickedFile;
  // }

  void selectSource(BuildContext context) async {
    await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: SizeConfig.screenHeight * 0.14,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () async {
                  if (widget.isOnTapActive == true) {
                    final pickedFile = await sourceGallery(ImageSource.gallery);
                    if (pickedFile != null) {
                      // ignore: invalid_use_of_protected_member
                      setState(() {
                        image = pickedFile;
                        showToast('Pick image successfully');
                      });
                    }
                  }
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () async {
                  if (widget.isOnTapActive == true) {
                    final pickedFile = await sourceCamera(ImageSource.camera);
                    if (pickedFile != null) {
                      // ignore: invalid_use_of_protected_member
                      setState(() {
                        image = pickedFile;
                        showToast('Pick image successfully');
                      });
                    }
                  }
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pop();
                },
              ),
              // ListTile(
              //   leading: const Icon(Icons.image),
              //   title: const Text('Asset Folder'),
              //   onTap: () async {
              //     if (widget.isOnTapActive == true) {
              //       showDialog(
              //         context: context,
              //         builder: (BuildContext context) {
              //           return AlertDialog(
              //             shape: RoundedRectangleBorder(
              //               borderRadius: BorderRadius.circular(10.0),
              //             ),
              //             // Các thuộc tính và nội dung của AlertDialog
              //             content: TextField(
              //                 controller: TextEditingController(
              //                     text: "lib/assets/images/"),
              //                 onChanged: (value) => widget.folderPath = value),
              //             actions: <Widget>[
              //               // Các button trong AlertDialog
              //               TextButton(
              //                 child: const Text('Huỷ'),
              //                 onPressed: () {
              //                   Navigator.pop(context);
              //                   // Xử lý khi người dùng nhấn nút Huỷ
              //                 },
              //               ),
              //               TextButton(
              //                   child: const Text('Pick Image'),
              //                   onPressed: () async {
              //                     print(widget.folderPath);
              //                     if (widget.folderPath != "" &&
              //                         widget.folderPath !=
              //                             "lib/assets/images/") {
              //                       final pickedFile =
              //                           await pickImagesFromAssetFolder(
              //                               widget.folderPath!);
              //                       // ignore: invalid_use_of_protected_member
              //                       setState(() {
              //                         image = pickedFile;
              //                         showToast('Pick image successfully');

              //                         // ignore: list_remove_unrelated_type
              //                       });
              //                     }
              //                     if (widget.folderPath ==
              //                         "lib/assets/images/") {
              //                       showToast("Please sellect image path");
              //                       Navigator.pop(context);
              //                     } else {
              //                       Navigator.pop(context);
              //                     }
              //                     // ignore: invalid_use_of_protected_member

              //                     // ignore: use_build_context_synchronously
              //                     Navigator.pop(
              //                         context); // Xử lý khi người dùng nhấn nút OK
              //                   }),
              //             ],
              //           );
              //         },
              //       );
              //     }
              //     // ignore: use_build_context_synchronously
              //   },
              // ),
            ],
          ),
        );
      },
    );
  }

  void deleteImage() async {
    if (image != null) {
      // ignore: invalid_use_of_protected_member
      setState(() {
        image = null;
      });
    }
    showToast("Delete Image Successfully");
  }
}

// class AssetImagePicker {
//   static Future<List<String>> pickImagePathsFromAssetFolder(
//       String folderPath) async {
//     final manifestContent = await rootBundle.loadString('AssetManifest.json');
//     final Map<String, dynamic> manifestMap = json.decode(manifestContent);

//     return manifestMap.keys
//         .where((String key) => key.startsWith(folderPath))
//         .toList();
//   }
// }
