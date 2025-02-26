import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app_colors.dart';

class AppComponents {
  static void snackBar({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(milliseconds: 2000),
  }) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: duration,
        behavior: SnackBarBehavior.floating,
        content: Text(
          message,
        ),
      ),
    );
  }

  static Widget backButton(double width, double height, BuildContext context) {
    return Positioned(
      left: 24 / 375 * width,
      top: 52 / 812 * height,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => Navigator.of(context).pop(),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: 40 / 375 * width,
            height: 40 / 375 * width,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Theme.of(context).brightness == Brightness.light ? const Color(0xFF444444).withOpacity(0.05) : AppColors.darkSecondaryColor,
                width: 1.0,
              ),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 1),
                  blurRadius: 3.4,
                  color: const Color(0xFF051920).withOpacity(0.15),
                ),
              ],
            ),
            padding: EdgeInsets.all(11 / 375 * width),
            child: SvgPicture.asset(
              'assets/svg/back_icon.svg',
              fit: BoxFit.fitWidth,
              color: Theme.of(context).brightness == Brightness.light ? AppColors.lightSecondaryColor : AppColors.darkSecondaryColor,
            ),
          ),
        ),
      ),
    );
  }

  static Widget menuButton(
    double width,
    double height,
    BuildContext context,
    void Function() onTap,
  ) {
    return Positioned(
      left: 24 / 375 * width,
      top: 52 / 812 * height,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: 40 / 375 * width,
            height: 40 / 375 * width,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Theme.of(context).brightness == Brightness.light ? const Color(0xFF444444).withOpacity(0.05) : AppColors.darkSecondaryColor,
                width: 1.0,
              ),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 1),
                  blurRadius: 3.4,
                  color: const Color(0xFF051920).withOpacity(0.15),
                ),
              ],
            ),
            padding: EdgeInsets.all(11 / 375 * width),
            child: SvgPicture.asset(
              'assets/svg/menu_icon.svg',
              fit: BoxFit.fitWidth,
              color: Theme.of(context).brightness == Brightness.light ? AppColors.lightSecondaryColor : AppColors.darkSecondaryColor,
            ),
          ),
        ),
      ),
    );
  }

  static Widget changeThemeButton(
    double width,
    double height,
    BuildContext context,
  ) {
    return Positioned(
      right: 24 / 375 * width,
      top: 52 / 812 * height,
      child: ValueListenableBuilder(
        valueListenable: Hive.box('settings').listenable(),
        builder: (context, settings, widget) => Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () =>
                Theme.of(context).brightness == Brightness.light ? settings.put('hiveThemeMode', 'dark') : settings.put('hiveThemeMode', 'light'),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: 40 / 375 * width,
              height: 40 / 375 * width,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Theme.of(context).brightness == Brightness.light ? const Color(0xFF444444).withOpacity(0.05) : AppColors.darkSecondaryColor,
                  width: 1.0,
                ),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 1),
                    blurRadius: 3.4,
                    color: const Color(0xFF051920).withOpacity(0.15),
                  ),
                ],
              ),
              padding: EdgeInsets.all(11 / 375 * width),
              child: SvgPicture.asset(
                Theme.of(context).brightness == Brightness.light ? 'assets/svg/moon_icon.svg' : 'assets/svg/sun_icon.svg',
                fit: BoxFit.fitWidth,
                color: Theme.of(context).brightness == Brightness.light ? AppColors.lightSecondaryColor : AppColors.darkSecondaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget loader(double width, double height) {
    return Container(
      width: width,
      height: height,
      color: Colors.black.withOpacity(0.25),
      child: const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }

  static Widget textButton({
    required BuildContext context,
    required double height,
    required String label,
    Function? onTap,
    double? fontSize,
    FontWeight? fontWeight,
  }) {
    return TextButton(
      onPressed: onTap != null ? () => onTap() : () => {},
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(
          Theme.of(context).splashColor.withOpacity(0.15),
        ),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: fontSize ?? 16 / 812 * height,
          fontWeight: fontWeight ?? FontWeight.w500,
          height: 19.36 / 16,
          color: AppColors.primaryColor,
        ),
      ),
    );
  }

  static Widget filledButton({
    required double width,
    required double height,
    required String label,
    Function? onTap,
    Color? backgroundColor,
    Color? foregroundColor,
    double? fontSize,
    FontWeight? fontWeight,
    Color? overlayColor,
    double? borderRadius,
    double? elevation,
    BoxBorder? boxBorder,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius != null ? BorderRadius.circular(borderRadius) : null,
        border: boxBorder,
      ),
      child: FilledButtonTheme(
        data: FilledButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(backgroundColor ?? AppColors.primaryColor),
            foregroundColor: MaterialStateProperty.all(
              foregroundColor ?? Colors.white,
            ),
            shape: borderRadius != null
                ? MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(borderRadius),
                    ),
                  )
                : null,
            elevation: MaterialStateProperty.all(elevation ?? 0),
            overlayColor: overlayColor != null ? MaterialStateProperty.all(overlayColor) : null,
          ),
        ),
        child: SizedBox(
          width: 335 / 375 * width,
          child: FilledButton(
            onPressed: onTap != null ? () => onTap() : () => {},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: fontSize ?? 16 / 812 * height,
                  fontWeight: fontWeight,
                  color: foregroundColor ?? Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget outlinedButton({
    required double width,
    required double height,
    required String label,
    Function? onTap,
    Color? borderColor,
    Color? foregroundColor,
    double? fontSize,
    FontWeight? fontWeight,
    Color? overlayColor,
    double? borderRadius,
  }) {
    return OutlinedButtonTheme(
      data: OutlinedButtonThemeData(
        style: ButtonStyle(
          overlayColor: overlayColor != null ? MaterialStateProperty.all(overlayColor) : null,
          side: MaterialStateProperty.all(
            BorderSide(
              width: 2.0,
              color: borderColor ?? AppColors.primaryColor,
            ),
          ),
        ),
      ),
      child: SizedBox(
        width: 335 / 375 * width,
        child: OutlinedButton(
          onPressed: onTap != null ? () => onTap() : () => {},
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              label,
              style: GoogleFonts.inter(
                fontSize: fontSize ?? 16 / 812 * height,
                fontWeight: fontWeight,
                color: foregroundColor ?? AppColors.primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
