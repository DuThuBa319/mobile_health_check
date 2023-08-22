import 'dart:io';

import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_health_check/presentation/theme/theme_color.dart';

import '../../../../function.dart';
import '../../assets.dart';
import '../../dialog/show_toast.dart';
// ignore: depend_on_referenced_packages

part 'custom_image_picker_action.dart';

// ignore: must_be_immutable
class ImagePickerSingle extends StatefulWidget {
  final bool? isOnTapActive;
  final bool? isforAvatar;
  final String? imagePath;

  const ImagePickerSingle({
    Key? key,
    required this.imagePath,
    required this.isOnTapActive,
    required this.isforAvatar,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ImagePickerSingleState createState() => _ImagePickerSingleState();
}

class _ImagePickerSingleState extends State<ImagePickerSingle> {
  final picker = ImagePicker();

  XFile? image;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: widget.isforAvatar == false
            ? widget.imagePath == null
                ? Container(
                    margin: const EdgeInsets.only(left: 15),
                    height: SizeConfig.screenWidth * 0.8,
                    width: SizeConfig.screenWidth * 0.8,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    // decoration: BoxDecoration(
                    //   border: Border.all(width: 4, color: Colors.blue),
                    //   borderRadius: BorderRadiusDirectional.circular(20),
                    // ),
                    child: Image.asset(
                      fit: BoxFit.cover,
                      Assets.photo,
                      color: Colors.white,
                      // Container(
                      //   decoration: BoxDecoration(
                      //     border: Border.all(width: 4, color: Colors.white),
                      //     color: Colors.blue,
                      //     shape: BoxShape.circle,
                      //   ),
                      //   margin: EdgeInsets.only(
                      //       left: SizeConfig.screenWidth * 0.55,
                      //       top: SizeConfig.screenWidth * 0.50),
                      //   child: SizedBox(
                      //     height: 60,
                      //     width: 60,
                      //     child: GestureDetector(
                      //       child: Container(
                      //         padding: EdgeInsets.zero,
                      //         decoration: const BoxDecoration(
                      //             shape: BoxShape.circle, color: Colors.blue),
                      //         child: const Icon(
                      //           Icons.add_a_photo,
                      //           color: Colors.white,
                      //           size: 30,
                      //         ),
                      //       ),
                      //       onTap: () {
                      //         if (widget.isOnTapActive == true) {
                      //           selectSource(context);
                      //         }
                      //       },
                      //     ),
                      //   ),
                      // ),
                    ),
                  )
                : Container(
                    margin: const EdgeInsets.only(left: 15),
                    height: SizeConfig.screenWidth * 0.8,
                    width: SizeConfig.screenWidth * 0.8,
                    child: ClipRRect(
                        borderRadius: BorderRadiusDirectional.circular(20),
                        child: FullScreenWidget(
                          disposeLevel: DisposeLevel.High,
                          child: Image.network(
                            widget.imagePath!,
                            fit: BoxFit.fill,
                          ),
                        )),
                    // Container(
                    //   decoration: BoxDecoration(
                    //     border: Border.all(width: 4, color: Colors.white),
                    //     color: Colors.blue,
                    //     shape: BoxShape.circle,
                    //   ),
                    //   margin: EdgeInsets.only(
                    //       left: SizeConfig.screenWidth * 0.65,
                    //       top: SizeConfig.screenWidth * 0.6),
                    //   child: SizedBox(
                    //     height: 60,
                    //     width: 60,
                    //     child: GestureDetector(
                    //       child: const Icon(
                    //         Icons.delete_forever,
                    //         color: Colors.white,
                    //         size: 30,
                    //       ),
                    //       onTap: () {
                    //         if (widget.isOnTapActive == true) {
                    //           deleteImage();
                    //         }
                    //       },
                    //     ),
                    //   ),
                    // ),
                  )

            ////////////////////////////
            : image == null
                ? Container(
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    // margin: EdgeInsets.only(
                    //     left: SizeConfig.screenWidth * 0.6,
                    //     top: SizeConfig.screenWidth * 0.6
                    //     ),
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: GestureDetector(
                        child: Container(
                          padding: EdgeInsets.zero,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: const Icon(
                            Icons.add_a_photo_outlined,
                            size: 50,
                          ),
                        ),
                        onTap: () {
                          if (widget.isOnTapActive == true) {
                            selectSource(context);
                          }
                        },
                      ),
                    ),
                  )
                : Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 2, color: AppColor.white),
                          shape: BoxShape.circle,
                        ),
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(80),
                            child: image != null
                                ? FullScreenWidget(
                                    disposeLevel: DisposeLevel.Medium,
                                    child: Image.file(
                                      File(image!.path),
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : const Icon(
                                    Icons.add_a_photo_outlined,
                                    size: 50,
                                  ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 3, color: AppColor.white),
                          color: AppColor.topGradient,
                          shape: BoxShape.circle,
                        ),
                        margin: EdgeInsets.only(
                            left: SizeConfig.screenWidth * 0.18,
                            top: SizeConfig.screenWidth * 0.17),
                        child: SizedBox(
                          height: 35,
                          width: 35,
                          child: GestureDetector(
                            child: const Icon(
                              Icons.delete_outline_outlined,
                              size: 30,
                              color: AppColor.white,
                            ),
                            onTap: () {
                              if (widget.isOnTapActive == true) {
                                deleteImage();
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ));
  }
}