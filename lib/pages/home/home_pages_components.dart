import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/app_colors.dart';
import '../../components/app_routes.dart';

class HomePagesComponents {
  static Widget infoWidget({
    required double width,
    required double height,
    required String download,
    required String upload,
    required BuildContext context,
  }) {
    return SizedBox(
      width: 330 / 375 * width,
      height: 34 / 812 * height,
      child: Row(
        children: [
          const Spacer(),
          SizedBox(
            width: 24 / 375 * width,
            height: 24 / 375 * width,
            child: SvgPicture.asset(
              'assets/svg/arrow_icon.svg',
              fit: BoxFit.fill,
              color: Theme.of(context).brightness == Brightness.light ? AppColors.lightSecondaryColor : AppColors.darkSecondaryColor,
            ),
          ),
          SizedBox(
            width: 12 / 375 * width,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Download',
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w300,
                  fontSize: 10 / 812 * height,
                  color: Theme.of(context).brightness == Brightness.light ? AppColors.lightSecondaryColor : AppColors.darkSecondaryColor,
                ),
              ),
              const Spacer(),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    download,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                      fontSize: 14 / 812 * height,
                      color: Theme.of(context).brightness == Brightness.light ? AppColors.lightSecondaryColor : AppColors.darkSecondaryColor,
                    ),
                  ),
                  Text(
                    'KB/s',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w300,
                      fontSize: 14 / 812 * height,
                      color: Theme.of(context).brightness == Brightness.light ? AppColors.lightSecondaryColor : AppColors.darkSecondaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          Container(
            height: double.infinity,
            width: 1.0,
            color: Theme.of(context).brightness == Brightness.light ? AppColors.lightSecondaryColor : AppColors.darkSecondaryColor,
          ),
          const Spacer(),
          SizedBox(
            width: 24 / 375 * width,
            height: 24 / 375 * width,
            child: RotatedBox(
              quarterTurns: 2,
              child: SvgPicture.asset(
                'assets/svg/arrow_icon.svg',
                fit: BoxFit.fill,
                color: Theme.of(context).brightness == Brightness.light ? AppColors.lightSecondaryColor : AppColors.darkSecondaryColor,
              ),
            ),
          ),
          SizedBox(
            width: 12 / 375 * width,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Upload',
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w300,
                  fontSize: 10 / 812 * height,
                  color: Theme.of(context).brightness == Brightness.light ? AppColors.lightSecondaryColor : AppColors.darkSecondaryColor,
                ),
              ),
              const Spacer(),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    upload,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                      fontSize: 14 / 812 * height,
                      color: Theme.of(context).brightness == Brightness.light ? AppColors.lightSecondaryColor : AppColors.darkSecondaryColor,
                    ),
                  ),
                  Text(
                    'KB/s',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w300,
                      fontSize: 14 / 812 * height,
                      color: Theme.of(context).brightness == Brightness.light ? AppColors.lightSecondaryColor : AppColors.darkSecondaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }

  static Widget serverCard({
    required double width,
    required double height,
    required BuildContext context,
    required Uint8List icon,
    required String serverName,
    required String serverIp,
    required int serverPing,
    required Function onTap,
  }) {
    return Container(
      width: 330 / 375 * width,
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light ? Theme.of(context).scaffoldBackgroundColor : Colors.transparent,
        border: Border.all(
          width: 0.85,
          color: Theme.of(context).brightness == Brightness.light ? const Color(0xFF4A4A61).withOpacity(0.05) : AppColors.darkSecondaryColor,
        ),
        borderRadius: BorderRadius.circular(18.0),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0.0, 3.4),
            blurRadius: 3.4,
            color: Theme.of(context).brightness == Brightness.light ? const Color(0xFF051920).withOpacity(0.15) : Colors.transparent,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onTap(),
          borderRadius: BorderRadius.circular(18.0),
          child: Padding(
            padding: EdgeInsets.all(20 / 375 * width),
            child: Row(
              children: [
                Container(
                  height: 36 / 375 * width,
                  width: 46 / 375 * width,
                  margin: const EdgeInsets.only(right: 10),
                  child: SvgPicture.memory(
                    icon,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        serverName,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w400,
                          fontSize: 14 / 812 * height,
                          height: 16.5 / 14,
                          color: Theme.of(context).brightness == Brightness.light ? AppColors.lightSecondaryColor : AppColors.darkSecondaryColor,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "IP: $serverIp",
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w300,
                          fontSize: 10 / 812 * height,
                          height: 12.4 / 10.2,
                          color: Theme.of(context).brightness == Brightness.light ? AppColors.lightSecondaryColor : AppColors.darkSecondaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "$serverPing ms",
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 14 / 812 * height,
                    color: Theme.of(context).brightness == Brightness.light ? AppColors.lightSecondaryColor : AppColors.darkSecondaryColor,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 22 / 375 * width,
                  ),
                  width: 22 / 375 * width,
                  height: 22 / 375 * width,
                  child: SvgPicture.asset(
                    'assets/svg/next_icon.svg',
                    fit: BoxFit.fill,
                    color: Theme.of(context).brightness == Brightness.light ? AppColors.lightSecondaryColor : AppColors.darkSecondaryColor,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget homePageDrawer({
    required double width,
    required double height,
    required GlobalKey<ScaffoldState> key,
    required BuildContext context,
  }) {
    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      width: 280 / 375 * width,
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 180 / 812 * height,
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Ocean VPN",
                          style: GoogleFonts.inter(
                            color: AppColors.primaryColor,
                            fontSize: 32 / 812 * height,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10 / 812 * height),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Account: ",
                                style: GoogleFonts.inter(
                                  color:
                                      Theme.of(context).brightness == Brightness.light ? AppColors.lightSecondaryColor : AppColors.darkSecondaryColor,
                                  fontSize: 15 / 812 * height,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                'FREE', // TODO value
                                style: GoogleFonts.inter(
                                  color: AppColors.primaryColor,
                                  fontSize: 15 / 812 * height,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 8 / 812 * height,
                    right: 24 / 375 * width,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => key.currentState!.closeDrawer(),
                        borderRadius: BorderRadius.circular(250),
                        child: Container(
                          margin: const EdgeInsets.all(8.0),
                          width: 18 / 375 * width,
                          height: 18 / 375 * width,
                          child: SvgPicture.asset(
                            'assets/svg/back_icon.svg',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        width: 240 / 375 * width,
                        height: 1,
                        color: Theme.of(context).brightness == Brightness.light ? AppColors.lightSecondaryColor : AppColors.darkSecondaryColor,
                      ),
                      drawerButton(
                        height: height,
                        width: width,
                        label: "UPGRADE TO PREMIUM",
                        premiumButton: true,
                        onTap: () => Navigator.of(context).pushNamed(AppRoutes.upgradeToPremiumHomePage),
                        key: key,
                        context: context,
                      ),
                      drawerButton(
                        height: height,
                        width: width,
                        label: "My Account",
                        onTap: () => Navigator.of(context).pushNamed(AppRoutes.accountHomePage),
                        key: key,
                        context: context,
                      ),
                      drawerButton(
                        height: height,
                        width: width,
                        label: "Share",
                        onTap: () => {}, //TODO
                        key: key,
                        context: context,
                      ),
                      drawerButton(
                        height: height,
                        width: width,
                        label: "Contact Us",
                        onTap: () => {}, //TODO
                        key: key,
                        context: context,
                      ),
                      drawerButton(
                        height: height,
                        width: width,
                        label: "Privacy Policy",
                        onTap: () => {}, //TODO
                        key: key,
                        context: context,
                      ),
                      drawerButton(
                        height: height,
                        width: width,
                        label: "Terms of Service",
                        onTap: () => {}, //TODO
                        key: key,
                        context: context,
                      ),
                      drawerButton(
                        height: height,
                        width: width,
                        label: "FAQ",
                        onTap: () => {}, //TODO
                        key: key,
                        context: context,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget drawerButton({
    required double height,
    required double width,
    required String label,
    bool premiumButton = false,
    required Function onTap,
    required GlobalKey<ScaffoldState> key,
    required BuildContext context,
  }) {
    return Padding(
      padding: EdgeInsets.only(top: 20 / 812 * height),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10.0),
        child: InkWell(
          onTap: () {
            key.currentState!.closeDrawer();
            onTap();
          },
          child: Container(
            width: 240 / 375 * width,
            height: 42 / 812 * height,
            padding: EdgeInsets.symmetric(
              vertical: 8 / 812 * height,
              horizontal: 20 / 375 * width,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.light
                  ? premiumButton
                      ? Color.lerp(
                          const Color(0xFFFFE182),
                          const Color(0xFFA48C0B),
                          0.1,
                        )
                      : Colors.white
                  : Colors.transparent,
              border: premiumButton
                  ? Border.all(
                      color: Theme.of(context).brightness == Brightness.light
                          ? const Color(0xFFA48C0B).withOpacity(0.1)
                          : Color.lerp(
                              const Color(0xFFFFE182),
                              const Color(0xFFA48C0B),
                              0.1,
                            )!,
                      width: 1.0,
                    )
                  : Theme.of(context).brightness == Brightness.light
                      ? null
                      : Border.all(
                          color: Colors.white,
                          width: 1.0,
                        ),
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: Theme.of(context).brightness == Brightness.light
                  ? [
                      BoxShadow(
                        offset: const Offset(0, 2),
                        blurRadius: 6.0,
                        color: const Color(0xFF051920).withOpacity(0.15),
                      ),
                    ]
                  : null,
            ),
            child: Row(
              children: [
                Text(
                  label,
                  style: GoogleFonts.inter(
                    color: Theme.of(context).brightness == Brightness.light ? AppColors.lightSecondaryColor : AppColors.darkSecondaryColor,
                    fontSize: 15 / 812 * height,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
