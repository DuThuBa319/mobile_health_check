part of 'OCR_scanner_screen.dart';

extension OCRScannerScreenAction on _OCRScannerScreenState {
  Future<void> _imagePickerBlocListener(
      BuildContext context, ImagePickerState state) async {
    if (state is GetImageState && state.status == BlocStatusState.loading) {
      showToast('Đang tải dữ liệu');
    }
    if (state is GetImageState && state.status == BlocStatusState.success) {
      showToast('Tải dữ liệu thành công');
      selectedImage = state.viewModel.imageFiles![0];
      await uploadImage();
      // final InputImage inputImage =
      //     InputImage.fromFile(state.viewModel.imageFiles![0]);
      // log(inputImage.filePath!);
      // final textRecognizer = TextRecognizer(
      //   script: TextRecognitionScript.latin,
      // );
      // final RecognizedText recognizedText =
      //     await textRecognizer.processImage(inputImage);

      // var listtring = recognizedText.text.split('\n');
      // for (var splitString in listtring) {
      //   print(splitString);
      //   try {
      //     var number = double.parse(splitString);
      //     print(splitString);
      //     textController.text += '$number ';
      //   } catch (e) {}
      // }
      // setState(() {});
    }
  }

  uploadImage() async {
    final request = http.MultipartRequest(
        "POST",
        Uri.parse(
            "https://edc1-2402-9d80-32c-9c4b-3170-1687-bb97-7845.ngrok.io/upload"));
    final headers = {"Content-type": "multipart/form-data"};
    request.files.add(http.MultipartFile('image',
        selectedImage!.readAsBytes().asStream(), selectedImage!.lengthSync(),
        filename: selectedImage!.path.split("/").last));
    request.headers.addAll(headers);
    final response = await request.send();
    http.Response res = await http.Response.fromStream(response);
    final resJson = jsonDecode(res.body);
    message = resJson['message'];

    setState(() {});
  }
}
