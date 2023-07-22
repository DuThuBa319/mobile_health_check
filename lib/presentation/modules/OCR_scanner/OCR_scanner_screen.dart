import 'dart:convert';
import 'dart:io';

import 'package:common_project/presentation/common_widget/image_picker/image_picker_widget.dart';
import 'package:common_project/presentation/common_widget/screen_form/custom_screen_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../common_widget/dialog/show_toast.dart';
import '../../common_widget/enum_common.dart';
import '../../common_widget/image_picker/image_picker_bloc/image_picker_bloc.dart';
part 'OCR_scanner_screen.action.dart';

class OCRScannerScreen extends StatefulWidget {
  const OCRScannerScreen({super.key});

  @override
  State<OCRScannerScreen> createState() => _OCRScannerScreenState();
}

class _OCRScannerScreenState extends State<OCRScannerScreen> {
  String? message = "";
  File? selectedImage;
  ImagePickerBloc get imageBloc => BlocProvider.of(context);
  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return CustomScreenForm(
      title: 'OCR Scanner',
      isShowAppBar: true,
      isShowLeadingButton: true,
      backgroundColor: Colors.white,
      appBarColor: Colors.blue,
      selectedIndex: 4,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          const Text('Image picker'),
          ImagePickerGridView(
            isEnable: true,
            bloc: imageBloc,
          ),
          BlocConsumer<ImagePickerBloc, ImagePickerState>(
            listener: _imagePickerBlocListener,
            builder: (context, state) {
              return Container(
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                    controller: textController,
                    decoration:
                        const InputDecoration(hintText: 'Text goes here'),
                  ));
            },
          )
          // ImagePickerGridView(isEnable: true)
        ]),
      ),
    );
  }
}
