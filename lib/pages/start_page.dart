import 'package:flutter/material.dart';
import '../widgets/common_widgets.dart';
import 'roles_page.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);
  static const routeName = '/start';

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  Widget playersIsland = PlayersIsland();
  Widget locationIsland = LocationsIsland();
  Widget timerIsland = TimerIsland();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    List<TextEditingController> _controllers;
  }

  Widget build(BuildContext context) {
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
          playersIsland,
          locationIsland,
          timerIsland,
          //TimerIsland_v2(),
        ],
      ),
      bottomSheet: BottomSheet(5),
    ));
  }
}

class BottomSheet extends StatelessWidget {
  const BottomSheet(int players, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              onPressed: () {},
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 7),
                child: Row(
                  children: [
                    Text(
                      'Начать   ',
                      style: TextStyle(fontSize: 18),
                    ),
                    Icon(Icons.play_circle),
                  ],
                ),
              ),
              style: ElevatedButton.styleFrom(primary: Colors.pinkAccent))
        ],
      ),
    );
  }
}

class PlayersIsland extends StatefulWidget {
  const PlayersIsland({
    Key? key,
  }) : super(key: key);

  @override
  State<PlayersIsland> createState() => _PlayersIslandState();
}

class _PlayersIslandState extends State<PlayersIsland> {
  int players = 3;

  void _inc() {
    setState(() {
      players += 1;
    });
  }

  void _dec() {
    setState(() {
      players > 3 ? players -= 1 : players;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  onPressed: () => _dec(),
                ),
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    width: 55,
                    child: Text(
                      this.players.toString(),
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    )),
                IconButton(
                  padding: const EdgeInsets.all(0.0),
                  icon:
                      Icon(Icons.add_circle_outline, size: mainScreenIconsSize),
                  onPressed: () => _inc(),
                )
              ],
            ))
          ],
        ));
  }
}

class LocationsIsland extends StatefulWidget {
  const LocationsIsland({Key? key}) : super(key: key);

  @override
  State<LocationsIsland> createState() => _LocationsIslandState();
}

class _LocationsIslandState extends State<LocationsIsland> {
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

class TimerIsland extends StatefulWidget {
  const TimerIsland({Key? key}) : super(key: key);

  @override
  State<TimerIsland> createState() => _TimerIslandState();
}

class _TimerIslandState extends State<TimerIsland> {
  int minutes = 3;
  int maxMinutes = 7;
  int minMinutes = 1;

  void _inc() {
    setState(() {
      minutes < maxMinutes ? minutes += 1 : minutes;
    });
  }

  void _dec() {
    setState(() {
      minutes > minMinutes ? minutes -= 1 : minutes;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                        size: mainScreenIconsSize,
                        color:
                            minutes > minMinutes ? Colors.black : Colors.grey),
                    onPressed: () => _dec(),
                  ),
                  Text("${minutes} минуты", style: TextStyle(fontSize: 20)),
                  IconButton(
                    padding: const EdgeInsets.all(0.0),
                    icon: Icon(Icons.add_circle_outline,
                        size: mainScreenIconsSize),
                    onPressed: () => _inc(),
                  )
                ],
              ),
            )
          ],
        ));
  }
}

class TimerIsland_v2 extends StatefulWidget {
  const TimerIsland_v2({Key? key}) : super(key: key);

  @override
  State<TimerIsland_v2> createState() => _TimerIsland_v2State();
}

class _TimerIsland_v2State extends State<TimerIsland_v2> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: cardMargin(),
        padding: cardPaddding(),
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
              height: 100.0,
              margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
              child: ListView(scrollDirection: Axis.horizontal,
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [timerButton(1), timerButton(3), timerButton(5)]),
            )
          ],
        ));
  }

  timerButton(int value) {
    return Container(
        margin: cardMargin(),
        padding: cardPaddding(),
        decoration: cardDecoration(),
        child: Center(child: Text(value.toString())));
  }
}
