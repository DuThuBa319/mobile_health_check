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
class CustomImagePicker extends StatefulWidget {
  final bool? isOnTapActive;
  final bool? isforAvatar;
  final String? imagePath;

  const CustomImagePicker({
    Key? key,
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
                ? Container(
                    margin: const EdgeInsets.only(left: 15),
                    height: SizeConfig.screenWidth * 0.8,
                    width: SizeConfig.screenWidth * 0.8,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: Image.asset(
                      fit: BoxFit.cover,
                      Assets.photo,
                      color: Colors.white,
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
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTMtf5HimrPTRa-LtN6UAlm2-YJD8vtj7C3Kg&usqp=CAU",
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
                    //         size: SizeConfig.screenWidth * 0.08,
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
            : widget.imagePath == null
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
                      height: SizeConfig.screenWidth * 0.3,
                      width: SizeConfig.screenWidth * 0.3,
                      child: GestureDetector(
                        child: Container(
                          padding: EdgeInsets.zero,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: Icon(
                            Icons.add_a_photo_outlined,
                            size: SizeConfig.screenWidth * 0.125,
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
                          height: SizeConfig.screenWidth * 0.3,
                          width: SizeConfig.screenWidth * 0.3,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(80),
                              child: widget.imagePath != null &&
                                      widget.imagePath != ""
                                  ?
                                  //  image != null
                                  //     ? FullScreenWidget(
                                  //         disposeLevel: DisposeLevel.Medium,
                                  //         child: Image.file(
                                  //           File(image!.path),
                                  //           fit: BoxFit.cover,
                                  //         ),
                                  //       )
                                  FullScreenWidget(
                                      disposeLevel: DisposeLevel.Medium,
                                      child: Image.network(
                                        widget.imagePath!,
                                        fit: BoxFit.fill,
                                      ),
                                    )
                                  : FullScreenWidget(
                                      disposeLevel: DisposeLevel.High,
                                      child: Image.network(
                                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTMtf5HimrPTRa-LtN6UAlm2-YJD8vtj7C3Kg&usqp=CAU",
                                        fit: BoxFit.fill,
                                      ),
                                    )),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 3, color: AppColor.white),
                          color: AppColor.topGradient,
                          shape: BoxShape.circle,
                        ),
                        margin: EdgeInsets.only(
                            left: SizeConfig.screenWidth * 0.22,
                            top: SizeConfig.screenWidth * 0.23),
                        child: SizedBox(
                          height: SizeConfig.screenWidth * 0.09,
                          width: SizeConfig.screenWidth * 0.09,
                          child: GestureDetector(
                            child: Icon(
                              Icons.delete_outline_outlined,
                              size: SizeConfig.screenWidth * 0.08,
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
