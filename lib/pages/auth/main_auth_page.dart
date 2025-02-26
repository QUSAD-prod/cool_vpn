import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/app_colors.dart';
import '../../components/app_components.dart';
import '../../components/app_routes.dart';
import 'auth_pages_components.dart';

class MainAuthPage extends StatefulWidget {
  const MainAuthPage({super.key});

  @override
  State<MainAuthPage> createState() => _MainAuthPageState();
}

class _MainAuthPageState extends State<MainAuthPage> {
  late StreamSubscription<User?> authListenner;

  @override
  void initState() {
    super.initState();
    authListenner = FirebaseAuth.instance.authStateChanges().listen(
      (User? user) {
        if (user == null) {
          debugPrint('User is currently signed out!');
        } else {
          debugPrint('User is signed in!');
          debugPrint(user.toString());
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRoutes.mainHomePage,
            (route) => false,
          );
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    authListenner.cancel();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const Spacer(flex: 160),
              SizedBox(
                width: 175 / 375 * width,
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    "Ocean VPN",
                    style: GoogleFonts.inter(
                      color: AppColors.primaryColor,
                      height: 38.73 / 32,
                    ),
                  ),
                ),
              ),
              const Spacer(flex: 100),
              AuthPagesComponents.bigAuthMethods(width, height, context),
              const Spacer(flex: 20),
              AuthPagesComponents.orSeparator(width: width, context: context),
              const Spacer(flex: 30),
              signInWithPasswordBt(width, height, context),
              const Spacer(flex: 8),
              signUpBt(width, height, context),
              const Spacer(flex: 90),
            ],
          ),
        ),
      ),
    );
  }

  Widget signUpBt(double width, double height, BuildContext context) {
    return Expanded(
      flex: 50,
      child: AppComponents.filledButton(
        width: width,
        height: height,
        label: "Sign up",
        onTap: () => Navigator.of(context).pushNamedAndRemoveUntil(
          AppRoutes.passwordSignUpAuthPage,
          (route) => false,
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.primaryColor,
        fontWeight: FontWeight.w500,
        overlayColor: Theme.of(context).splashColor.withOpacity(0.15),
      ),
    );
  }

  Widget signInWithPasswordBt(double width, double height, BuildContext context) {
    return Expanded(
      flex: 50,
      child: AppComponents.filledButton(
        width: width,
        height: height,
        label: "Sign in with password",
        onTap: () => Navigator.of(context).pushNamedAndRemoveUntil(
          AppRoutes.passwordSignInAuthPage,
          (route) => false,
        ),
      ),
    );
  }
}
