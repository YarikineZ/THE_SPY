import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import 'package:the_spy/utils/theme.dart';
import 'package:the_spy/models/numerical_settings.dart';
import 'package:the_spy/models/locations.dart';

//import 'roles_page.dart';

class StartPage extends StatelessWidget {
  Widget build(BuildContext context) => _View();
}

class _View extends StatelessWidget {
  const _View({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backWallColor,
      appBar: AppBar(
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Шпион",
              ),
              OutlinedButton(
                  onPressed: () {
                    //Navigator.pushNamed(context, '/rules');
                  },
                  child: const Text('Правила')),
            ],
          ),
        ),
        //elevation: 0,
      ),
      body: SafeArea(
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: [
            NumericIsland(),
            LocationsIsland(),
            BottomSheet(),
          ],
        ),
      ),
      //bottomSheet: BottomSheet(),
    );
  }
}

class NumericIsland extends StatelessWidget {
  const NumericIsland({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var settings = context.watch<NumericalSettingsModel>();

    return Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Игроки",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              incDecButtons(settings.players, 3, 15, settings.incPlayers,
                  settings.decPlayers, context),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Шпионы",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              incDecButtons(settings.spies, 1, 3, settings.incSpies,
                  settings.decSpies, context)
            ],
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    "Время игры",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Text(
                    "Минуты",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ]),
                incDecButtons(settings.timer, 1, 10, settings.incTimer,
                    settings.decTimer, context)
              ])
        ]));
  }

  Widget incDecButtons(int value, int minValue, int maxValue, Function inc,
      Function dec, context) {
    return Row(children: [
      IconButton(
        padding: const EdgeInsets.all(0.0),
        iconSize: mainScreenIconsSize,
        color: iconColor,
        icon: value > minValue ? Icon(Icons.remove_circle) : Icon(Icons.remove),
        onPressed: value > minValue ? () => dec() : () {},
      ),
      Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          width: 55,
          child: Text(
            value.toString(),
            style: Theme.of(context).textTheme.displaySmall,
            textAlign: TextAlign.center,
          )),
      IconButton(
        padding: const EdgeInsets.all(0.0),
        iconSize: mainScreenIconsSize,
        color: iconColor,
        icon: value < maxValue ? Icon(Icons.add_circle) : Icon(Icons.add),
        onPressed: value < maxValue ? () => inc() : () {},
      ),
    ]);
  }
}

class LocationsIsland extends StatelessWidget {
  const LocationsIsland({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Location island builder");

    return Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        padding: const EdgeInsets.all(20),
        decoration: cardDecoration(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                "Локации",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            Wrap(
              spacing: 6.0,
              //runSpacing: 6.0,
              children: [
                //TODO это надо отрефакторить
                LocationShip(num: 0),
                LocationShip(num: 1),
                LocationShip(num: 2),
                LocationShip(num: 3),
                LocationShip(num: 4),
              ],
            ),
          ],
        ));
  }
}

class LocationShip extends StatelessWidget {
  final int num;
  LocationShip({required this.num, Key? key});

  @override
  Widget build(BuildContext context) {
    var locs = context.watch<LocationsModel>();

    return OutlinedButton(
        style: locs.locations[num]["isActive"] //.isActive
            ? activeLocationButtonStyle
            : inactiveLocationButtonStyle,
        onPressed: () {
          locs.toggleLocation(num);
        },
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              locs.locations[num]["logo"],
              style: emojiStyle,
            ),
            SizedBox(width: 5),
            Text(
              locs.locations[num]["label"],
            ),
          ],
        ));
  }
}

class BottomSheet extends StatelessWidget {
  const BottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final state = context.read<_StartPageState>();
    var locations = context.watch<LocationsModel>();

    bool val = false;

    return Container(
      padding: const EdgeInsets.only(bottom: 70),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        OutlinedButton(
            onPressed: () {
              locations.isAnyActive() ? context.push('/roles') : {};
              //Navigator.pushNamed(context, '/roles');
              //context.pushReplacement('/roles');
            },
            //style: locations.isActive.any((element) => element)
            style: locations.isAnyActive()
                ? activeStartButtonStyle
                : inactiveStartButtonStyle,
            child: Text("Начать Игру"))
      ]
          //style: ButtonStyle(textStyle: TextStyle(color: Colors.black)),
          ),
    );
  }
}
