import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'app_components.dart';

class AppFirebase {
  static Future<void> trySignUpWithEmailAndPassword({
    required BuildContext context,
    required String emailAddress,
    required String password,
  }) async {
    if (emailAddress != "" &&
        password != "" &&
        RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(emailAddress)) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailAddress,
          password: password,
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          AppComponents.snackBar(
            context: context,
            message: "The password is too weak",
          );
          debugPrint('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          AppComponents.snackBar(
            context: context,
            message: "An account with this email already exists",
          );
          debugPrint('The account already exists for that email.');
        } else {
          AppComponents.snackBar(
            context: context,
            message: "Unknown error",
          );
          debugPrint("Error: ${e.code}");
        }
      }
    } else {
      if (emailAddress == "" || password == "") {
        AppComponents.snackBar(
          context: context,
          message: "Empty field(s)",
        );
        debugPrint("Error: empty field(s)");
      } else {
        AppComponents.snackBar(
          context: context,
          message: "Invalid email",
        );
        debugPrint("Error: Invalid email");
      }
    }
  }

  static Future<void> trySignInWithEmailAndPassword({
    required BuildContext context,
    required String emailAddress,
    required String password,
  }) async {
    if (emailAddress != "" &&
        password != "" &&
        RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(emailAddress)) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailAddress,
          password: password,
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          AppComponents.snackBar(
            context: context,
            message: "Invalid email or password",
          );
          debugPrint("No user found for that email.");
        } else if (e.code == 'wrong-password') {
          AppComponents.snackBar(
            context: context,
            message: "Invalid email or password",
          );
          debugPrint("Wrong password provided for that user.");
        } else {
          AppComponents.snackBar(
            context: context,
            message: "Unknown error",
          );
          debugPrint("Error: ${e.code}");
        }
      }
    } else {
      if (emailAddress == "" || password == "") {
        AppComponents.snackBar(
          context: context,
          message: "Empty field(s)",
        );
        debugPrint("Error: empty field(s)");
      } else {
        AppComponents.snackBar(
          context: context,
          message: "Invalid email or password",
        );
        debugPrint("Error: Invalid email");
      }
    }
  }

  static Future<bool> trySendPasswordResetEmail({
    required BuildContext context,
    required String emailAddress,
  }) async {
    try {
      await FirebaseAuth.instance.setLanguageCode("en");
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailAddress).then(
            (value) => AppComponents.snackBar(
              context: context,
              message: "The password reset link has been successfully sent to your e-mail",
            ),
          );
      return true;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          AppComponents.snackBar(
            context: context,
            message: "Invalid email",
          );
          debugPrint("No user found for that email.");
          break;
        default:
          AppComponents.snackBar(
            context: context,
            message: "Unknown error",
          );
          debugPrint("Error: ${e.code}");
      }
    } catch (e) {
      AppComponents.snackBar(
        context: context,
        message: "Unknown error",
      );
      debugPrint(e.toString());
    }
    return false;
  }

  static Future<void> trySignOut({
    required BuildContext context,
  }) async {
    try {
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      AppComponents.snackBar(
        context: context,
        message: "Unknown error",
      );
      debugPrint("Error: ${e.code}");
    } catch (e) {
      AppComponents.snackBar(
        context: context,
        message: "Unknown error",
      );
      debugPrint(e.toString());
    }
  }

  static User? getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }

  static Future<void> updateCurrentUser() async {
    await FirebaseAuth.instance.currentUser?.reload();
  }

  static Future<bool> checkEmailVerification() async {
    await updateCurrentUser();
    return getCurrentUser()!.emailVerified;
  }

  static Future<bool> trySendEmailVerification({
    required BuildContext context,
  }) async {
    try {
      await FirebaseAuth.instance.setLanguageCode("en");
      await FirebaseAuth.instance.currentUser?.sendEmailVerification().then(
        (value) {
          AppComponents.snackBar(
            context: context,
            message: "The link to confirm the e-mail has been sent successfully",
          );
        },
      );
      return true;
    } on FirebaseAuthException catch (e) {
      AppComponents.snackBar(
        context: context,
        message: "Unknown error",
      );
      debugPrint("Error: ${e.code}");
    } catch (e) {
      AppComponents.snackBar(
        context: context,
        message: "Unknown error",
      );
      debugPrint(e.toString());
    }
    return false;
  }

  static Future<bool> trySignInWithGoogle({
    required BuildContext context,
  }) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn(
        signInOption: SignInOption.standard,
        scopes: [
          "https://www.googleapis.com/auth/user.birthday.read",
          "https://www.googleapis.com/auth/userinfo.profile",
        ],
      ).signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      return true;
    } catch (e) {
      AppComponents.snackBar(
        context: context,
        message: "Unknown error",
      );
      debugPrint(e.toString());
    }
    return false;
  }

  static Future<List<Map<String, dynamic>>?> getServersList(BuildContext context) async {
    List<Map<String, dynamic>>? serversList;
    for (int tryCount = 0; tryCount < 5; tryCount++) {
      try {
        FirebaseFirestore firestore = FirebaseFirestore.instance;
        DocumentSnapshot<Map<String, dynamic>> snapshot = await (firestore.collection("firestore").doc("servers").get());
        serversList = List.from((Map.from(snapshot.data()!))["list"]);
        if (serversList.isNotEmpty && serversList != []) {
          bool flag = true;
          for (Map<String, dynamic> el in serversList) {
            if (el == {}) {
              flag = false;
              break;
            }
          }
          if (flag) {
            return serversList;
          }
        }
      } finally {}
    }
    return null;
  }

  static Future<Uint8List?> downloadFile(String url) async {
    Reference reference = FirebaseStorage.instance.refFromURL(url);
    try {
      return await reference.getData();
    } catch (e) {
      return null;
    }
  }

  static Future<List<Map<String, dynamic>>?> getServersConfigs(List<Map<String, dynamic>> servers) async {
    for (Map<String, dynamic> serverData in servers) {
      Uint8List? file;
      for (int tryCount = 0; tryCount < 5; tryCount++) {
        try {
          file = await downloadFile(serverData["configPath"]);
          if (file != null) {
            serverData.addAll(
              {
                "config": file,
              },
            );
            break;
          }
        } finally {}
      }
      if (file == null) {
        return null;
      }
    }
    return servers;
  }

  static Future<List<Map<String, dynamic>>?> getIcons(List<Map<String, dynamic>> servers) async {
    for (Map<String, dynamic> serverData in servers) {
      Uint8List? file;
      for (int tryCount = 0; tryCount < 5; tryCount++) {
        try {
          file = await downloadFile(serverData["iconPath"]);
          if (file != null) {
            serverData.addAll(
              {
                "icon": file,
              },
            );
            break;
          }
        } finally {}
      }
    }
    return servers;
  }
}
