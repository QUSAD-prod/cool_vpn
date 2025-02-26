import 'package:cool_vpn/components/app_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:openvpn_flutter/openvpn_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../components/app_colors.dart';
import '../../components/app_routes.dart';
import 'home_pages_components.dart';

final GlobalKey<ScaffoldState> _key = GlobalKey();

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  late bool isActive;
  late OpenVPN openvpn;
  VPNStage? vpnStage;
  VpnStatus? vpnStatus;

  @override
  void initState() {
    super.initState();
    openvpn = OpenVPN(onVpnStatusChanged: onVpnStatusChanged, onVpnStageChanged: onVpnStageChanged);
    openvpn.initialize(
      groupIdentifier: "GROUP_IDENTIFIER",

      ///Example 'group.com.laskarmedia.vpn'
      providerBundleIdentifier: "NETWORK_EXTENSION_IDENTIFIER",

      ///Example 'id.laskarmedia.openvpnFlutterExample.VPNExtension'
      localizedDescription: "LOCALIZED_DESCRIPTION",

      ///Example 'Laskarmedia VPN'
    );
    isActive = false;
  }

  void onVpnStatusChanged(VpnStatus? vpnStatus) {
    setState(
      () {
        this.vpnStatus = vpnStatus;
      },
    );
  }

  void onVpnStageChanged(VPNStage? vpnStage, String message) {
    setState(
      () {
        this.vpnStage = vpnStage;
      },
    );
  }

  void connect(String config, String name, String username, String password) {
    openvpn.connect(
      config,
      name,
      username: username,
      password: password,
      bypassPackages: [],
      // In iOS connection can stuck in "connecting" if this flag is "false".
      // Solution is to switch it to "true".
      certIsRequired: false,
    );
  }

  void disconnect() {
    openvpn.disconnect();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box('servers').listenable(),
        builder: (context, box, widget) => Sizer(
              builder: (context, orientation, deviceType) => Scaffold(
                key: _key,
                resizeToAvoidBottomInset: false,
                drawerEnableOpenDragGesture: false,
                drawer: HomePagesComponents.homePageDrawer(width: 100.w, height: 100.h, key: _key, context: context),
                body: Stack(
                  children: [
                    Opacity(
                      opacity: Theme.of(context).brightness == Brightness.light ? 1 : 0.8,
                      child: SvgPicture.asset(
                        'assets/svg/background_big.svg',
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SafeArea(
                      child: Stack(
                        children: [
                          Center(
                            child: Column(
                              children: [
                                const Spacer(flex: 140),
                                Container(
                                  height: 130 / 375 * 100.w / 2 * 1.45 * 1.35 * 1.2,
                                  width: 130 / 375 * 100.w * 1.45 * 1.35 * 1.2,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(288),
                                    border: isActive
                                        ? Border.all(
                                            width: 2,
                                            color: AppColors.primaryColor.withOpacity(0.05),
                                          )
                                        : null,
                                  ),
                                  child: Center(
                                    child: Container(
                                      height: 130 / 375 * 100.w / 2 * 1.45 * 1.35,
                                      width: 130 / 375 * 100.w * 1.45 * 1.35,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(288),
                                        border: isActive
                                            ? Border.all(
                                                width: 2,
                                                color: AppColors.primaryColor.withOpacity(0.1),
                                              )
                                            : null,
                                      ),
                                      child: Center(
                                        child: Container(
                                          height: 130 / 375 * 100.w / 2 * 1.45,
                                          width: 130 / 375 * 100.w * 1.45,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(288),
                                            border: isActive
                                                ? Border.all(
                                                    width: 2,
                                                    color: AppColors.primaryColor.withOpacity(0.2),
                                                  )
                                                : null,
                                          ),
                                          child: Center(
                                            child: Container(
                                              height: 130 / 375 * 100.w / 2,
                                              width: 130 / 375 * 100.w,
                                              decoration: BoxDecoration(
                                                boxShadow: isActive
                                                    ? [
                                                        BoxShadow(
                                                          color: AppColors.primaryColor.withOpacity(0.38),
                                                          offset: const Offset(0, 10),
                                                          blurRadius: 25,
                                                        ),
                                                      ]
                                                    : null,
                                              ),
                                              child: FlutterSwitch(
                                                height: 130 / 375 * 100.w / 2,
                                                width: 130 / 375 * 100.w,
                                                toggleSize: 55 / 812 * 100.h,
                                                toggleColor: Colors.white,
                                                inactiveToggleColor:
                                                    Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.white.withOpacity(0.94),
                                                toggleBorder: Border.all(
                                                  color: Colors.black.withOpacity(0.04),
                                                  width: 1,
                                                ),
                                                value: isActive,
                                                onToggle: (value) => setState(
                                                  () => isActive = !isActive,
                                                ),
                                                activeColor: AppColors.primaryColor,
                                                inactiveColor: const Color(0xFF787880)
                                                    .withOpacity(Theme.of(context).brightness == Brightness.light ? 0.15 : 0.4),
                                                borderRadius: 200.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const Spacer(flex: 100),
                                SizedBox(
                                  width: 110 / 375 * 100.w,
                                  child: FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Text(
                                      "Connecting Time",
                                      style: GoogleFonts.montserrat(
                                        color: Theme.of(context).brightness == Brightness.light
                                            ? AppColors.lightSecondaryColor
                                            : AppColors.darkSecondaryColor,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                ),
                                const Spacer(flex: 8),
                                Expanded(
                                  flex: 40,
                                  child: FittedBox(
                                    fit: BoxFit.fitHeight,
                                    child: Text(
                                      !isActive ? "00:00:00" : "00:30:26", //TODO value
                                      style: GoogleFonts.montserrat(
                                        color: Theme.of(context).brightness == Brightness.light
                                            ? AppColors.lightSecondaryColor
                                            : AppColors.darkSecondaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                const Spacer(flex: 20),
                                HomePagesComponents.infoWidget(
                                  width: 100.w,
                                  height: 100.h,
                                  download: !isActive ? "– " : "245", //TODO value
                                  upload: !isActive ? "– " : "245", //TODO value
                                  context: context,
                                ),
                                const Spacer(flex: 36),
                                HomePagesComponents.serverCard(
                                  width: 100.w,
                                  height: 100.h,
                                  context: context,
                                  icon: box.get('servers_list')[box.get('selected_server') as int]['icon'],
                                  serverName: box.get('servers_list')[box.get('selected_server') as int]['name'],
                                  serverIp: 'empty', //TODO value
                                  serverPing: 0, //TODO value
                                  onTap: () => Navigator.of(context).pushNamed(
                                    AppRoutes.changeServerHomePage,
                                  ),
                                ),
                                const Spacer(flex: 180),
                              ],
                            ),
                          ),
                          AppComponents.menuButton(100.w, 100.h, context, () => _key.currentState!.openDrawer()),
                          AppComponents.changeThemeButton(100.w, 100.h, context),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}
