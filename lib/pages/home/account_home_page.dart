import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../components/app_colors.dart';
import '../../components/app_components.dart';
import '../../components/app_firebase.dart';
import '../../components/app_routes.dart';
import '../auth/auth_pages_components.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  late TextEditingController emailController;
  late FocusNode emailFocus;
  String? photoUrl;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    emailFocus = FocusNode(debugLabel: 'emailController');
    AppFirebase.updateCurrentUser().then(
      (value) => setState(
        () {
          emailController.text = AppFirebase.getCurrentUser()!.email!;
          photoUrl = AppFirebase.getCurrentUser()!.photoURL;
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    emailFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => Scaffold(
        body: Stack(
          children: [
            InkWell(
              overlayColor: MaterialStateProperty.all(
                Colors.transparent,
              ),
              onTap: () => FocusScope.of(context).unfocus(),
              enableFeedback: false,
              child: SizedBox(
                width: 100.w,
                height: 100.h,
                child: SafeArea(
                  child: Center(
                    child: Column(
                      children: [
                        const Spacer(flex: 100),
                        Container(
                          height: 140 / 812 * 100.h,
                          width: 140 / 812 * 100.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: photoUrl != null
                                  ? Image.network(
                                      photoUrl!,
                                      filterQuality: FilterQuality.high,
                                    ).image
                                  : Image.asset("assets/png/avatar.png").image,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        const Spacer(flex: 20),
                        Text(
                          AppFirebase.getCurrentUser()!.displayName ?? AppFirebase.getCurrentUser()!.email!,
                          style: GoogleFonts.montserrat(
                            fontSize: 20 / 812 * 100.h,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).brightness == Brightness.light ? AppColors.lightSecondaryColor : AppColors.darkSecondaryColor,
                          ),
                        ),
                        const Spacer(flex: 10),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Account: ",
                              style: GoogleFonts.inter(
                                fontSize: 15 / 812 * 100.h,
                                fontWeight: FontWeight.w400,
                                color:
                                    Theme.of(context).brightness == Brightness.light ? AppColors.lightSecondaryColor : AppColors.darkSecondaryColor,
                              ),
                            ),
                            Text(
                              "FREE", //TODO add value
                              style: GoogleFonts.inter(
                                fontSize: 15 / 812 * 100.h,
                                fontWeight: FontWeight.w400,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(flex: 20),
                        AuthPagesComponents.authPagesTextField(
                          context: context,
                          width: 100.w,
                          height: 100.h,
                          controller: emailController,
                          focusNode: emailFocus,
                          type: AuthPagesTextFieldType.email,
                          enabled: false,
                        ),
                        const Spacer(flex: 235),
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
                            onTap: () => Navigator.of(context).pushNamed(AppRoutes.upgradeToPremiumHomePage),
                          ),
                        ),
                        const Spacer(flex: 30),
                        Expanded(
                          flex: 50,
                          child: AppComponents.outlinedButton(
                            width: 100.w,
                            height: 100.h,
                            label: 'Logout',
                            onTap: () async => await AppFirebase.trySignOut(context: context).then(
                              (value) => Navigator.of(context).pushNamedAndRemoveUntil(
                                AppRoutes.checkAuthPage,
                                (route) => false,
                              ),
                            ),
                          ),
                        ),
                        const Spacer(flex: 40),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            AppComponents.backButton(100.w, 100.h, context),
          ],
        ),
      ),
    );
  }
}
