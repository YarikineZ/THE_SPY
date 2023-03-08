// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:the_spy/models/numerical_settings.dart';
import 'package:the_spy/models/locations.dart';

import 'package:the_spy/pages/start_page.dart';
import 'package:the_spy/pages/roles_page.dart';

import 'package:the_spy/utils/theme.dart';

void main() {
  //setupWindow();
  runApp(const MyApp());
}

const double windowWidth = 400;
const double windowHeight = 800;

GoRouter router() {
  return GoRouter(
    initialLocation: '/start',
    routes: [
      GoRoute(
        path: '/start',
        builder: (context, state) => StartPage(),
      ),
      GoRoute(
        path: '/roles',
        builder: (context, state) => RolesPage(),
      ),
    ],
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Using MultiProvider is convenient when providing multiple objects.
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NumericalSettingsModel>(
            create: (context) => NumericalSettingsModel()),
        ChangeNotifierProvider<LocationsModel>(
            create: (context) => LocationsModel()),
      ],
      child: MaterialApp.router(
        title: 'Provider Demo',
        debugShowCheckedModeBanner: false,
        theme: appTheme(),
        routerConfig: router(),
      ),
    );
  }
}
