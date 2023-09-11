part of 'image_picker_widget.dart';

extension ImagePickerAction on _ImagePickerGridViewState {
  void _blocListener(BuildContext context, ImagePickerState state) {
    if (state is GetImageState && state.status == BlocStatusState.loading) {
      showToast(translation(context).photoLoading);
    }
    // if (state is GetImageState && state.status == BlocStatusState.success) {
    //   //showToast('Lấy hình ảnh thành công');

    //   widget.receiveBloc!
    //       .add(ReceiveImageFileEvent(imageFiles: state.viewModel.imageFiles));
    // }
  }

  Future<ImageSource> selectSource() async {
    ImageSource source;
    final completer = Completer<ImageSource>();
    await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.15,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: Wrap(
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              ListTile(
                leading: const Icon(
                  Icons.photo_library,
                ),
                title: const Text(
                  'Gallery',
                  style: TextStyle(),
                ),
                onTap: () {
                  Navigator.of(context).pop(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.photo_camera,
                ),
                title: const Text(
                  'Camera',
                  style: TextStyle(),
                ),
                onTap: () {
                  Navigator.of(context).pop(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    ).then(completer.complete);
    return completer.future;
  }

  Future<void> showPicker(BuildContext context) async {
    ImageSource source;
    source = await selectSource();
    widget.bloc?.add(GetImageEvent(source: source));
  }

  void editPicker(BuildContext context, int index) {
    showModalBottomSheet(
      //backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext bc) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.15,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: Wrap(
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              ListTile(
                leading: const Icon(
                  Icons.replay,
                ),
                title: const Text(
                  'Replace',
                  style: TextStyle(),
                ),
                onTap: () async {
                  ImageSource source;
                  source = await selectSource();
                  widget.bloc
                      ?.add(ReplaceImageEvent(source: source, index: index));
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.delete,
                ),
                title: const Text(
                  'Delete',
                  style: TextStyle(),
                ),
                onTap: () {
                  widget.bloc?.add(DeleteImageEvent(index: index));
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
