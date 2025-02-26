import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../components/app_colors.dart';
import 'home_pages_components.dart';

class ChangeServerHomePage extends StatefulWidget {
  const ChangeServerHomePage({super.key});

  @override
  State<ChangeServerHomePage> createState() => _ChangeServerHomePageState();
}

class _ChangeServerHomePageState extends State<ChangeServerHomePage> {
  late List<Widget> serverWidgetsList;
  late List<Map<String, dynamic>> serversList;

  @override
  void initState() {
    super.initState();
    serversList = Hive.box('servers').get('servers_list');
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("VPN Server"),
        backgroundColor: Theme.of(context).brightness == Brightness.light ? AppColors.lightSecondaryColor : Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22 / 375 * width),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 24 / 812 * height,
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: serversList.length,
                itemBuilder: (context, el) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: HomePagesComponents.serverCard(
                      width: width,
                      height: height,
                      context: context,
                      icon: serversList[el]['icon'],
                      serverName: serversList[el]['name'],
                      serverIp: 'empty', //TODO value
                      serverPing: 0, //TODO value
                      onTap: () => Hive.box('servers').put('selected_server', el).then(
                            (value) => Navigator.of(context).pop(),
                          ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 32 / 812 * height,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
