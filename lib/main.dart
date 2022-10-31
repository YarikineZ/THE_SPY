//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:the_spy/pages/start_page.dart';
import 'package:the_spy/pages/rules_page.dart';
import 'package:the_spy/pages/roles_page.dart';
import 'package:the_spy/pages/timer_page.dart';

void main() => runApp(MaterialApp(
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: StartPage(),
      routes: {
        StartPage.routeName: (context) => StartPage(),
        RulesScreen.routeName: (context) => RulesScreen(),
        //TimerPage.routeName: (context) =>  TimerPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == RolesScreen.routeName) {
          final mainScreenData = settings.arguments as Model;
          return MaterialPageRoute(
            builder: (context) {
              return RolesScreen(
                model: mainScreenData,
              );
            },
          );
        }
        return null;
      },
    ));
