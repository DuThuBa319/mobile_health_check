part of 'camera_demo_screen.dart';

// HẠN CHẾ SETSTATE NHẤT CÓ THỂ, PHẢI THỂ HIỆN ĐƯỢC CÁI STRING
extension CameraScreenAction on _CameraScreenState {
  void blocListener(BuildContext context, CameraState state) async {
    if (state is GetImageState && state.status == BlocStatusState.loading) {
      showToast('Đang xử lý');
    }
    if (state is GetImageState && state.status == BlocStatusState.success) {
      showToast('Xử lý thành công');
      await imageDialog(context, imageFile: state.viewModel.imageFile!);
    }
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    final previousCameraController = controller;
    // Instantiating the camera controller
    final CameraController cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.max,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    // Dispose the previous controller
    await previousCameraController?.dispose();

    // Replace with the new controller
    if (mounted) {
      setState(() {
        controller = cameraController;
      });
    }

    // Update UI if controller updated
    cameraController.addListener(() {
      if (mounted) setState(() {});
    });

    // Initialize controller
    try {
      await cameraController.initialize();
    } on CameraException catch (e) {
      debugPrint('Error initializing camera: $e');
    }

    // Update the Boolean
    if (mounted) {
      setState(() {
        isCameraInitialized = controller!.value.isInitialized;
        backgroundColor = Colors.black;
      });
    }

    cameraController
        .getMaxZoomLevel()
        .then((value) => maxAvailableZoom = value);

    cameraController
        .getMinZoomLevel()
        .then((value) => minAvailableZoom = value);
    cameraController
        .getMinExposureOffset()
        .then((value) => minAvailableExposureOffset = value);

    cameraController
        .getMaxExposureOffset()
        .then((value) => maxAvailableExposureOffset = value);
    currentFlashMode = controller!.value.flashMode;
  }

  void onViewFinderTap(TapDownDetails details, BoxConstraints constraints) {
    if (controller == null) {
      return;
    }
    final offset = Offset(
      details.localPosition.dx / constraints.maxWidth,
      details.localPosition.dy / constraints.maxHeight,
    );
    controller!.setExposurePoint(offset);
    controller!.setFocusPoint(offset);
  }

  Future<dynamic> imageDialog(BuildContext context, {required File imageFile}) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Hình ảnh bạn vừa chụp'),
              content: Container(
                height: 400,
                width: 350,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(width: 1, color: Colors.blue)),
                child: ClipRRect(
                  borderRadius: BorderRadiusDirectional.circular(20),
                  child: FullScreenWidget(
                      disposeLevel: DisposeLevel.High,
                      child: Image.file(
                        File(imageFile.path),
                      )),
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Chụp lại')),
                const SizedBox(width: 10),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context, imageFile);
                    },
                    child: const Text('Đồng ý'))
              ],
            ));
  }
}
