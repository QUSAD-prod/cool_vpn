import 'package:cool_vpn/pages/home/account_home_page.dart';
import 'package:cool_vpn/pages/auth/forgot_password_auth_page.dart';
import 'package:cool_vpn/pages/home/upgrade_to_premium_home_page.dart';
import 'package:flutter/material.dart';

import '../pages/auth/main_auth_page.dart';
import '../pages/auth/password_signin_auth_page.dart';
import '../pages/auth/password_signup_auth_page.dart';
import '../pages/check_auth_page.dart';
import '../pages/home/change_server_home_page.dart';
import '../pages/home/main_home_page.dart';
import '../pages/start_page.dart';

class AppRoutes {
  static String initialRoute = startPage;

  static String startPage = '/startPage';
  static String checkAuthPage = '/checkAuthPage';
  static String mainAuthPage = '/mainAuthPage';
  static String passwordSignInAuthPage = '/passwordSignInAuthPage';
  static String passwordSignUpAuthPage = '/passwordSignUpAuthPage';
  static String forgotPasswordAuthPage = '/forgotPasswordAuthPage';
  static String mainHomePage = '/mainHomePage';
  static String changeServerHomePage = '/changeServerHomePage';
  static String accountHomePage = '/accountHomePage';
  static String upgradeToPremiumHomePage = '/upgradeToPremiumHomePage';

  static Map<String, Widget Function(BuildContext)> getRoutes(BuildContext context) {
    return {
      startPage: (BuildContext context) => const StartPage(),
      checkAuthPage: (BuildContext context) => const CheckAuthPage(),
      mainAuthPage: (BuildContext context) => const MainAuthPage(),
      passwordSignInAuthPage: (BuildContext context) => const PasswordSignInAuthPage(),
      passwordSignUpAuthPage: (BuildContext context) => const PasswordSignUpAuthPage(),
      forgotPasswordAuthPage: (BuildContext context) => const ForgotPasswordAuthPage(),
      mainHomePage: (BuildContext context) => const MainHomePage(),
      changeServerHomePage: (BuildContext context) => const ChangeServerHomePage(),
      accountHomePage: (BuildContext context) => const AccountPage(),
      upgradeToPremiumHomePage: (BuildContext context) => const UpgradeToPremiumHomePage(),
    };
  }
}
