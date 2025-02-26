import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/app_colors.dart';
import '../../components/app_components.dart';
import '../../components/app_firebase.dart';
import '../../components/app_routes.dart';
import 'auth_pages_components.dart';

class PasswordSignInAuthPage extends StatefulWidget {
  const PasswordSignInAuthPage({super.key});

  @override
  State<PasswordSignInAuthPage> createState() => _PasswordSignInAuthPageState();
}

class _PasswordSignInAuthPageState extends State<PasswordSignInAuthPage> {
  late final StreamSubscription<User?> _authStateChangesListenner;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late FocusNode emailFocusNode;
  late FocusNode passwordFocusNode;
  late bool obscurePassword;
  late bool emailError;
  late bool passwordError;
  late String errorMessage;
  late bool loading;

  @override
  void initState() {
    super.initState();

    _authStateChangesListenner = FirebaseAuth.instance.authStateChanges().listen(
      (User? user) {
        if (user != null) {
          debugPrint('User is signed in!');
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRoutes.checkAuthPage,
            (route) => false,
          );
        }
      },
    );

    emailController = TextEditingController();
    passwordController = TextEditingController();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    obscurePassword = true;
    emailError = false;
    passwordError = false;
    errorMessage = "";
    loading = false;

    emailController.addListener(() => setState(() {}));
    passwordController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();

    _authStateChangesListenner.cancel();

    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          InkWell(
            overlayColor: MaterialStateProperty.all(
              Colors.transparent,
            ),
            onTap: () => FocusScope.of(context).unfocus(),
            enableFeedback: false,
            child: SafeArea(
              child: Center(
                child: Column(
                  children: [
                    const Spacer(flex: 140),
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
                    const Spacer(flex: 20),
                    SizedBox(
                      width: 245 / 375 * width,
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          "Login to Your Account",
                          style: GoogleFonts.inter(
                            color: Theme.of(context).brightness == Brightness.light ? AppColors.lightSecondaryColor : AppColors.darkSecondaryColor,
                            fontWeight: FontWeight.w700,
                            height: 29.05 / 24,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(flex: 40),
                    fields(width, height, context),
                    const Spacer(flex: 24),
                    signInBt(width, height),
                    const Spacer(flex: 8),
                    forgotPasswordBt(width, height, context),
                    const Spacer(flex: 8),
                    AuthPagesComponents.orSeparator(width: width, context: context),
                    const Spacer(flex: 20),
                    AuthPagesComponents.smallAuthMethods(width, height, context),
                    const Spacer(flex: 20),
                    signUpBt(height, context),
                    const Spacer(flex: 30),
                  ],
                ),
              ),
            ),
          ),
          loading ? AppComponents.loader(width, height) : Container(),
        ],
      ),
    );
  }

  Widget fields(double width, double height, BuildContext context) {
    return AutofillGroup(
      child: Column(
        children: [
          AuthPagesComponents.authPagesTextField(
            context: context,
            width: width,
            height: height,
            controller: emailController,
            focusNode: emailFocusNode,
            type: AuthPagesTextFieldType.email,
            onTap: () => setState(
              () {
                emailError = false;
                FocusScope.of(context).requestFocus(emailFocusNode);
              },
            ),
            errorEnabled: emailError,
          ),
          Padding(
            padding: EdgeInsets.only(top: 20 / 812 * height),
            child: AuthPagesComponents.authPagesTextField(
              context: context,
              width: width,
              height: height,
              controller: passwordController,
              focusNode: passwordFocusNode,
              type: AuthPagesTextFieldType.password,
              onTap: () => setState(
                () {
                  passwordError = false;
                  FocusScope.of(context).requestFocus(passwordFocusNode);
                },
              ),
              obscurePassword: obscurePassword,
              changeObscurePassword: () => setState(() => obscurePassword = !obscurePassword),
              errorEnabled: passwordError,
            ),
          ),
        ],
      ),
    );
  }

  Widget signInBt(double width, double height) {
    return Expanded(
      flex: 50,
      child: AppComponents.filledButton(
        width: width,
        height: height,
        label: "Sign in",
        onTap: () {
          FocusScope.of(context).unfocus();
          setState(
            () => loading = true,
          );
          Timer(
            const Duration(milliseconds: 300),
            () => AppFirebase.trySignInWithEmailAndPassword(
              context: context,
              emailAddress: emailController.text,
              password: passwordController.text,
            ).then(
              (value) => setState(
                () => loading = false,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget forgotPasswordBt(double width, double height, BuildContext context) {
    return Expanded(
      flex: 50,
      child: AppComponents.filledButton(
        width: width,
        height: height,
        label: "Forgot the password?",
        onTap: () => Navigator.of(context).pushNamed(AppRoutes.forgotPasswordAuthPage),
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.primaryColor,
        fontWeight: FontWeight.w500,
        overlayColor: Theme.of(context).splashColor.withOpacity(0.15),
      ),
    );
  }

  Widget signUpBt(double height, BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Don’t have an account? ",
          style: GoogleFonts.montserrat(
            fontSize: 14 / 812 * height,
            fontWeight: FontWeight.w300,
            height: 17.07 / 14,
            color: Theme.of(context).brightness == Brightness.light ? Colors.black.withOpacity(0.5) : Colors.white.withOpacity(0.6),
          ),
        ),
        AppComponents.textButton(
          context: context,
          height: height,
          label: "Sign up",
          onTap: () => Navigator.of(context).pushNamedAndRemoveUntil(
            AppRoutes.passwordSignUpAuthPage,
            (route) => false,
          ),
        ),
      ],
    );
  }
}
