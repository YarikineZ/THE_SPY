import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/common_widgets.dart';
import 'roles_page.dart';

class Model {
  final int players;
  final int timer;

  Model({
    required this.players,
    required this.timer,
  });

  Model copyWith({
    int? players,
    int? timer,
  }) {
    return Model(
      players: players ?? this.players,
      timer: timer ?? this.timer,
    );
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
    timer: 3,
  );

  void inc_players() {
    model = model.copyWith(players: model.players + 1);
    setState(() {});
  }

  void dec_players() {
    model = model.copyWith(players: model.players - 1);
    setState(() {});
  }

  void goNext() {
    Navigator.pushNamed(
      context,
      RolesScreen.routeName,
      arguments: model,
    );
  }

// тут же напишем функции, через которые будем влиять на цифры

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider.value(value: this),
          Provider.value(value: model),
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
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: const Text("Новая игра"),
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/rules');
            },
            icon: Icon(
              Icons.help_outline,
              size: mainScreenIconsSize,
            )),
      ),
      body: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          PlayersIsland(),
          //LocationsIsland(),
          //TimerIsland(),
        ],
      ),
      bottomSheet: BottomSheet(5),
    ));
  }
}

class PlayersIsland extends StatelessWidget {
  const PlayersIsland({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final state = context.read<_StartPageState>();
    final players = context.select((Model value) => value.players);

    return Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        padding: const EdgeInsets.all(20),
        decoration: cardDecoration(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Игроки",
              style: TextStyle(fontSize: 20),
            ),
            Container(
                child: Row(
              children: [
                IconButton(
                  padding: const EdgeInsets.all(0.0),
                  icon: Icon(Icons.do_not_disturb_on_outlined,
                      size: mainScreenIconsSize,
                      color: players > 3 ? Colors.black : Colors.grey),
                  onPressed: () => state.dec_players(),
                ),
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    width: 55,
                    child: Text(
                      players.toString(),
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    )),
                IconButton(
                  padding: const EdgeInsets.all(0.0),
                  icon:
                      Icon(Icons.add_circle_outline, size: mainScreenIconsSize),
                  onPressed: () => state.inc_players(),
                )
              ],
            ))
          ],
        ));
  }
}

/*
Видимо надо перееписать?

class LocationsIsland extends StatelessWidget {
  const LocationsIsland({Key? key}) : super(key: key);

  List<int> _selectedItems = [];
  List<bool> _isActive = [false, false];

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        padding: const EdgeInsets.all(20),
        decoration: cardDecoration(),
        child: Column(
          children: [
            Row(
              children: [
                Text("Локации", style: TextStyle(fontSize: 20)),
              ],
            ),
            Row(
              //scrollDirection: Axis.horizontal,
              children: [
                _location(Icons.location_city, "В городе", 0),
                _location(Icons.language_sharp, "Страны", 1),
              ],
            )
          ],
        ));
  }

  _location(IconData icon, String title, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          this._isActive[index] = !this._isActive[index];
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 7),
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        width: 100,
        decoration: BoxDecoration(
          //border: Border.all(color: Color(0xE8E8E8)),
          border: this._isActive[index]
              ? Border.all(color: enabledColor)
              : Border.all(color: disabledColor), // Wi // Will work, width: 1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 50,
              color: this._isActive[index] ? enabledColor : disabledColor,
            ),
            Text(title)
          ],
        ),
      ),
    );
  }
}

class TimerIsland extends StatelessWidget {
  const TimerIsland({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final minutes = context.select((Model value) => value.timer);

    return Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        padding: const EdgeInsets.all(20),
        decoration: cardDecoration(),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Таймер",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    padding: const EdgeInsets.all(0.0),
                    icon: Icon(Icons.do_not_disturb_on_outlined,
                        size: mainScreenIconsSize, color: Colors.black),
                    onPressed: () => {},
                  ),
                  Text("${minutes} минуты", style: TextStyle(fontSize: 20)),
                  IconButton(
                    padding: const EdgeInsets.all(0.0),
                    icon: Icon(Icons.add_circle_outline,
                        size: mainScreenIconsSize),
                    onPressed: () => {},
                  )
                ],
              ),
            )
          ],
        ));
  }
}


*/
class BottomSheet extends StatelessWidget {
  const BottomSheet(int players, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.read<_StartPageState>();
    final players = context.select((Model value) => value.players);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 27),
      //color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
              onPressed: () {},
              child: Text(
                "Очистить",
                style: TextStyle(
                  color: Colors.black45,
                  fontSize: 18,
                  decoration: TextDecoration.underline,
                ),
              )),
          ElevatedButton(
              onPressed: state.goNext,
              style: ElevatedButton.styleFrom(primary: Colors.pinkAccent),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 7),
                child: Row(
                  children: const [
                    Text(
                      'Начать   ',
                      style: TextStyle(fontSize: 18),
                    ),
                    Icon(Icons.play_circle),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
