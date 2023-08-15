// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:mobile_health_check/presentation/theme/theme_color.dart';

import '../../theme/app_text_theme.dart';

Widget settingMenuCell(String selectSetting, double height, double width) {
  return Container(
    margin: const EdgeInsets.only(top: 15, bottom: 15),
    decoration: BoxDecoration(
        color: AppColor.cardBackground,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            blurRadius: 15,
            color: Colors.black12,
          )
        ]),
    height: height,
    width: width,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          const SizedBox(
            width: 10,
          ),
          selectSetting == "Cập nhật mật khẩu"
              ? const Icon(
                  Icons.lock_outline_rounded,
                  size: 38,
                )
              : selectSetting == "Cập nhật số điện thoại"
                  ? const Icon(Icons.account_box_rounded, size: 38)
                  : const Icon(Icons.language, size: 38),
          const SizedBox(
            width: 20,
          ),
          Text(selectSetting, style: AppTextTheme.body1.copyWith()),
        ]),
        const Icon(Icons.arrow_forward_ios_rounded, size: 30),
      ],
    ),
  );
}

///
Widget settingPhoneCell(String? selectSetting, double height, double width) {
  String phone = "";
  final phoneController = TextEditingController();
  return Container(
    margin: const EdgeInsets.only(top: 15, bottom: 15),
    decoration: BoxDecoration(
      color: AppColor.cardBackground,
      borderRadius: BorderRadius.circular(15),
    ),
    height: height,
    width: width,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          const SizedBox(
            width: 20,
          ),
          SizedBox(
            height: height * 0.7,
            width: width * 0.8,
            child: TextField(
              textAlign: TextAlign.start,
              onChanged: (newphone) {
                phone = newphone;
              },
              cursorColor: AppColor.black,
              controller: phoneController,
              style: const TextStyle(fontSize: 20, color: Colors.black),
              decoration: InputDecoration(
                border: InputBorder.none,
                labelText: selectSetting,
                icon: const Icon(Icons.account_box_rounded, size: 38),
                labelStyle:
                    const TextStyle(color: AppColor.gray767676, fontSize: 20),
              ),
            ),
          ),
          // Text(selectSetting, style: AppTextTheme.body1.copyWith()),
        ]),
      ],
    ),
  );
}

//

// ignore: must_be_immutable
class SettingPasswordCell extends StatefulWidget {
  final String? selectSetting;
  final double height;
  final double width;
  bool showPass;
  SettingPasswordCell(
      {Key? key,
      required this.selectSetting,
      required this.height,
      required this.width,
      required this.showPass})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SettingPasswordCellState createState() => _SettingPasswordCellState();
}

class _SettingPasswordCellState extends State<SettingPasswordCell> {
  String pass = "";
  final passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15, bottom: 15),
      decoration: BoxDecoration(
        color: AppColor.cardBackground,
        borderRadius: BorderRadius.circular(15),
      ),
      height: widget.height,
      width: widget.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            const SizedBox(
              width: 20,
            ),
            SizedBox(
              height: widget.height * 0.7,
              width: widget.width * 0.9,
              child: TextField(
                obscureText: widget.showPass,
                textAlign: TextAlign.start,
                onChanged: (newPass) {
                  pass = newPass;
                },
                cursorColor: AppColor.black,
                controller: passController,
                style: const TextStyle(fontSize: 20, color: Colors.black),
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(widget.showPass
                        ? Icons.visibility_off
                        : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        widget.showPass = !widget.showPass;
                      });
                    },
                  ),
                  border: InputBorder.none,
                  labelText: widget.selectSetting,
                  icon: const Icon(Icons.lock_outline_rounded, size: 38),
                  labelStyle:
                      const TextStyle(color: AppColor.gray767676, fontSize: 20),
                ),
              ),
            ),

            // Text(selectSetting, style: AppTextTheme.body1.copyWith()),
          ]),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class SettingLanguageCell extends StatefulWidget {
  final String? selectSetting1;
  final String? selectSetting2;
  final double height;
  final double width;
  bool select1;
  bool select2;
  SettingLanguageCell({
    Key? key,
    required this.selectSetting1,
    required this.selectSetting2,
    required this.height,
    required this.width,
    required this.select1,
    required this.select2,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SettingLanguageCellState createState() => _SettingLanguageCellState();
}

class _SettingLanguageCellState extends State<SettingLanguageCell> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 15, bottom: 15),
          decoration: BoxDecoration(
            color: AppColor.cardBackground,
            borderRadius: BorderRadius.circular(20),
          ),
          height: widget.height,
          width: widget.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: widget.width * 0.15,
              ),
              Text(widget.selectSetting1!,
                  style: AppTextTheme.body1.copyWith()),
              SizedBox(
                width: widget.width * 0.17,
              ),
              GestureDetector(
                  child: Container(
                    height: widget.height * 0.5,
                    width: widget.width * 0.4,
                    decoration: BoxDecoration(
                      color:
                          widget.select1 == false ? Colors.white : Colors.blue,
                      shape: BoxShape.circle,
                      border: Border.all(
                          width: 3,
                          color: widget.select1 == false
                              ? AppColor.topGradient
                              : Colors.white),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      widget.select1 = true;
                      widget.select2 = false;
                    });
                  }),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 15, bottom: 15),
          decoration: BoxDecoration(
            color: AppColor.cardBackground,
            borderRadius: BorderRadius.circular(20),
          ),
          height: widget.height,
          width: widget.width,
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            SizedBox(
              width: widget.width * 0.15,
            ),
            Text(widget.selectSetting2!, style: AppTextTheme.body1.copyWith()),
            GestureDetector(
                child: Container(
                  height: widget.height * 0.5,
                  width: widget.width * 0.4,
                  decoration: BoxDecoration(
                    color: widget.select2 == false ? Colors.white : Colors.blue,
                    shape: BoxShape.circle,
                    border: Border.all(
                        width: 3,
                        color: widget.select2 == false
                            ? AppColor.topGradient
                            : Colors.white),
                  ),
                ),
                onTap: () {
                  setState(() {
                    widget.select2 = true;
                    widget.select1 = false;
                  });
                })
          ]),
        ),
      ],
    );
  }
}
