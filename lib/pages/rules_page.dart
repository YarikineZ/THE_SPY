import 'package:flutter/material.dart';

class RulesScreen extends StatefulWidget {
  const RulesScreen({Key? key}) : super(key: key);
  static const routeName = '/rules';
  @override
  State<RulesScreen> createState() => _RulesScreenState();
}

class _RulesScreenState extends State<RulesScreen> {
  //const RulesScreen?
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Правила"), centerTitle: true),
      body: Column(children: [
        Text(
            "На этом экране будут правила игры. Это буут пролистывавемые карточки",
            style: TextStyle(fontSize: 30)),
      ]),
    );
  }
}
