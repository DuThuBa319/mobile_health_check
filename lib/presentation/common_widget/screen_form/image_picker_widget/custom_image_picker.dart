import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../function.dart';
import '../../assets.dart';
import '../../dialog/show_toast.dart';
// ignore: depend_on_referenced_packages

part 'custom_image_picker_action.dart';

// ignore: must_be_immutable
class CustomImagePicker extends StatefulWidget {
  final bool? gender;
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
                    height: SizeConfig.screenWidth * 0.9,
                    width: SizeConfig.screenWidth * 0.9,
                    child: FullScreenWidget(
                      disposeLevel: DisposeLevel.Medium,
                      child: Hero(
                        tag: "",
                        child: Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              widget.imagePath ?? widget.imagePath!,
                              fit: BoxFit.fill,
                            ),
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
                        child: Image.asset(
                      fit: BoxFit.fill,
                      // gender =0 => nam
                      // gender =1 => nu
                      (widget.gender == false &&
                              widget.age! <= 25 &&
                              widget.age! > 0)
                          ? Assets.boy
                          : (widget.gender == false &&
                                  26 <= widget.age! &&
                                  widget.age! <= 50)
                              ? Assets.man
                              : (widget.gender == false &&
                                      50 < widget.age! &&
                                      widget.age! < 150)
                                  ? Assets.oldMan
                                  : (widget.gender == true &&
                                          widget.age! <= 25 &&
                                          widget.age! > 0)
                                      ? Assets.girl
                                      : (widget.gender == true &&
                                              26 <= widget.age! &&
                                              widget.age! <= 50)
                                          ? Assets.women
                                          : Assets.oldWoman,
                    ))

                    // : Container(
                    //   decoration: BoxDecoration(
                    //     border: Border.all(width: 2, color: AppColor.white),
                    //     shape: BoxShape.circle,
                    //   ),
                    //   child: SizedBox(
                    //     height: SizeConfig.screenWidth * 0.3,
                    //     width: SizeConfig.screenWidth * 0.3,
                    //     child: ClipRRect(
                    //         borderRadius: BorderRadius.circular(80),
                    //         child: widget.imagePath != null &&
                    //                 widget.imagePath != ""
                    //             ?

                    //             FullScreenWidget(
                    //                 disposeLevel: DisposeLevel.Medium,
                    //                 child: Image.network(
                    //                   widget.imagePath!,
                    //                   fit: BoxFit.fill,
                    //                 ),
                    //               )
                    //             : FullScreenWidget(
                    //                 disposeLevel: DisposeLevel.High,
                    //                 child: Image.network(
                    //                   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTMtf5HimrPTRa-LtN6UAlm2-YJD8vtj7C3Kg&usqp=CAU",
                    //                   fit: BoxFit.fill,
                    //                 ),
                    //               )),
                    //   ),
                    // )
                    )));
  }
}
