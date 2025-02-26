import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/app_firebase.dart';
import '../components/app_routes.dart';

class CheckAuthPage extends StatefulWidget {
  const CheckAuthPage({super.key});

  @override
  State<CheckAuthPage> createState() => _CheckAuthPageState();
}

class _CheckAuthPageState extends State<CheckAuthPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then(
      (value) async {
        if (AppFirebase.getCurrentUser() != null) {
          debugPrint(
            "Current User UID: ${FirebaseAuth.instance.currentUser?.uid}",
          );

          if (mounted) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoutes.mainHomePage,
              (route) => false,
            );
          }
        } else {
          debugPrint(
            "Current User: Null",
          );
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRoutes.mainAuthPage,
            (route) => false,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
