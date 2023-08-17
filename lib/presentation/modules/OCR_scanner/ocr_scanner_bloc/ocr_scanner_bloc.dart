import 'dart:convert';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile_health_check/common/service/firebase/firebase_storage_service.dart';
import 'package:mobile_health_check/domain/entities/blood_pressure_entity.dart';
import 'package:mobile_health_check/domain/usecases/blood_pressure_usecase/blood_pressure_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import '../../../common_widget/enum_common.dart';
import '../../../route/route_list.dart';
import 'package:http/http.dart' as http;
part 'ocr_scanner_event.dart';
part 'ocr_scanner_state.dart';

@injectable
class OCRScannerBloc extends Bloc<OCRScannerEvent, OCRScannerState> {
  BloodPressureUsecase bloodPressureUseCase;
  OCRScannerBloc(this.bloodPressureUseCase) : super(OCRScannerInitialState()) {
    on<GetInitialBloodPressureDataEvent>(_onGetInitialBloodPressureData);
    on<GetBloodPressureDataEvent>(_onGetBloodPressureData);
    on<UploadBloodPressureDataEvent>(_onUploadBloodPressureData);
    on<GetBloodGlucoseDataEvent>(_onGetBloodGlucoseData);
    on<GetTemperatureDataEvent>(_onGetTemperatureData);
  }
  Future<void> _onGetBloodPressureData(
    GetBloodPressureDataEvent event,
    Emitter<OCRScannerState> emit,
  ) async {
    emit(
      GetBloodPressureDataState(
        status: BlocStatusState.loading,
        viewModel: state.viewModel,
      ),
    );
    try {
      List<int?> dataList = [];
      final selectedImage =
          await Navigator.pushNamed(event.context, RouteList.camera) as File?;
      if (selectedImage != null) {
        dataList = await uploadBloodPressureImage(croppedImage: selectedImage);
      }
      int? sys = dataList[0];
      int? dia = dataList[1];
      int? pulse = dataList[2];
      final newViewModel = state.viewModel.copyWith(
          bloodPressureImageFile: selectedImage,
          sys: sys,
          dia: dia,
          pulse: pulse);
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

  Future<void> _onGetInitialBloodPressureData(
    GetInitialBloodPressureDataEvent event,
    Emitter<OCRScannerState> emit,
  ) async {
    emit(
      GetBloodPressureDataState(
        status: BlocStatusState.loading,
        viewModel: state.viewModel,
      ),
    );
    try {
      final response =
          await bloodPressureUseCase.getListBloodPressureEntities();
      int length = response.length;
      final newViewModel =
          state.viewModel.copyWith(listBloodPressureLength: length);
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

  Future<void> _onUploadBloodPressureData(
    UploadBloodPressureDataEvent event,
    Emitter<OCRScannerState> emit,
  ) async {
    emit(
      UploadBloodPressureDataState(
        status: BlocStatusState.loading,
        viewModel: state.viewModel,
      ),
    );
    try {
      String? imageUrl;

      final result = await FirebaseStorageService.uploadFile(
          file: state.viewModel.bloodPressureImageFile!,
          fileName: DateFormat('HH:mm dd-MM-yyyy').format(DateTime.now()),
          folder: 'Nguyen Trong Khang/Huyet ap/');
      if (result != null) {
        imageUrl = result.url;
      }

      final entity = BloodPressureEntity(
        dia: state.viewModel.dia,
        sys: state.viewModel.sys,
        pulse: state.viewModel.pulse,
        updatedDate: DateTime.now(),
        // imageLink: (state.viewModel.listBloodPressureLength ?? 0) + 1
      );

      await bloodPressureUseCase.createBloodPressureEntity(
          bloodPressureEntity: entity);
      emit(
        state.copyWith(
          status: BlocStatusState.success,
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

  Future<void> _onGetBloodGlucoseData(
    GetBloodGlucoseDataEvent event,
    Emitter<OCRScannerState> emit,
  ) async {
    emit(
      GetBloodGlucoseDataState(
        status: BlocStatusState.loading,
        viewModel: state.viewModel,
      ),
    );
    try {
      int? glucose;
      final selectedImage =
          await Navigator.pushNamed(event.context, RouteList.camera) as File?;
      if (selectedImage != null) {
        glucose = await uploadBloodGlucoseImage(croppedImage: selectedImage);
      }

      final newViewModel = state.viewModel
          .copyWith(bloodGlucoseImageFile: selectedImage, glucose: glucose);
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

  Future<void> _onGetTemperatureData(
    GetTemperatureDataEvent event,
    Emitter<OCRScannerState> emit,
  ) async {
    emit(
      GetTemperatureDataState(
        status: BlocStatusState.loading,
        viewModel: state.viewModel,
      ),
    );
    try {
      double? temperature;
      final selectedImage =
          await Navigator.pushNamed(event.context, RouteList.camera) as File?;
      if (selectedImage != null) {
        temperature = await uploadTemperatureImage(croppedImage: selectedImage);
      }

      final newViewModel = state.viewModel.copyWith(
          temperatureImageFile: selectedImage, temperature: temperature);
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

Future<List<int?>> uploadBloodPressureImage(
    {required File croppedImage}) async {
  List<int?> dataList = [];
  final request = http.MultipartRequest(
      "POST",
      Uri.parse(
          "hhttps://dassie-pleased-certainly.ngrok-free.app/blood_pressure"));
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

Future<int?> uploadBloodGlucoseImage({required File croppedImage}) async {
  int? glucose;
  final request = http.MultipartRequest(
      "POST",
      Uri.parse(
          "hhttps://dassie-pleased-certainly.ngrok-free.app/blood_glucose"));
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
    glucose = int.parse(resJson['glucose']);
  } catch (e) {
    debugPrint('$e');
  }
  return glucose;
}

Future<double?> uploadTemperatureImage({required File croppedImage}) async {
  double? temperature;
  final request = http.MultipartRequest("POST",
      Uri.parse("https://dassie-pleased-certainly.ngrok-free.app/temperature"));
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
    temperature = double.parse(resJson['temperature']);
  } catch (e) {
    debugPrint('$e');
  }
  return temperature;
}

enum ReadDataTask { temperature, bloodPressure, bloodGlucose }
