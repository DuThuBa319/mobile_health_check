part of 'home_screen.dart';

extension HomeAction on _HomeScreenState {
  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit an App'),
            actions: <Widget>[
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pop(false), //<-- SEE HERE
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () {
                  SystemNavigator.pop();
                },
                // <-- SEE HERE
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  Widget infoText({required String title, required String content}) {
    return Column(
      children: [
        Text(title,
            style: AppTextTheme.body4
                .copyWith(color: Colors.black, fontWeight: FontWeight.w400)),
        const SizedBox(height: 5),
        Text(content,
            style: AppTextTheme.body1
                .copyWith(color: Colors.black, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget historyLook() {
    return Row(
      children: [
        Text(translation(context).watchHistory,
            style: AppTextTheme.body5.copyWith(
                color: Colors.blue,
                fontSize: 17,
                decoration: TextDecoration.underline,
                decorationThickness: 1)),
      ],
    );
  }

  Widget homeCell(
      {required String imagePath,
      required String indicator,
      required Color color}) {
    Size screenSize = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              blurRadius: 15,
              color: Colors.black26,
            )
          ]),
      height: screenSize.height * 0.18,
      width: screenSize.width,
      margin: const EdgeInsets.fromLTRB(15, 0, 12, 10),
      padding: const EdgeInsets.only(top: 10, left: 12, right: 12),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    padding: const EdgeInsets.all(5),
                    height: screenSize.width * 0.20,
                    width: screenSize.width * 0.20,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                    )),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(indicator,
                        style: AppTextTheme.title4
                            .copyWith(color: Colors.black, fontSize: 18)),
                    const SizedBox(height: 2),
                    // Text(
                    //   DateFormat('hh:mm dd/MM/yyyy')
                    //       .format(widget.response!.updatedDate!),
                    //   style: AppTextTheme.title5.copyWith(fontSize: 10),
                    // )
                  ],
                )
              ],
            ),
          ],
        ),
        const Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(width: 165),
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.end,
            //   children: [
            //     Text('${widget.response!.sys}/${widget.response!.dia}',
            //         style: AppTextTheme.body2.copyWith(
            //             fontSize: 30, fontWeight: FontWeight.w400)),
            //     Text('mmHg',
            //         style: AppTextTheme.body2.copyWith(
            //             fontSize: 10, fontWeight: FontWeight.w400)),
            //   ],
            // ),
            // const SizedBox(width: 20),
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.end,
            //   children: [
            //     Text('${widget.response!.pulse}',
            //         style: AppTextTheme.body1.copyWith(
            //             fontSize: 24, fontWeight: FontWeight.w400)),
            //     Text('bpm',
            //         style: AppTextTheme.body1.copyWith(
            //             fontSize: 14, fontWeight: FontWeight.w400)),
            //   ],
            // ),
          ],
        )
      ]),
    );
  }
}
