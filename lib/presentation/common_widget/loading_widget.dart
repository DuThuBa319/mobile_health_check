import 'package:flutter/cupertino.dart';
import 'package:mobile_health_check/utils/size_config.dart';

class Loading extends StatelessWidget {
  final Brightness brightness;

  const Loading({
    Key? key,
    this.brightness = Brightness.dark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return CupertinoTheme(
      data: CupertinoTheme.of(context).copyWith(brightness: brightness),
      child: CupertinoActivityIndicator(
        radius: SizeConfig.screenWidth * 0.035,
      ),
    );
  }
}
