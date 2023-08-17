// import 'package:mobile_health_check/data/models/user_model.dart';
// import 'package:mobile_health_check/domain/entities/user_entity.dart';
// import 'package:mobile_health_check/presentation/common_widget/screen_form/custom_screen_form.dart';
// import 'package:mobile_health_check/presentation/theme/theme_color.dart';
// import 'package:flutter/material.dart';
// import '../../bloc/userlist/get_user_detail_bloc/get_user_detail_bloc.dart';

// //Class Home

// class EditScreen extends StatefulWidget {
//   final UserEntity userEntity;
//   final GetUserDetailBloc detailBloc;
//   const EditScreen(
//       {super.key, required this.userEntity, required this.detailBloc});

//   @override
//   State<EditScreen> createState() => _EditScreenState();
// }

// class _EditScreenState extends State<EditScreen> {
//   final TextEditingController _controllerId = TextEditingController();
//   final TextEditingController _controllerName = TextEditingController();
//   final TextEditingController _controllerJob = TextEditingController();
//   final TextEditingController _controllerEmail = TextEditingController();
//   final TextEditingController _controllerPhoneNumber = TextEditingController();
//   final TextEditingController _controllerAge = TextEditingController();
//   @override
//   void initState() {
//     super.initState();
//     setState(() {
//       _controllerId.text = widget.userEntity.id.toString();
//       _controllerName.text = widget.userEntity.name!;
//       _controllerJob.text = widget.userEntity.job!;
//       _controllerAge.text = widget.userEntity.age.toString();
//       _controllerEmail.text = widget.userEntity.email!;
//       _controllerPhoneNumber.text = widget.userEntity.phoneNumber!;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CustomScreenForm(
//       appBarColor: AppColor.appBarColor,
//       backgroundColor: Colors.white,
//       isShowAppBar: true,
//       isShowLeadingButton: true,
//       title: 'Edit User Screen',
//       child: ListView(padding: const EdgeInsets.all(20), children: [
//         const SizedBox(
//           height: 20,
//         ),
//         TextField(
//           controller: _controllerId,
//           decoration: const InputDecoration(hintText: "Id:"),
//         ),
//         const SizedBox(height: 10),
//         TextField(
//           controller: _controllerAge,
//           decoration: const InputDecoration(hintText: "Age:"),
//         ),
//         const SizedBox(height: 10),
//         TextField(
//           controller: _controllerJob,
//           decoration: const InputDecoration(hintText: "Job:"),
//         ),
//         const SizedBox(height: 10),
//         TextField(
//           controller: _controllerName,
//           decoration: const InputDecoration(hintText: "Name:"),
//         ),
//         const SizedBox(height: 10),
//         TextField(
//           controller: _controllerEmail,
//           decoration: const InputDecoration(hintText: "Email:"),
//         ),
//         const SizedBox(height: 10),
//         TextField(
//           controller: _controllerPhoneNumber,
//           decoration: const InputDecoration(hintText: "PhoneNumber:"),
//         ),
//         const SizedBox(height: 10),
//         ElevatedButton(
//             onPressed: () async {
//               UserModel newUser = UserModel(
//                 id: int.parse(_controllerId.text),
//                 age: int.parse(_controllerAge.text),
//                 job: _controllerJob.text,
//                 name: _controllerName.text,
//                 email: _controllerEmail.text,
//                 phoneNumber: _controllerPhoneNumber.text,
//               );
//               widget.detailBloc
//                   .add(UpdateUserEvent(userId: newUser.id!, user: newUser));

//               Navigator.pop(context);
//               // Navigator.pop(context);
//             },
//             child: const Text("Save"))
//       ]),
//     );
//   }
// }