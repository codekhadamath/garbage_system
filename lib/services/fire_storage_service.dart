import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FireStorageService {
  static Reference get resumePdfRef => FirebaseStorage.instance.ref('bin_images');
  static Future<String> uploadImage(
      XFile image, Function(double) bytecodeTransferred) async {
    File file = File(image.path);

    UploadTask task = FirebaseStorage.instance
        .ref('bin_images/${image.name}_${DateTime.now()}.jpg')
        .putFile(file);

    return await _uploadToFireStorage(task, bytecodeTransferred);
  }

  static Future<String> _uploadToFireStorage(
      UploadTask task, Function(double) bytecodeTransferred) async {
    task.snapshotEvents.listen((TaskSnapshot snapshot) {
      bytecodeTransferred(
          (snapshot.bytesTransferred / snapshot.totalBytes) * 100);
    }, onError: (e) {
      // The final snapshot is also available on the task via `.snapshot`,
      // this can include 2 additional states, `TaskState.error` & `TaskState.canceled`
      debugPrint(task.snapshot.toString());

      if (e.code == 'permission-denied') {
        debugPrint(
            'User does not have permission to upload to this reference.');
      }
    });

    // We can still optionally use the Future alongside the stream.
    try {
      // upload completed
      final taskResult = await task;
      return taskResult.ref.getDownloadURL();
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        debugPrint(
            'User does not have permission to upload to this reference.');
      }
      return e.toString();
      // ...
    }
  }
}