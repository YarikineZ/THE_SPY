import 'package:flutter/material.dart';

class LocationsModel extends ChangeNotifier {
  List<Map> locations = [];

  LocationsModel() {
    locations.add({"logo": "🌳", "label": "Природа", "isActive": true});
    locations.add({"logo": "🌐", "label": "Страны", "isActive": false});
    locations.add({"logo": "🪆", "label": "Города России", "isActive": false});
    locations.add({"logo": "🚋", "label": "Транспорт", "isActive": false});
    locations.add({"logo": "⚽", "label": "Спорт", "isActive": false});
  }

  toggleLocation(int num) {
    locations[num]["isActive"] = !locations[num]["isActive"];
    notifyListeners();
  }

  bool isAnyActive() {
    var sum = 0;
    for (var loc in locations) {
      loc["isActive"] ? sum++ : {};
    }
    return sum != 0;
  }

  @override
  String toString() {
    return locations.toString();
  }
}
