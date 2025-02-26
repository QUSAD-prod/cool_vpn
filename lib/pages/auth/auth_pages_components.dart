import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/app_colors.dart';
import '../../components/app_firebase.dart';

enum AuthPagesTextFieldType { email, password }

class AuthPagesComponents {
  static Widget bigLoginIconButton({
    required double height,
    required double width,
    required BuildContext context,
    required String iconPath,
    required String label,
    Function? onTap,
  }) {
    return SizedBox(
      width: 330 / 375 * width,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.transparent,
              border: Border.all(
                width: Theme.of(context).brightness == Brightness.light ? 0.85 : 1.5,
                color: Theme.of(context).brightness == Brightness.light ? Colors.black.withOpacity(0.05) : AppColors.darkSecondaryColor,
              ),
              borderRadius: BorderRadius.circular(18),
              boxShadow: Theme.of(context).brightness == Brightness.light
                  ? [
                      BoxShadow(
                        offset: const Offset(0, 3.4),
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 3.4,
                      ),
                    ]
                  : null,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      iconPath,
                      height: 26 / 812 * height,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Text(
                        label,
                        style: GoogleFonts.inter(
                          color: Theme.of(context).brightness == Brightness.light ? AppColors.lightSecondaryColor : AppColors.darkSecondaryColor,
                          fontSize: 16 / 812 * height,
                          height: 19.36 / 16,
                        ),
                        maxLines: 1,
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap != null ? () => onTap() : () => {},
              overlayColor: MaterialStateProperty.all(
                Theme.of(context).splashColor.withOpacity(0.15),
              ),
              borderRadius: BorderRadius.circular(18),
              child: const SizedBox(
                height: double.infinity,
                width: double.infinity,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget littleLoginIconButton({
    required double height,
    required BuildContext context,
    required String iconPath,
    Function? onTap,
  }) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.transparent,
            border: Border.all(
              width: Theme.of(context).brightness == Brightness.light ? 0.85 : 1.5,
              color: Theme.of(context).brightness == Brightness.light ? Colors.black.withOpacity(0.05) : Colors.white,
            ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: Theme.of(context).brightness == Brightness.light
                ? [
                    BoxShadow(
                      offset: const Offset(0, 3.4),
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 3.4,
                    ),
                  ]
                : null,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: SvgPicture.asset(
                iconPath,
                height: 30 / 812 * height,
              ),
            ),
          ),
        ),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap != null ? () => onTap() : () => {},
            overlayColor: MaterialStateProperty.all(
              Theme.of(context).splashColor.withOpacity(0.15),
            ),
            borderRadius: BorderRadius.circular(10),
            child: const SizedBox(
              height: double.infinity,
              width: double.infinity,
            ),
          ),
        ),
      ],
    );
  }

  static Widget orSeparator({
    required double width,
    required BuildContext context,
  }) {
    return SizedBox(
      width: 335 / 375 * width,
      child: Row(
        children: [
          Expanded(
            flex: 150,
            child: Container(
              height: 1,
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.light ? AppColors.lightSecondaryColor : AppColors.darkSecondaryColor,
              ),
            ),
          ),
          const Spacer(flex: 10),
          Expanded(
            flex: 18,
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                'Or',
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).brightness == Brightness.light ? AppColors.lightSecondaryColor : AppColors.darkSecondaryColor,
                ),
              ),
            ),
          ),
          const Spacer(flex: 10),
          Expanded(
            flex: 150,
            child: Container(
              height: 1,
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.light ? AppColors.lightSecondaryColor : AppColors.darkSecondaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget authPagesTextField({
    required BuildContext context,
    required double width,
    required double height,
    required TextEditingController controller,
    required FocusNode focusNode,
    required AuthPagesTextFieldType type,
    void Function()? onTap,
    bool obscurePassword = true,
    void Function()? changeObscurePassword,
    bool errorEnabled = false,
    bool signUp = false,
    bool enabled = true,
  }) {
    return InkWell(
      onTap: onTap,
      overlayColor: MaterialStateProperty.all(
        Colors.transparent,
      ),
      borderRadius: BorderRadius.circular(18),
      child: Container(
        width: 330 / 375 * width,
        decoration: BoxDecoration(
          color: focusNode.hasFocus
              ? Color.lerp(
                  Colors.white,
                  AppColors.primaryColor,
                  0.1,
                )
              : errorEnabled
                  ? Color.lerp(
                      Colors.white,
                      AppColors.errorColor,
                      0.1,
                    )
                  : Colors.white,
          border: Border.all(
            width: 0.85,
            color: focusNode.hasFocus
                ? AppColors.primaryColor
                : errorEnabled
                    ? AppColors.errorColor
                    : Colors.black.withOpacity(0.05),
          ),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 3.4),
              color: Colors.black.withOpacity(0.15),
              blurRadius: 3.4,
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 24 / 375 * width,
          vertical: 22 / 812 * height,
        ),
        child: Row(
          children: [
            SizedBox(
              width: 30 / 375 * width,
              height: 30 / 375 * width,
              child: SvgPicture.asset(
                type == AuthPagesTextFieldType.email ? 'assets/svg/mail_icon.svg' : 'assets/svg/lock_icon.svg',
                fit: BoxFit.fill,
                colorFilter: ColorFilter.mode(
                  focusNode.hasFocus
                      ? AppColors.primaryColor
                      : errorEnabled
                          ? AppColors.errorColor
                          : AppColors.lightSecondaryColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 10 / 375 * width,
                ),
                child: TextFormField(
                  controller: controller,
                  focusNode: focusNode,
                  onTap: onTap,
                  decoration: InputDecoration.collapsed(
                    hintText: type == AuthPagesTextFieldType.email ? 'Email address' : 'Password',
                    hintStyle: GoogleFonts.montserrat(
                      color: AppColors.lightSecondaryColor,
                      fontSize: 14 / 812 * height,
                      height: 17.07 / 14,
                    ),
                  ),
                  style: GoogleFonts.montserrat(
                    color: focusNode.hasFocus
                        ? AppColors.primaryColor
                        : errorEnabled
                            ? AppColors.errorColor
                            : AppColors.lightSecondaryColor,
                    fontSize: 16 / 812 * height,
                    height: 17.07 / 14,
                  ),
                  cursorColor: AppColors.lightSecondaryColor,
                  maxLines: 1,
                  keyboardType: type == AuthPagesTextFieldType.email ? TextInputType.emailAddress : TextInputType.visiblePassword,
                  textInputAction: type == AuthPagesTextFieldType.email ? TextInputAction.next : TextInputAction.done,
                  onFieldSubmitted: (value) => FocusScope.of(context).nextFocus(),
                  onEditingComplete: () => TextInput.finishAutofillContext(),
                  obscureText: type == AuthPagesTextFieldType.email ? false : obscurePassword,
                  autofillHints: type == AuthPagesTextFieldType.email
                      ? signUp
                          ? [
                              AutofillHints.email,
                            ]
                          : [
                              AutofillHints.email,
                            ]
                      : signUp
                          ? [
                              AutofillHints.newPassword,
                            ]
                          : [
                              AutofillHints.password,
                            ],
                  enabled: enabled,
                ),
              ),
            ),
            type == AuthPagesTextFieldType.password && controller.text.isNotEmpty
                ? Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: changeObscurePassword ?? () => {},
                      borderRadius: BorderRadius.circular(100.0),
                      child: Container(
                        width: 16 / 375 * width,
                        height: 16 / 375 * width,
                        margin: const EdgeInsets.all(8),
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Icon(
                            obscurePassword ? Icons.visibility : Icons.visibility_off,
                            opticalSize: 16 / 375 * width,
                            color: errorEnabled
                                ? AppColors.errorColor
                                : Theme.of(context).brightness == Brightness.light
                                    ? AppColors.lightSecondaryColor
                                    : AppColors.darkSecondaryColor,
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  static Widget smallAuthMethods(double width, double height, BuildContext context) {
    return Expanded(
      flex: 64,
      child: SizedBox(
        width: 310 / 375 * width,
        child: Row(
          children: [
            // Expanded(
            //   flex: 60,
            //   child: AuthPagesComponents.littleLoginIconButton(
            //     height: height,
            //     context: context,
            //     iconPath: 'assets/svg/facebook_logo.svg',
            //     onTap: () => {}, //TODO tapAction
            //   ),
            // ),
            // const Spacer(flex: 20),
            Expanded(
              flex: 120,
              child: AuthPagesComponents.littleLoginIconButton(
                height: height,
                context: context,
                iconPath: 'assets/svg/google_logo.svg',
                onTap: () async => await AppFirebase.trySignInWithGoogle(context: context),
              ),
            ),
            const Spacer(flex: 20),
            Expanded(
              flex: 120,
              child: AuthPagesComponents.littleLoginIconButton(
                height: height,
                context: context,
                iconPath: Theme.of(context).brightness == Brightness.light ? 'assets/svg/apple_logo.svg' : 'assets/svg/apple_logo_dark.svg',
                onTap: () => {}, //TODO tapAction
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget bigAuthMethods(double width, double height, BuildContext context) {
    return Expanded(
      flex: 170, //! change to 245 for facebook
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          // Expanded(
          //   flex: 75,
          //   child: AuthPagesComponents.bigLoginIconButton(
          //     height: height,
          //     width: width,
          //     context: context,
          //     iconPath: 'assets/svg/facebook_logo.svg',
          //     label: "Continue with Facebook",
          //     onTap: () => {}, //TODO tapAction
          //   ),
          // ),
          // const Spacer(flex: 20),
          Expanded(
            flex: 75,
            child: AuthPagesComponents.bigLoginIconButton(
              height: height,
              width: width,
              context: context,
              iconPath: 'assets/svg/google_logo.svg',
              label: "Continue with Google",
              onTap: () async => await AppFirebase.trySignInWithGoogle(context: context),
            ),
          ),
          const Spacer(flex: 20),
          Expanded(
            flex: 75,
            child: AuthPagesComponents.bigLoginIconButton(
              height: height,
              width: width,
              context: context,
              iconPath: Theme.of(context).brightness == Brightness.light ? 'assets/svg/apple_logo.svg' : 'assets/svg/apple_logo_dark.svg',
              label: "Continue with Apple",
              onTap: () => {}, //TODO tapAction
            ),
          ),
        ],
      ),
    );
  }
}
