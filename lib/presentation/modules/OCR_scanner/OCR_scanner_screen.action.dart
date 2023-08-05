part of 'OCR_scanner_screen.dart';

extension OCRScannerScreenAction on _OCRScannerScreenState {
  void blocListener(BuildContext context, OCRScannerState state) async {
    if (state.status == BlocStatusState.loading) {
      showToast('Đang tải dữ liệu');
    }
    if (state.status == BlocStatusState.success) {
      showToast('Tải dữ liệu thành công');
    }
  }

  // Future<void> _imagePickerBlocListener(
  //     BuildContext context, ImagePickerState state) async {
  //   if (state is GetImageState && state.status == BlocStatusState.loading) {
  //     showToast('Đang tải dữ liệu');
  //   }
  //   if (state is GetImageState && state.status == BlocStatusState.success) {
  //     showToast('Tải dữ liệu thành công');
  //     selectedImage = state.viewModel.imageFiles![0];
  //     uploadImage(imageFile: selectedImage);
  //     final InputImage inputImage =
  //         InputImage.fromFile(state.viewModel.imageFiles![0]);
  //     log(inputImage.filePath!);
  //     final textRecognizer = TextRecognizer(
  //       script: TextRecognitionScript.latin,
  //     );
  //     final RecognizedText recognizedText =
  //         await textRecognizer.processImage(inputImage);

  //     var listtring = recognizedText.text.split('\n');
  //     for (var splitString in listtring) {
  //       debugPrint(splitString);
  //       try {
  //         var number = double.parse(splitString);
  //         print(splitString);
  //         textController.text += '$number ';
  //       } catch (e) {}
  //     }
  //     setState(() {});
  //   }
  // }
}
