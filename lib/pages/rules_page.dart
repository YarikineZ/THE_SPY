import 'package:flutter/material.dart';
import 'package:the_spy/utils/theme.dart';
import 'package:the_spy/utils/rules.dart';

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
        appBar: AppBar(
          title: Text("Шпион"),
          centerTitle: false,
        ),
        body: SingleChildScrollView(
            child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30),
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            border: Border.all(color: primaryGreen, width: 1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              Text("Правила", style: rulesTextStyle),
              SizedBox(height: 30),
              Text(textOfRules, style: rulesTextStyle),
            ],
          ),
        )));
  }
}
