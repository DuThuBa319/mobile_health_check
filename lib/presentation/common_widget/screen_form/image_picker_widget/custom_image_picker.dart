import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_health_check/classes/language.dart';

import '../../../../function.dart';
import '../../assets.dart';
import '../../dialog/show_toast.dart';
// ignore: depend_on_referenced_packages

part 'custom_image_picker_action.dart';

// ignore: must_be_immutable
class CustomImagePicker extends StatefulWidget {
  final int? gender;
  final int? age;
  final String? imagePath;
  final bool? isOnTapActive;
  final bool? isforAvatar;

  const CustomImagePicker({
    Key? key,
    this.age,
    this.gender,
    required this.imagePath,
    required this.isOnTapActive,
    required this.isforAvatar,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CustomImagePickerState createState() => _CustomImagePickerState();
}

class _CustomImagePickerState extends State<CustomImagePicker> {
  final picker = ImagePicker();
  XFile? image;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Container(
        child: widget.isforAvatar == false
            ? widget.imagePath == null
                ? Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 15),
                        height: SizeConfig.screenWidth * 0.8,
                        width: SizeConfig.screenWidth * 0.8,
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child: Image.asset(
                          fit: BoxFit.cover,
                          Assets.photo,
                          color: Colors.white,
                        ),
                      ),
                      Text(translation(context).wifiDisconnect)
                    ],
                  )
                : Container(
                    margin: const EdgeInsets.only(left: 15),
                    height: SizeConfig.screenWidth * 0.9,
                    width: SizeConfig.screenWidth * 0.9,
                    child: FullScreenWidget(
                      disposeLevel: DisposeLevel.Medium,
                      child: Hero(
                        tag: "",
                        child: Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(widget.imagePath!,
                                fit: BoxFit.fill,
                                errorBuilder: (context, error, stackTrace) {
                              showToast(translation(context).uploadPhotoError);
                              return Icon(Icons.image_not_supported_outlined,
                                  size: SizeConfig.screenWidth / 2);
                            }),
                          ),
                        ),
                      ),
                    ),
                  )

            ////////////////////////////
            ///
            : SizedBox(
                height: SizeConfig.screenWidth * 0.25,
                width: SizeConfig.screenWidth * 0.25,
                child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: ClipOval(
                        child: widget.gender == null || widget.age == null
                            ? Image.asset(
                                Assets.family,
                                fit: BoxFit.fill,
                              )
                            : Image.asset(
                                fit: BoxFit.fill,
                                // gender =0 => nam. False
                                // gender =1 => nu. True
                                (widget.gender == 0 &&
                                        widget.age! <= 25 &&
                                        widget.age! > 0)
                                    ? Assets.boy
                                    : (widget.gender == 0 &&
                                            26 <= widget.age! &&
                                            widget.age! <= 50)
                                        ? Assets.man
                                        : (widget.gender == 0 &&
                                                50 < widget.age! &&
                                                widget.age! < 150)
                                            ? Assets.oldMan
                                            : (widget.gender == 1 &&
                                                    widget.age! <= 25 &&
                                                    widget.age! > 0)
                                                ? Assets.girl
                                                : (widget.gender == 1 &&
                                                        26 <= widget.age! &&
                                                        widget.age! <= 50)
                                                    ? Assets.women
                                                    : (widget.gender == 1)
                                                        ? Assets.oldWoman
                                                        : Assets.oldMan)))));
  }
}
