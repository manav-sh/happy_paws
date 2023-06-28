import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';

class FirestoreImage {
  static Future<String?> uploadFile(File? photo) async {
    print('here');
    if (photo == null) return null;
    final fileName = basename(photo.path);
    final destination = 'files/$fileName';

    try {
      print('inside try');
      Reference ref = FirebaseStorage.instance.ref().child(destination);
      String url = await ref.putFile(photo).then((res) async {
        var url = await res.ref.getDownloadURL();
        // ignore: avoid_print
        print('URL from function: $url');
        return url;
      });
      print('here');
      return url;
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error Occured');
      return Future.error(Exception('Image upload error'));
    }
  }
}
