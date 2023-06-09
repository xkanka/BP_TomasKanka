import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileController {
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  ImagePicker _imagePicker = ImagePicker();
  DateTime birthDate = DateTime(1990);

  EditProfileController(String? displayName, DateTime birthDate) {
    textController = TextEditingController(text: displayName ?? 'Not set');

    birthDate = birthDate;
  }

  void dispose() {
    textController?.dispose();
  }

  Future<void> uploadProfilePicture(String uid) async {
    final pickedFile = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 800,
      maxHeight: 800,
    );

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);

      try {
        final ref = FirebaseStorage.instance.ref().child('profile_pictures').child('$uid.jpg');
        await ref.putFile(imageFile);

        final imageUrl = await ref.getDownloadURL();
        final userDoc = await FirebaseFirestore.instance.collection('comments').where('uid', isEqualTo: uid).limit(1).get();
        userDoc.docs.first.reference.update({'photo_url': imageUrl});
      } catch (e) {
        print('Upload failed for user $uid: $e');
      }
    }
  }

  Future<void> updateUserData(DocumentReference userRef) async {
    final commentsUpdateData = {
      "display_name": textController?.text,
      "birth_date": birthDate,
    };
    await userRef.update(commentsUpdateData);
  }

  Future<void> saveChanges(BuildContext context, DocumentReference? userRef) async {
    if (userRef == null) {
      throw Exception('User is not logged in');
    }
    await updateUserData(userRef);
    Navigator.pop(context);
  }
}
