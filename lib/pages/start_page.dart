import 'dart:async';

import 'package:cool_vpn/components/app_components.dart';
import 'package:cool_vpn/components/app_firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../components/app_colors.dart';
import '../components/app_routes.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> with SingleTickerProviderStateMixin {
  double progressIndicatorValue = 0;
  late Timer animationTimer;
  late List<Map<String, dynamic>>? serversList;

  @override
  void initState() {
    super.initState();
    AppFirebase.getServersList(context).then(
      (value) {
        if (value != null) {
          serversList = value;
          animationTimer = Timer.periodic(
            const Duration(milliseconds: 15),
            (timer) async {
              if (progressIndicatorValue < 0.4) {
                setState(() => progressIndicatorValue += 0.005);
              } else {
                timer.cancel();
                AppFirebase.getServersConfigs(serversList!).then(
                  (value) {
                    if (value != null) {
                      serversList = value;
                      animationTimer = Timer.periodic(
                        const Duration(milliseconds: 15),
                        (timer) async {
                          if (progressIndicatorValue < 0.6) {
                            setState(() => progressIndicatorValue += 0.005);
                          } else {
                            timer.cancel();
                            AppFirebase.getIcons(serversList!).then(
                              (value) {
                                serversList = value;
                                animationTimer = Timer.periodic(
                                  const Duration(milliseconds: 15),
                                  (timer) async {
                                    if (progressIndicatorValue < 0.9) {
                                      setState(() => progressIndicatorValue += 0.005);
                                    } else {
                                      timer.cancel();
                                      Box box = Hive.box('servers');
                                      box.get('selected_server') == null ? box.put('selected_server', 0) : null;
                                      box.put('servers_list', serversList!).then(
                                        (value) {
                                          animationTimer = Timer.periodic(
                                            const Duration(milliseconds: 15),
                                            (timer) async {
                                              if (progressIndicatorValue < 1.0) {
                                                setState(() => progressIndicatorValue += 0.005);
                                              } else {
                                                timer.cancel();
                                                Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.checkAuthPage, (route) => false);
                                              }
                                            },
                                          );
                                        },
                                      );
                                    }
                                  },
                                );
                              },
                            );
                          }
                        },
                      );
                    } else {
                      AppComponents.snackBar(
                        context: context,
                        message: "Unknown Error",
                        duration: const Duration(seconds: 5),
                      );
                    }
                  },
                );
              }
            },
          );
        } else {
          AppComponents.snackBar(
            context: context,
            message: "Unknown Error",
            duration: const Duration(seconds: 5),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    animationTimer.cancel();
    serversList = null;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Opacity(
            opacity: Theme.of(context).brightness == Brightness.light ? 1 : 0.8,
            child: SvgPicture.asset(
              'assets/svg/background_small.svg',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
          SafeArea(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 260 / 375 * width,
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        "Ocean VPN",
                        style: GoogleFonts.inter(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 215 / 375 * width,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: LinearProgressIndicator(
                        minHeight: (216 / 375 * width) * (15 / 216),
                        value: progressIndicatorValue,
                        color: AppColors.primaryColor,
                        backgroundColor: AppColors.primaryColor.withOpacity(0.25),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
