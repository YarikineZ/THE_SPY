import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../utils/theme.dart';
import 'roles_page.dart';

class Locations {
  // final List logo = ["tmp", "tmp", "tmp", "tmp"];
  // final List name = ["Природа", "Страны", "Города России", "Спорт"];
  // final List isActive = [true, false, false, false];
  final List logo;
  final List name;
  final List isActive;

  Locations({required this.logo, required this.name, required this.isActive});

  Locations copyWith({List? logo, List? name, List? isActive}) {
    return Locations(
        logo: logo ?? this.logo,
        name: name ?? this.name,
        isActive: isActive ?? this.isActive);
  }
}

class Model {
  final int players;
  final int spies;
  final int timer;

  Model({
    required this.players,
    required this.spies,
    required this.timer,
  });

  Model copyWith({int? players, int? spies, int? timer}) {
    return Model(
        players: players ?? this.players,
        spies: spies ?? this.spies,
        timer: timer ?? this.timer);
  }
}

class StartPage extends StatefulWidget {
  //const StartPage({Key? key}) : super(key: key);
  static const routeName = '/start';

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  var model = Model(
    players: 3,
    spies: 1,
    timer: 3,
  );

  var locations = Locations(
      logo: ["🌳", "🌐", "🪆", "🚋", "⚽"],
      name: ["Природа", "Страны", "Города России", "Транспорт", "Спорт"],
      isActive: [true, false, false, false, false]);

  void inc_players() {
    model = model.copyWith(players: model.players + 1);
    setState(() {});
  }

  void dec_players() {
    model = model.copyWith(players: model.players - 1);
    setState(() {});
  }

  void inc_spies() {
    model = model.copyWith(spies: model.spies + 1);
    setState(() {});
  }

  void dec_spies() {
    model = model.copyWith(spies: model.spies - 1);
    setState(() {});
  }

  void inc_timer() {
    model = model.copyWith(timer: model.timer + 1);
    setState(() {});
  }

  void dec_timer() {
    model = model.copyWith(timer: model.timer - 1);
    setState(() {});
  }

  void goNext() {
    Navigator.pushNamed(
      context,
      RolesScreen.routeName,
      arguments: model,
    );
  }

  void toggleLocation(int num) {
    var activeList = locations.isActive;
    activeList[num] = !activeList[num];
    locations = locations.copyWith(isActive: activeList);
    setState(() {});
  }
// тут же напишем функции, через которые будем влиять на цифры

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider.value(value: this),
          Provider.value(value: model),
          Provider.value(value: locations),
        ],
        child: const _View(),
      );
}

class _View extends StatelessWidget {
  const _View({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.read<_StartPageState>();

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: false,
        //backgroundColor: Colors.red,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Шпион",
              ),
              OutlinedButton(
                  style: rulesOutlinedButtonStyle,
                  onPressed: () {
                    Navigator.pushNamed(context, '/rules');
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
          ],
        ),
      ),
      bottomSheet: BottomSheet(),
    ));
  }
}

class NumericIsland extends StatelessWidget {
  const NumericIsland({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final state = context.read<_StartPageState>();
    final players = context.select((Model value) => value.players);
    final spies = context.select((Model value) => value.spies);
    final timer = context.select((Model value) => value.timer);

    return Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        padding: const EdgeInsets.all(20),
        decoration: cardDecoration(context),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Игроки",
                  style: Theme.of(context).textTheme.headline3,
                ),
                incDecButtons(players, 3, 10, state.inc_players,
                    state.dec_players, context)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Шпионы",
                  style: Theme.of(context).textTheme.headline3,
                ),
                incDecButtons(
                    spies, 1, 3, state.inc_spies, state.dec_spies, context)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Время игры",
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    Text(
                      "Минуты",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ],
                ),
                incDecButtons(
                    timer, 1, 10, state.inc_timer, state.dec_timer, context)
              ],
            )
          ],
        ));
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
            style: Theme.of(context).textTheme.headline3,
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
    final state = context.read<_StartPageState>();
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
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            Wrap(
              spacing: 6.0,
              //runSpacing: 6.0,
              children: [
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
    final state = context.read<_StartPageState>();
    final locations = context.select((Locations locations) => locations);

    return OutlinedButton(
        style: locations.isActive[num]
            ? activeLocationButtonStyle
            : inactiveLocationButtonStyle,
        onPressed: () => state.toggleLocation(num),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              locations.logo[num],
              style: emojiStyle,
            ),
            SizedBox(width: 5),
            Text(locations.name[num]),
          ],
        ));
  }
}

class BottomSheet extends StatelessWidget {
  const BottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.read<_StartPageState>();
    final locations = context.select((Locations locations) => locations);

    bool val = false;

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.only(bottom: 70),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        OutlinedButton(
            onPressed: () {},
            style: locations.isActive.any((element) => element)
                ? activeStartButtonStyle
                : inactiveStartButtonStyle,
            child: Text("Начать Игру"))
      ]
          //style: ButtonStyle(textStyle: TextStyle(color: Colors.black)),
          ),
    );
  }
}
