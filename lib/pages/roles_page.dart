import 'package:flutter/material.dart';

class RolesScreen extends StatelessWidget {
  static const routeName = '/roles';
  final List players;

  const RolesScreen({super.key, required this.players});

  @override
  Widget build(BuildContext context) {
    print("BUILDER ${players}");
    final PageController controller = PageController();

    return Scaffold(
        appBar: AppBar(
          title: Text("Распределение ролей"),
          centerTitle: true,
          actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.home))],
        ),
        body: players.isNotEmpty
            ? _scrollWidget(players: players)
            : Text("Players empty"));
  }
}

class _scrollWidget extends StatefulWidget {
  final List players;

  const _scrollWidget({Key? key, required this.players}) : super(key: key);

  @override
  State<_scrollWidget> createState() => _scrollWidgetState();
}

class _scrollWidgetState extends State<_scrollWidget> {
  // сюда в state запишем счетчик и будем его инкрементировать по нажатию кнопки. + возвращаеееть наверх
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
            Text('Ты шпион'),
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
