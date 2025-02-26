import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../components/app_colors.dart';
import '../../components/app_components.dart';

class UpgradeToPremiumHomePage extends StatefulWidget {
  const UpgradeToPremiumHomePage({super.key});

  @override
  State<UpgradeToPremiumHomePage> createState() => _UpgradeToPremiumHomePageState();
}

class _UpgradeToPremiumHomePageState extends State<UpgradeToPremiumHomePage> {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Stack(
            children: [
              Center(
                child: Column(
                  children: [
                    const Spacer(flex: 100),
                    SizedBox(
                      width: 140 / 820 * 100.h,
                      height: 140 / 820 * 100.h,
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: SvgPicture.asset(
                          "assets/svg/premium_upgrade_logo.svg",
                        ),
                      ),
                    ),
                    const Spacer(flex: 20),
                    SizedBox(
                      width: 175 / 375 * 100.w,
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
                      width: 300 / 375 * 100.w,
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          "Upgrade to Premium Now",
                          style: GoogleFonts.inter(
                            color: Theme.of(context).brightness == Brightness.light ? AppColors.lightSecondaryColor : AppColors.darkSecondaryColor,
                            fontWeight: FontWeight.w700,
                            height: 29.05 / 24,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(flex: 30),
                    item(
                      "assets/svg/no_ads_logo.svg",
                      "No Ads",
                      "Enjoy surfing without annoying ads",
                    ),
                    const Spacer(flex: 20),
                    item(
                      "assets/svg/fast_logo.svg",
                      "Fast",
                      "---text---",
                    ),
                    const Spacer(flex: 20),
                    item(
                      "assets/svg/all_servers_logo.svg",
                      "All servers",
                      "---text---",
                    ),
                    const Spacer(flex: 110),
                    Expanded(
                      flex: 50,
                      child: AppComponents.filledButton(
                        width: 100.w,
                        height: 100.h,
                        label: "UPGRADE TO PREMIUM",
                        fontWeight: FontWeight.w500,
                        foregroundColor:
                            Theme.of(context).brightness == Brightness.light ? AppColors.lightSecondaryColor : AppColors.darkSecondaryColor,
                        backgroundColor: Theme.of(context).brightness == Brightness.light
                            ? Color.lerp(
                                const Color(0xFFFFE182),
                                const Color(0xFFA48C0B),
                                0.1,
                              )
                            : Colors.transparent,
                        boxBorder: Theme.of(context).brightness == Brightness.light
                            ? null
                            : Border.all(
                                width: 1,
                                color: Color.lerp(
                                  const Color(0xFFFFE182),
                                  const Color(0xFFA48C0B),
                                  0.1,
                                )!,
                              ),
                        borderRadius: 10.0,
                        elevation: Theme.of(context).brightness == Brightness.light ? 3 : 0,
                        onTap: () => {}, //TODO add action
                      ),
                    ),
                    const Spacer(flex: 40),
                  ],
                ),
              ),
              AppComponents.backButton(100.w, 100.h, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget item(
    String iconPath,
    String primaryText,
    String secondaryText,
  ) {
    return Container(
      height: 64 / 812 * 100.h,
      width: 100.w,
      padding: EdgeInsets.symmetric(
        vertical: 8 / 812 * 100.h,
        horizontal: 23 / 375 * 100.w,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            iconPath,
            height: 48 / 812 * 100.h,
            width: 48 / 812 * 100.h,
            fit: BoxFit.fill,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 16 / 375 * 100.w,
              top: 2 / 812 * 100.h,
              bottom: 2 / 812 * 100.h,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  primaryText,
                  style: GoogleFonts.inter(
                    color: Theme.of(context).brightness == Brightness.light ? AppColors.lightSecondaryColor : AppColors.darkSecondaryColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 16 / 812 * 100.h,
                  ),
                ),
                const Spacer(),
                Text(
                  secondaryText,
                  style: GoogleFonts.inter(
                    color:
                        Theme.of(context).brightness == Brightness.light ? const Color(0xFF49717D) : AppColors.darkSecondaryColor.withOpacity(0.75),
                    fontWeight: FontWeight.w300,
                    fontSize: 14 / 812 * 100.h,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
