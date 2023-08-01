import 'dart:io';

import 'package:common_project/presentation/theme/theme_color.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_screen_image/full_screen_image.dart';

import 'package:common_project/presentation/common_widget/screen_form/custom_screen_form.dart';

import 'package:flutter/material.dart';
import '../../common_widget/dialog/show_toast.dart';
import '../../common_widget/enum_common.dart';

import 'ocr_scanner_bloc/ocr_scanner_bloc.dart';
part 'OCR_scanner_screen.action.dart';

class OCRScannerScreen extends StatefulWidget {
  const OCRScannerScreen({super.key});

  @override
  State<OCRScannerScreen> createState() => _OCRScannerScreenState();
}

class _OCRScannerScreenState extends State<OCRScannerScreen> {
  String? message = "";

  OCRScannerBloc get scanBloc => BlocProvider.of(context);
  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return CustomScreenForm(
      title: 'Home',
      isShowAppBar: true,
      isShowLeadingButton: false,
      backgroundColor: Colors.white,
      appBarColor: Colors.blue,
      selectedIndex: 4,
      child: BlocConsumer<OCRScannerBloc, OCRScannerState>(
        listener: blocListener,
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                        height: 400,
                        width: 350,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(width: 1, color: Colors.blue)),
                        child: state.viewModel.imageFile == null
                            ? IconButton(
                                icon: const Icon(
                                  Icons.camera_alt,
                                  color: Colors.blue,
                                  size: 70,
                                ),
                                onPressed: () async {
                                  scanBloc.add(GetDataEvent(context: context));
                                },
                              )
                            : ClipRRect(
                                borderRadius:
                                    BorderRadiusDirectional.circular(20),
                                child: FullScreenWidget(
                                    disposeLevel: DisposeLevel.High,
                                    child: Image.file(
                                      File(state.viewModel.imageFile!.path),
                                    )),
                              ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    state.viewModel.imageFile != null
                        ? Column(
                            children: [
                              Container(
                                height: 150,
                                width: 300,
                                margin: const EdgeInsets.only(bottom: 28),
                                padding:
                                    const EdgeInsets.fromLTRB(17, 10, 16, 0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: AppColor.greyF3),
                                child: DefaultTextStyle(
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Wrap(
                                        direction: Axis.vertical,
                                        spacing: 10,
                                        children: [
                                          Text('Huyết áp tâm thu:'),
                                          Text('Huyết áp tâm trương:'),
                                          Text('Nhịp tim:'),
                                        ],
                                      ),
                                      Wrap(
                                        crossAxisAlignment:
                                            WrapCrossAlignment.end,
                                        direction: Axis.vertical,
                                        spacing: 10,
                                        children: [
                                          Text(state.viewModel.sys.toString()),
                                          Text(state.viewModel.dia.toString()),
                                          Text(
                                              state.viewModel.pulse.toString()),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                  onTap: () {
                                    scanBloc
                                        .add(GetDataEvent(context: context));
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 200,
                                    height: 70,
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        border: Border.all(
                                            color: Colors.blue, width: 2)),
                                    child: const Text('Chụp lại',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                  )),
                            ],
                          )
                        : Container(),
                  ]),
            ),
          );
        },
      ),
    );
  }
}
