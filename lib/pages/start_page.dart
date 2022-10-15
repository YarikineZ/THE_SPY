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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    List<TextEditingController> _controllers;
    int players = 3;
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
            body: Column(
              children: [
                PlayersIsland(),
                LocationsIsland(),
                TimerIsland(),
                Expanded(
                  child: Container(color: Colors.transparent),
                ),
                BottomSheet(),
              ],
            )));
  }
}

class BottomSheet extends StatelessWidget {
  const BottomSheet({Key? key}) : super(key: key);

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
  const PlayersIsland({Key? key}) : super(key: key);

  @override
  State<PlayersIsland> createState() => _PlayersIslandState();
}

class _PlayersIslandState extends State<PlayersIsland> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        padding: const EdgeInsets.all(20),
        decoration: cardDecoration(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Игроки",
              style: TextStyle(fontSize: 20),
            ),
            Container(
                child: Row(
              children: [
                Icon(
                  Icons.do_not_disturb_on_outlined,
                  size: mainScreenIconsSize,
                ),
                SizedBox(width: 15),
                Text("3", style: TextStyle(fontSize: 20)),
                SizedBox(width: 15),
                Icon(
                  Icons.add_circle_outline,
                  size: mainScreenIconsSize,
                ),
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
                _location(Icons.location_city, "В городе"),
                _location(Icons.language_sharp, "Страны"),
              ],
            )
          ],
        ));
  }

  _location(IconData icon, String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 7),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      decoration: BoxDecoration(
        //border: Border.all(color: Color(0xE8E8E8)),
        border:
            Border.all(color: Colors.black45), // Wi // Will work, width: 1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 50,
          ),
          Text(title)
        ],
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
                  Icon(
                    Icons.do_not_disturb_on_outlined,
                    size: mainScreenIconsSize,
                  ),
                  Text("3 минуты", style: TextStyle(fontSize: 20)),
                  Icon(
                    Icons.add_circle_outline,
                    size: mainScreenIconsSize,
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
