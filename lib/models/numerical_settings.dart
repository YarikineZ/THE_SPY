import 'package:flutter/material.dart';

class NumericalSettingsModel extends ChangeNotifier {
  NumericalSettingsModel({this.players = 3, this.spies = 1, this.timer = 3});

  // int players;
  // int spies = 1;
  // int timer = 5;

  int players;
  int spies;
  int timer;

  void incPlayers() {
    players += 1;
    notifyListeners();
  }

  void decPlayers() {
    players -= 1;
    notifyListeners();
  }

  void incTimer() {
    timer += 1;
    notifyListeners();
  }

  void decTimer() {
    timer -= 1;
    notifyListeners();
  }

  void incSpies() {
    spies += 1;
    notifyListeners();
  }

  void decSpies() {
    spies -= 1;
    notifyListeners();
  }
}
