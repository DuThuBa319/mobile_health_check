import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import '../../../common_widget/enum_common.dart';
import '../../../route/route_list.dart';
import 'package:http/http.dart' as http;
part 'ocr_scanner_event.dart';
part 'ocr_scanner_state.dart';

@injectable
class OCRScannerBloc extends Bloc<OCRScannerEvent, OCRScannerState> {
  OCRScannerBloc() : super(OCRScannerInitialState()) {
    on<GetDataEvent>(_onGetData);
  }
  Future<void> _onGetData(
    GetDataEvent event,
    Emitter<OCRScannerState> emit,
  ) async {
    emit(
      GetDataState(
        status: BlocStatusState.loading,
        viewModel: state.viewModel,
      ),
    );
    try {
      List<int?> dataList = [];
      final selectedImage =
          await Navigator.pushNamed(event.context, RouteList.camera) as File?;
      if (selectedImage != null) {
        dataList = await uploadImage(croppedImage: selectedImage);
      }
      int? sys = dataList[0];
      int? dia = dataList[1];
      int? pulse = dataList[2];
      final newViewModel = state.viewModel
          .copyWith(imageFile: selectedImage, sys: sys, dia: dia, pulse: pulse);
      emit(
        state.copyWith(
          status: BlocStatusState.success,
          viewModel: newViewModel,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: BlocStatusState.failure,
          viewModel: state.viewModel,
        ),
      );
    }
  }
}

Future<List<int?>> uploadImage({required File croppedImage}) async {
  List<int?> dataList = [];
  final request = http.MultipartRequest("POST",
      Uri.parse("https://dassie-pleased-certainly.ngrok-free.app/upload"));
  final headers = {"Content-type": "multipart/form-data"};
  request.files.add(http.MultipartFile(
      'image', croppedImage.readAsBytes().asStream(), croppedImage.lengthSync(),
      filename: croppedImage.path.split("/").last));
  request.headers.addAll(headers);
  final response = await request.send();
  http.Response res = await http.Response.fromStream(response);

  try {
    final resJson = jsonDecode(res.body);
    String message = resJson['message'];

    debugPrint(message);
    dataList.add(resJson['sys']);
    dataList.add(resJson['dia']);
    dataList.add(resJson['pulse']);
  } catch (e) {
    debugPrint('$e');
  }
  return dataList;
}
