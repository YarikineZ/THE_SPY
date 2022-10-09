import 'package:flutter/material.dart';
import 'dart:math';

class RolesScreen extends StatefulWidget {
  static const routeName = '/roles';
  final List players;

  const RolesScreen({super.key, required this.players});

  @override
  State<RolesScreen> createState() => _RolesScreenState();
}

class _RolesScreenState extends State<RolesScreen> {
  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    //логичнее генерировать роли игроков на уровне выше, но у меня не получилось
    final List roles = generateRoles(widget.players.length);

    return Scaffold(
        appBar: AppBar(
          title: Text("Распределение ролей"),
          centerTitle: true,
          actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.home))],
        ),
        body: widget.players.isNotEmpty
            ? _scrollWidget(players: widget.players, roles: roles)
            : Text("Players empty"));
  }

  List generateRoles(int lenth) {
    //Возвращает информацию для игроков. Всем локацию и одному ШПИОН
    //надо обращаться из инициализатора виджета а не состояния
    List avaliableLocations = [
      "Самолет",
      "Бар",
      "Завод",
      "Офис",
      "Больница",
      "Стадион",
      "Караоке"
    ];

    Random random = new Random();
    String chosedLocation =
        avaliableLocations[random.nextInt(avaliableLocations.length)];
    List playersInfo =
        List<String>.generate(lenth, (int index) => chosedLocation);
    int spyPosition = random.nextInt(lenth);
    playersInfo[spyPosition] = "Шпион";
    print(playersInfo);
    return playersInfo;
  }
}

class _scrollWidget extends StatefulWidget {
  final List players;
  final List roles;
  //видимо надо генерировать роли где-то тут в конструкторе
  const _scrollWidget({Key? key, required this.players, required this.roles})
      : super(key: key);

  @override
  State<_scrollWidget> createState() => _scrollWidgetState();
}

class _scrollWidgetState extends State<_scrollWidget> {
  int playerCounter = 0;

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    return PageView(
      controller: controller,
      scrollDirection: Axis.vertical,
      children: [
        Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("Игрок ${widget.players[playerCounter].toString()}"),
          SizedBox(height: 50.0),
          Icon(
            Icons.swipe_up,
            size: 50,
          )
        ])),
        Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.roles[playerCounter]),
            //if (playerCounter < widget.players.length) {

            ElevatedButton(
                child: playerCounter < widget.players.length - 1
                    ? Text(
                        'Передай устройство игроку ${widget.players[playerCounter + 1]}')
                    : Text("Начать игру"),
                onLongPress: () {
                  if (playerCounter < widget.players.length - 1) {
                    controller.jumpToPage(0);
                    setState(() {
                      playerCounter++;
                    });
                  } else {
                    Navigator.pushNamed(context, '/timer');
                  }
                },
                onPressed: () {})
          ],
        )),
      ],
    );
  }
}
