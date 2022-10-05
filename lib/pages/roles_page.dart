import 'package:flutter/material.dart';

class RolesScreen extends StatelessWidget {
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
        //body: const _scrollWidget());
        body: Center(child: Text(players.toString())));
  }
}

class _scrollWidget extends StatefulWidget {
  const _scrollWidget({Key? key}) : super(key: key);

  @override
  State<_scrollWidget> createState() => _scrollWidgetState();
}

class _scrollWidgetState extends State<_scrollWidget> {
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
          Text('Игрок USERNAME'),
          //Text(_values.toString())
          SizedBox(height: 50.0),
          Icon(
            Icons.swipe_up,
            size: 50,
          )
        ])),
        Center(
          child: Text('Ты шпион'),
        ),
        Center(
          child: Text('Передай устройство игроку USERNAME 2'),
        ),
      ],
    );
  }

  Widget _firstCard(context) {
    return const Text('First Page');
  }
}
