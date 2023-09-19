import 'dart:convert';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile_health_check/common/service/firebase/firebase_storage_service.dart';
import 'package:mobile_health_check/common/singletons.dart';
import 'package:mobile_health_check/domain/entities/blood_pressure_entity.dart';
import 'package:mobile_health_check/domain/entities/blood_sugar_entity.dart';
import 'package:mobile_health_check/domain/entities/temperature_entity.dart';
import 'package:mobile_health_check/domain/usecases/blood_pressure_usecase/blood_pressure_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_health_check/domain/usecases/temperature_usecase/temperature_usecase.dart';
import '../../../../domain/usecases/blood_sugar_usecase/blood_sugar_usecase.dart';
import '../../../common_widget/enum_common.dart';
import '../../../route/route_list.dart';
import 'package:http/http.dart' as http;
part 'ocr_scanner_event.dart';
part 'ocr_scanner_state.dart';

@injectable
class OCRScannerBloc extends Bloc<OCRScannerEvent, OCRScannerState> {
  BloodPressureUsecase bloodPressureUseCase;
  BloodSugarUsecase bloodSugarUseCase;
  TemperatureUsecase temperatureUseCase;
  OCRScannerBloc(this.bloodPressureUseCase, this.bloodSugarUseCase,
      this.temperatureUseCase)
      : super(OCRScannerInitialState()) {
    // on<GetInitialBloodPressureDataEvent>(_onGetInitialBloodPressureData);
    on<GetBloodPressureDataEvent>(_onGetBloodPressureData);
    on<UploadBloodPressureDataEvent>(_onUploadBloodPressureData);
    on<EditBloodPressureDataEvent>(_onEditBloodPressureData);
    on<GetBloodGlucoseDataEvent>(_onGetBloodGlucoseData);
    on<UploadBloodGlucoseDataEvent>(_onUploadBloodGlucoseData);
    on<EditBloodSugarDataEvent>(_onEditBloodSugarData);
    on<GetTemperatureDataEvent>(_onGetTemperatureData);
    on<UploadTemperatureDataEvent>(_onUploadTemperatureData);
    on<EditBodyTemperatureDataEvent>(_onEditBodyTemperatureData);
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
      var newViewModel = state.viewModel;
      final selectedImage = await Navigator.pushNamed(
          event.context, RouteList.camera,
          arguments: MeasuringTask.bloodPressure) as CroppedImage?;
      if (selectedImage != null) {
        dataList = await uploadBloodPressureImage(
            croppedImage: selectedImage.croppedImage,
            flashOn: selectedImage.flashOn);
        //  dataList = await sendImageToAzureFunction(selectedImage);
        final bloodPressureEntity = BloodPressureEntity(
            sys: dataList[0], pulse: dataList[2], updatedDate: DateTime.now());

        newViewModel = state.viewModel.copyWith(
            bloodPressureImageFile: selectedImage.croppedImage,
            bloodPressureEntity: bloodPressureEntity);
      }
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

  Future<void> _onEditBloodPressureData(
    EditBloodPressureDataEvent event,
    Emitter<OCRScannerState> emit,
  ) async {
    emit(
      GetBloodPressureDataState(
        status: BlocStatusState.loading,
        viewModel: state.viewModel,
      ),
    );
    final bloodPressureEntity = BloodPressureEntity(
        sys: event.editedSys,
        pulse: event.editedPul,
        updatedDate: DateTime.now());
    final newViewModel =
        state.viewModel.copyWith(bloodPressureEntity: bloodPressureEntity);

    emit(
      state.copyWith(
        status: BlocStatusState.success,
        viewModel: newViewModel,
      ),
    );
  }

  Future<void> _onEditBloodSugarData(
    EditBloodSugarDataEvent event,
    Emitter<OCRScannerState> emit,
  ) async {
    emit(
      GetBloodGlucoseDataState(
        status: BlocStatusState.loading,
        viewModel: state.viewModel,
      ),
    );
    final bloodSugarEntity = BloodSugarEntity(
        bloodSugar: event.glucose, updatedDate: DateTime.now());
    final newViewModel =
        state.viewModel.copyWith(bloodSugarEntity: bloodSugarEntity);

    emit(
      state.copyWith(
        status: BlocStatusState.success,
        viewModel: newViewModel,
      ),
    );
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
      double? glucose;
      var newViewModel = state.viewModel;
      final selectedImage = await Navigator.pushNamed(
          event.context, RouteList.camera,
          arguments: MeasuringTask.bloodSugar) as CroppedImage?;
      if (selectedImage != null) {
        glucose = await uploadBloodGlucoseImage(
            croppedImage: selectedImage.croppedImage,
            flashOn: selectedImage.flashOn);

        newViewModel = state.viewModel.copyWith(
            bloodGlucoseImageFile: selectedImage.croppedImage,
            bloodSugarEntity: BloodSugarEntity(
                bloodSugar: glucose, updatedDate: DateTime.now()));
      }

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
      var newViewModel = state.viewModel;
      final selectedImage = await Navigator.pushNamed(
          event.context, RouteList.camera,
          arguments: MeasuringTask.temperature) as CroppedImage?;
      if (selectedImage != null) {
        temperature = await uploadTemperatureImage(
            croppedImage: selectedImage.croppedImage,
            flashOn: selectedImage.flashOn);
        newViewModel = state.viewModel.copyWith(
            temperatureImageFile: selectedImage.croppedImage,
            temperatureEntity: TemperatureEntity(
                temperature: temperature, updatedDate: DateTime.now()));
      }

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
      String? imageUrl = " ";

      final result = await FirebaseStorageService.uploadFile(
          file: state.viewModel.bloodPressureImageFile!,
          fileName: DateFormat('HH:mm dd-MM-yyyy').format(DateTime.now()),
          folder: '${userDataData.getUser()!.phoneNumber!}/Huyet ap/');
      //thay tên folder bằng getUser...
      if (result != null) {
        imageUrl = result.url;
      }

      final entity =
          state.viewModel.bloodPressureEntity?.copywith(imageLink: imageUrl);

      await bloodPressureUseCase.createBloodPressureEntity(
          id: userDataData.getUser()!.id!,
          bloodPressureEntity: entity ?? BloodPressureEntity());
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

  Future<void> _onEditBodyTemperatureData(
    EditBodyTemperatureDataEvent event,
    Emitter<OCRScannerState> emit,
  ) async {
    emit(
      GetTemperatureDataState(
        status: BlocStatusState.loading,
        viewModel: state.viewModel,
      ),
    );
    final bodyTemperatureEntity = TemperatureEntity(
        temperature: event.temperature, updatedDate: DateTime.now());
    final newViewModel =
        state.viewModel.copyWith(temperatureEntity: bodyTemperatureEntity);

    emit(
      state.copyWith(
        status: BlocStatusState.success,
        viewModel: newViewModel,
      ),
    );
  }

  Future<void> _onUploadBloodGlucoseData(
    UploadBloodGlucoseDataEvent event,
    Emitter<OCRScannerState> emit,
  ) async {
    emit(
      UploadBloodGlucoseDataState(
        status: BlocStatusState.loading,
        viewModel: state.viewModel,
      ),
    );
    try {
      String? imageUrl = " ";

      final result = await FirebaseStorageService.uploadFile(
          file: state.viewModel.bloodGlucoseImageFile!,
          fileName: DateFormat('HH:mm dd-MM-yyyy').format(DateTime.now()),
          folder: '${userDataData.getUser()!.phoneNumber!}/Duong huyet/');
      if (result != null) {
        imageUrl = result.url;
      }

      final entity =
          state.viewModel.bloodSugarEntity?.copywith(imageLink: imageUrl);

      await bloodSugarUseCase.createBloodSugarEntity(
          id: userDataData.getUser()!.id!,
          bloodSugarEntity: entity ?? BloodSugarEntity());
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

  Future<void> _onUploadTemperatureData(
    UploadTemperatureDataEvent event,
    Emitter<OCRScannerState> emit,
  ) async {
    emit(
      UploadTemperatureDataState(
        status: BlocStatusState.loading,
        viewModel: state.viewModel,
      ),
    );
    try {
      String? imageUrl = " ";

      final result = await FirebaseStorageService.uploadFile(
          file: state.viewModel.temperatureImageFile!,
          fileName: DateFormat('HH:mm dd-MM-yyyy').format(DateTime.now()),
          folder: '${userDataData.getUser()!.phoneNumber!}/Nhiet Do/');
      if (result != null) {
        imageUrl = result.url;
      }

      final entity =
          state.viewModel.temperatureEntity?.copywith(imageLink: imageUrl);

      await temperatureUseCase.createTemperatureEntity(
          id: userDataData.getUser()!.id!,
          temperatureEntity: entity ?? TemperatureEntity());
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
}

Future<List<int?>> uploadBloodPressureImage(
    {required File croppedImage, required bool flashOn}) async {
  List<int?> dataList = [];
  final request = http.MultipartRequest(
      "POST",
      Uri.parse(
          "https://flask-server.azurewebsites.net/api/bloodpressure?code=VsvpcH9u0z8Wlo4EBEqBg9LlUE0x37h65w5QZdu2Pb74AzFux8d7gQ%3D%3D"));
  final headers = {"Content-type": "multipart/form-data"};
  request.files.add(http.MultipartFile(
      'image', croppedImage.readAsBytes().asStream(), croppedImage.lengthSync(),
      filename: croppedImage.path.split("/").last));
  request.fields['flashOn'] = flashOn.toString();
  request.headers.addAll(headers);
  final response = await request.send();
  http.Response res = await http.Response.fromStream(response);

  try {
    final resJson = jsonDecode(res.body);
    dataList.add(resJson['sys']);
    dataList.add(resJson['dia']);
    dataList.add(resJson['pulse']);
  } catch (e) {
    debugPrint('$e');
  }
  return dataList;
}

Future<double?> uploadBloodGlucoseImage(
    {required File croppedImage, required bool flashOn}) async {
  double? glucose;
  final request = http.MultipartRequest(
      "POST",
      Uri.parse(
          "https://flask-server.azurewebsites.net/api/bloodglucose?code=7s34g-FdGx_VRWYQHkCvb55Zv4mkXOgECRhsqmnzqtBrAzFua74kWA%3D%3D"));
  final headers = {"Content-type": "multipart/form-data"};
  request.files.add(http.MultipartFile(
      'image', croppedImage.readAsBytes().asStream(), croppedImage.lengthSync(),
      filename: croppedImage.path.split("/").last));
  request.fields['flashOn'] = flashOn.toString();
  request.headers.addAll(headers);
  final response = await request.send();
  http.Response res = await http.Response.fromStream(response);

  try {
    final resJson = jsonDecode(res.body);
    // String message = resJson['message'];

    // debugPrint(message);
    glucose = double.parse(resJson['glucose']);
  } catch (e) {
    debugPrint('$e');
  }
  return glucose;
}

Future<double?> uploadTemperatureImage(
    {required File croppedImage, required bool flashOn}) async {
  double? temperature;
  final request = http.MultipartRequest(
      "POST",
      Uri.parse(
          "https://flask-server.azurewebsites.net/api/bodytemperature?code=Za4DcoO9bc5IMMUnBDMqWR8QY8r9dvg4VoMD_tdph7xrAzFuE31tfA%3D%3D"));
  final headers = {"Content-type": "multipart/form-data"};
  request.files.add(http.MultipartFile(
      'image', croppedImage.readAsBytes().asStream(), croppedImage.lengthSync(),
      filename: croppedImage.path.split("/").last));
  request.fields['flashOn'] = flashOn.toString();
  request.headers.addAll(headers);
  final response = await request.send();
  http.Response res = await http.Response.fromStream(response);

  try {
    final resJson = jsonDecode(res.body);
    // String message = resJson['message'];

    // debugPrint(message);
    temperature = double.parse(resJson['temperature']);
  } catch (e) {
    debugPrint('$e');
  }
  return temperature;
}

enum ReadDataTask { temperature, bloodPressure, bloodGlucose }
