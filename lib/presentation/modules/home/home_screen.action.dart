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
            style: AppTextTheme.body2
                .copyWith(color: Colors.black, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget lineDecor() {
    return Container(
      decoration: const BoxDecoration(
          color: AppColor.lineDecor,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      height: 12,
      width: 100,
    );
  }

  Widget historyLook() {
    return Row(
      children: [
        Text("Xem lịch sử",
            style: AppTextTheme.body5
                .copyWith(color: Colors.black, fontWeight: FontWeight.w400)),
        Container(
          margin: const EdgeInsets.only(right: 15),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColor.cardBackgroundColor,
          ),
          height: 45,
          width: 45,
          child: const Center(
            child: Icon(Icons.history, color: Colors.black, size: 30),
          ),
        ),
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
          color: AppColor.cardBackgroundColor,
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
              children: [
                Container(
                    padding: const EdgeInsets.all(5),
                    height: screenSize.width * 0.22,
                    width: screenSize.width * 0.22,
                    decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 10,
                            color: Colors.black26,
                          )
                        ]),
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
                        style:
                            AppTextTheme.title4.copyWith(color: Colors.black)),
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
