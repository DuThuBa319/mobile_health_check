import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

//import '../../utils.dart';

class FirebaseStorageService {
  FirebaseStorageService._();

  static Future<CloudStorageResult?> uploadFile({
    required File file,
    String? fileName,
    String? token,
    String? folder = 'uploads',
    String type = 'image/jpeg',
  }) async {
    // if (token != null && token.isNotEmpty == true) {
    //   await FirebaseAuth.instance.signInWithCustomToken(token);
    // }

    final customFileName = fileName?.isNotEmpty == true
        ? '$fileName.${basename(file.path).split('.').last}'
        : basename(file.path);

    // Create a Reference to the file
    final ref = FirebaseStorage.instance.ref('$folder/$customFileName');

    final metadata = SettableMetadata(
      contentType: type,
      customMetadata: {
        'picked-file-path': file.path,
      },
    );

    // final snapshot = await ref.putFile(file, metadata).catchError(
    //       (error, stackTrace) => LogUtils.eCatch<TaskSnapshot>(
    //         'putFile',
    //         error,
    //         stackTrace,
    //       ),
    //     );
    final snapshot = await ref.putFile(file, metadata);
    if (snapshot.state == TaskState.success) {
      return CloudStorageResult(
        url: await snapshot.ref.getDownloadURL(),
        fileName: customFileName,
      );
    }
    return null;
  }
}

class CloudStorageResult {
  final String? url;
  final String? fileName;

  CloudStorageResult({this.url, this.fileName});
}