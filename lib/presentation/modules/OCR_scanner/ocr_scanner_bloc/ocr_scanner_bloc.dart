// ignore_for_file: use_build_context_synchronously, duplicate_ignore, avoid_print

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
import 'package:mobile_health_check/domain/usecases/patient_usecase/patient_usecase.dart';
import 'package:mobile_health_check/domain/usecases/temperature_usecase/temperature_usecase.dart';
import '../../../../domain/entities/spo2_entity.dart';
import '../../../../domain/network/network_info.dart';
import '../../../../domain/usecases/blood_sugar_usecase/blood_sugar_usecase.dart';
import '../../../../domain/usecases/spo2_usecase/spo2_usecase.dart';
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
  final PatientUsecase _patientUsecase;
  Spo2Usecase spo2UseCase;

  final NetworkInfo networkInfo;
  OCRScannerBloc(
      this.networkInfo,
      this.bloodPressureUseCase,
      this._patientUsecase,
      this.bloodSugarUseCase,
      this.temperatureUseCase,
      this.spo2UseCase)
      : super(OCRScannerInitialState()) {
    on<StartUpEvent>(_onStartUpAction);
    //?--- Blood pressure------------
    on<GetBloodPressureDataEvent>(_onGetBloodPressureData);
    on<UploadBloodPressureDataEvent>(_onUploadBloodPressureData);
    on<EditBloodPressureDataEvent>(_onEditBloodPressureData);
    //?--- Blood sugar------
    on<GetBloodGlucoseDataEvent>(_onGetBloodGlucoseData);
    on<UploadBloodGlucoseDataEvent>(_onUploadBloodGlucoseData);
    on<EditBloodSugarDataEvent>(_onEditBloodSugarData);
    //?--- Temperature---------
    on<GetTemperatureDataEvent>(_onGetTemperatureData);
    on<UploadTemperatureDataEvent>(_onUploadTemperatureData);
    on<EditBodyTemperatureDataEvent>(_onEditBodyTemperatureData);
    //?---- Spo2-----------
    on<GetSpo2DataEvent>(_onGetSpo2Data);
    on<UploadSpo2DataEvent>(_onUploadSpo2Data);
    on<EditSpo2DataEvent>(_onEditSpo2Data);
    //? -----getPatientImagesTaken------
    on<GetPatientImageTakenEvent>(_onGetPatientImageTaken);
  }
  Future<void> _onStartUpAction(
    StartUpEvent event,
    Emitter<OCRScannerState> emit,
  ) async {
    if (await networkInfo.isConnected == true) {
      emit(
        StartUpState(
          status: BlocStatusState.loading,
          viewModel: state.viewModel,
        ),
      );
      try {
        http.get(Uri.parse(url['testURL'] ?? ''));
        emit(state.copyWith(
          status: BlocStatusState.success,
          viewModel: state.viewModel,
        ));
      } catch (e) {
        emit(
          state.copyWith(
            status: BlocStatusState.failure,
            viewModel: state.viewModel.copyWith(),
          ),
        );
      }
    } else {
      emit(
        state.copyWith(
          status: BlocStatusState.failure,
          viewModel: state.viewModel.copyWith(),
        ),
      );
    }
  }
  //!---Blood Pressure------------------!//

  Future<void> _onGetBloodPressureData(
    GetBloodPressureDataEvent event,
    Emitter<OCRScannerState> emit,
  ) async {
    if (await networkInfo.isConnected == true) {
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
              sys: dataList[0],
              pulse: dataList[1],
              updatedDate: DateTime.now());

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
    } else {
      emit(
        state.copyWith(
          status: BlocStatusState.failure,
          viewModel: state.viewModel.copyWith(),
        ),
      );
    }
  }

  Future<void> _onUploadBloodPressureData(
    UploadBloodPressureDataEvent event,
    Emitter<OCRScannerState> emit,
  ) async {
    if (await networkInfo.isConnected == true) {
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
            patientId: userDataData.getUser()!.id!,
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
    } else {
      emit(
        state.copyWith(
          status: BlocStatusState.failure,
          viewModel: state.viewModel.copyWith(),
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

  //!------Blood Glucose----------------!//

  Future<void> _onGetBloodGlucoseData(
    GetBloodGlucoseDataEvent event,
    Emitter<OCRScannerState> emit,
  ) async {
    if (await networkInfo.isConnected == true) {
      emit(
        GetBloodGlucoseDataState(
          status: BlocStatusState.loading,
          viewModel: state.viewModel,
        ),
      );
      try {
        double? glucose;
        int? selectedIndexEquip = userDataData
            .localDataManager.preferencesHelper
            .getData('BloodSugarEquipModel');
        print("####$selectedIndexEquip");
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
    } else {
      emit(
        state.copyWith(
          status: BlocStatusState.failure,
          viewModel: state.viewModel.copyWith(),
        ),
      );
    }
  }

  Future<void> _onUploadBloodGlucoseData(
    UploadBloodGlucoseDataEvent event,
    Emitter<OCRScannerState> emit,
  ) async {
    if (await networkInfo.isConnected == true) {
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
            patientId: userDataData.getUser()!.id!,
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
    } else {
      emit(
        state.copyWith(
          status: BlocStatusState.failure,
          viewModel: state.viewModel.copyWith(),
        ),
      );
    }
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

  //!------Body Temperature----------------!//
  Future<void> _onGetTemperatureData(
    GetTemperatureDataEvent event,
    Emitter<OCRScannerState> emit,
  ) async {
    if (await networkInfo.isConnected == true) {
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
    } else {
      emit(
        state.copyWith(
          status: BlocStatusState.failure,
          viewModel: state.viewModel.copyWith(),
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

  Future<void> _onUploadTemperatureData(
    UploadTemperatureDataEvent event,
    Emitter<OCRScannerState> emit,
  ) async {
    if (await networkInfo.isConnected == true) {
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
            patientId: userDataData.getUser()!.id!,
            temperatureEntity: entity ?? TemperatureEntity());

        emit(
          UploadTemperatureDataState(
            status: BlocStatusState.success,
          ),
        );
      } catch (e) {
        emit(
          UploadTemperatureDataState(
            status: BlocStatusState.failure,
            viewModel: state.viewModel,
          ),
        );
      }
    } else {
      emit(
        UploadTemperatureDataState(
          status: BlocStatusState.failure,
          viewModel: state.viewModel.copyWith(),
        ),
      );
    }
  }

  //!------Spo2------------------------!//

  Future<void> _onGetSpo2Data(
    GetSpo2DataEvent event,
    Emitter<OCRScannerState> emit,
  ) async {
    if (await networkInfo.isConnected == true) {
      emit(
        GetSpo2DataState(
          status: BlocStatusState.loading,
          viewModel: state.viewModel,
        ),
      );
      try {
        int? spo2;
        var newViewModel = state.viewModel;
        final selectedImage = await Navigator.pushNamed(
            event.context, RouteList.camera,
            arguments: MeasuringTask.oximeter) as CroppedImage?;
        if (selectedImage != null) {
          spo2 = await uploadSpo2Image(
              croppedImage: selectedImage.croppedImage,
              flashOn: selectedImage.flashOn);
          newViewModel = state.viewModel.copyWith(
              spo2ImageFile: selectedImage.croppedImage,
              spo2Entity: Spo2Entity(spo2: spo2, updatedDate: DateTime.now()));
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
    } else {
      emit(
        state.copyWith(
          status: BlocStatusState.failure,
          viewModel: state.viewModel.copyWith(),
        ),
      );
    }
  }

  Future<void> _onUploadSpo2Data(
    UploadSpo2DataEvent event,
    Emitter<OCRScannerState> emit,
  ) async {
    if (await networkInfo.isConnected == true) {
      emit(
        UploadSpo2DataState(
          status: BlocStatusState.loading,
          viewModel: state.viewModel,
        ),
      );
      try {
        String? imageUrl = " ";

        final result = await FirebaseStorageService.uploadFile(
            file: state.viewModel.spo2ImageFile!,
            fileName: DateFormat('HH:mm dd-MM-yyyy').format(DateTime.now()),
            folder: '${userDataData.getUser()!.phoneNumber!}/SPO2/');
        if (result != null) {
          imageUrl = result.url;
        }

        final entity =
            state.viewModel.spo2Entity?.copywith(imageLink: imageUrl);

        await spo2UseCase.createSpo2Entity(
            patientId: userDataData.getUser()!.id!,
            spo2Entity: entity ?? Spo2Entity());
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
    } else {
      emit(
        state.copyWith(
          status: BlocStatusState.failure,
          viewModel: state.viewModel.copyWith(),
        ),
      );
    }
  }

  Future<void> _onEditSpo2Data(
    EditSpo2DataEvent event,
    Emitter<OCRScannerState> emit,
  ) async {
    emit(
      GetSpo2DataState(
        status: BlocStatusState.loading,
        viewModel: state.viewModel,
      ),
    );
    final spo2Entity =
        Spo2Entity(spo2: event.spo2, updatedDate: DateTime.now());
    final newViewModel = state.viewModel.copyWith(spo2Entity: spo2Entity);

    emit(
      state.copyWith(
        status: BlocStatusState.success,
        viewModel: newViewModel,
      ),
    );
  }

  Future<void> _onGetPatientImageTaken(
    GetPatientImageTakenEvent event,
    Emitter<OCRScannerState> emit,
  ) async {
    emit(GetImagesTakenState(
      status: BlocStatusState.loading,
      viewModel: state.viewModel,
    ));
    // );
    // emit()
    _patientUsecase.getPatientInforEntityInPatientApp(event.patientId);
    emit(
      GetImagesTakenState(
        status: BlocStatusState.success,
      ),
    );
  }
}

Future<List<int?>> uploadBloodPressureImage(
    {required File croppedImage, required bool flashOn}) async {
  List<int?> dataList = [];
  final request =
      http.MultipartRequest("POST", Uri.parse(url['bloodPressureURL'] ?? ''));
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
    dataList.add(resJson['pulse']);
  } catch (e) {
    debugPrint('$e');
  }
  return dataList;
}

Future<double?> uploadBloodGlucoseImage(
    {required File croppedImage, required bool flashOn}) async {
  double? glucose;

  final request =
      http.MultipartRequest("POST", Uri.parse(url['bloodSugarURL'] ?? ''));
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
  final request =
      http.MultipartRequest("POST", Uri.parse(url['tempURL'] ?? ''));
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

Future<int?> uploadSpo2Image(
    {required File croppedImage, required bool flashOn}) async {
  int? spo2;
  final request = http.MultipartRequest("POST", Uri.parse(url['oxiURL'] ?? ''));
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
    spo2 = resJson['spo2'];
  } catch (e) {
    debugPrint('$e');
  }
  return spo2;
}
