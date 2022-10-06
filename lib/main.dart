//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:the_spy/pages/start_page.dart';
import 'package:the_spy/pages/rules_page.dart';
import 'package:the_spy/pages/roles_page.dart';
import 'package:the_spy/pages/timer_page.dart';
//import 'package:the_spy/pages/simple_form.dart';

void main() => runApp(MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: const StartPage(),
      routes: {
        StartPage.routeName: (context) => const StartPage(),
        RulesScreen.routeName: (context) => const RulesScreen(),
        TimerPage.routeName: (context) => const TimerPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == RolesScreen.routeName) {
          final players = settings.arguments as List;
          return MaterialPageRoute(
            builder: (context) {
              return RolesScreen(
                players: players,
              );
            },
          );
        }
        return null;
      },
    ));
