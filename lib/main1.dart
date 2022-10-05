//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:the_spy/pages/start_page.dart';
import 'package:the_spy/pages/rules_page.dart';
import 'package:the_spy/pages/roles_page.dart';
//import 'package:the_spy/pages/simple_form.dart';

void main() => runApp(MaterialApp(
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        initialRoute: "/start",
        routes: {
          "/start": (context) => const StartPage(),
          "/roles": (context) => const RolesScreen(players: []),
          "/rules": (context) => const RulesScreen(),
        }));


/*
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const StartPage());
}



*/


