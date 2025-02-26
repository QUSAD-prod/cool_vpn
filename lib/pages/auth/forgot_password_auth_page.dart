import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/app_colors.dart';
import '../../components/app_components.dart';
import '../../components/app_firebase.dart';
import 'auth_pages_components.dart';

class ForgotPasswordAuthPage extends StatefulWidget {
  const ForgotPasswordAuthPage({super.key});

  @override
  State<ForgotPasswordAuthPage> createState() => _ForgotPasswordAuthPageState();
}

class _ForgotPasswordAuthPageState extends State<ForgotPasswordAuthPage> {
  late TextEditingController emailController;
  late FocusNode emailFocusNode;
  late bool emailError;
  late bool loading;

  @override
  void initState() {
    super.initState();

    emailController = TextEditingController();
    emailFocusNode = FocusNode();
    emailError = false;
    loading = false;
  }

  @override
  void dispose() {
    super.dispose();

    emailController.dispose();
    emailFocusNode.dispose();
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
            child: SizedBox(
              width: width,
              height: height,
              child: SafeArea(
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
                      const Spacer(flex: 20),
                      SizedBox(
                        width: 245 / 375 * width,
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            "Forgot Password",
                            style: GoogleFonts.inter(
                              color: Theme.of(context).brightness == Brightness.light ? AppColors.lightSecondaryColor : AppColors.darkSecondaryColor,
                              fontWeight: FontWeight.w700,
                              height: 29.05 / 24,
                            ),
                          ),
                        ),
                      ),
                      const Spacer(flex: 60),
                      field(context, width, height),
                      const Spacer(flex: 340),
                      sendBt(width, height, context),
                      const Spacer(flex: 40),
                    ],
                  ),
                ),
              ),
            ),
          ),
          AppComponents.backButton(width, height, context),
          loading ? AppComponents.loader(width, height) : Container(),
        ],
      ),
    );
  }

  Widget field(BuildContext context, double width, double height) {
    return AutofillGroup(
      child: AuthPagesComponents.authPagesTextField(
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
    );
  }

  Widget sendBt(double width, double height, BuildContext context) {
    return Expanded(
      flex: 50,
      child: AppComponents.filledButton(
        width: width,
        height: height,
        label: "Send",
        onTap: () {
          FocusScope.of(context).unfocus();
          setState(
            () => loading = true,
          );
          Timer(
            const Duration(milliseconds: 300),
            () => AppFirebase.trySendPasswordResetEmail(
              context: context,
              emailAddress: emailController.text,
            ).then(
              (value) => setState(
                () {
                  loading = false;
                  Navigator.of(context).pop();
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
