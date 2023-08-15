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
