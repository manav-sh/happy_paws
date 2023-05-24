import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';

class FirestoreImage {
  static Future<String?> uploadFile(File? photo) async {
    if (photo == null) return null;
    final fileName = basename(photo.path);
    final destination = 'files/$fileName';

    try {
      Reference ref = FirebaseStorage.instance.ref().child(destination);
      String url = await ref.putFile(photo).then((res) async {
        var url = await res.ref.getDownloadURL();
        print('URL from function: $url');
        return url;
      });
      return url;
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error Occured');
      return null;
    }
  }
}
