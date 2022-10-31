import 'package:flutter/material.dart';
import 'package:swipe_deck/swipe_deck.dart';
import 'dart:math';
import 'start_page.dart';
import '../widgets/common_widgets.dart';

final borderRadius = BorderRadius.circular(20.0);
const openText = [
  "Игрок 1",
  "Игрок 2",
  "Игрок 3",
  "Игрок 4",
];

const closedText = [
  "Бар",
  "Шпион",
  "Бар",
  "Бар",
];

class cardModel {
  final int num;
  final String location;
  bool isSpy;

  cardModel({
    required this.num,
    required this.location,
    required this.isSpy,
  });

  @override
  String toString() {
    return 'Student: {num: $num, location: $location, isSpy: $isSpy }';
  }
}

///////////

class RolesScreen extends StatefulWidget {
  static const routeName = '/roles';
  //final int players;
  final Model model;

  const RolesScreen({super.key, required this.model});

  @override
  State<RolesScreen> createState() => _RolesScreenState();
}

class _RolesScreenState extends State<RolesScreen> {
  List<cardModel> cards = [];
  List avaliableLocations = [
    "Самолет",
    "Бар",
    "Завод",
    "Офис",
    "Больница",
    "Стадион",
    "Караоке"
  ];

  void _generateCardsData(int cardsNumber) {
    Random random = new Random();
    String chosedLocation =
        avaliableLocations[random.nextInt(avaliableLocations.length)];

    // выберем локацию
    for (var i = 1; i <= cardsNumber; i++) {
      cards.add(cardModel(num: i, location: chosedLocation, isSpy: false));
    }
    // сделаем одного шпиона

    int spyPosition = random.nextInt(cardsNumber);
    cards[spyPosition].isSpy = true;

    print(cards);
  }

  @override
  void initState() {
    _generateCardsData(widget.model.players);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // body: Center(
        //   child: Text(widget.model.players.toString()),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        body: Center(
            child: SwipeDeck(
          startIndex: 0,
          emptyIndicator: Container(
            child: Center(
              child: Text("Nothing Here"),
            ),
          ),
          cardSpreadInDegrees: 5, // Change the Spread of Background Cards
          onSwipeLeft: () {
            print("USER SWIPED LEFT -> GOING TO NEXT WIDGET");
          },
          onSwipeRight: () {
            print("USER SWIPED RIGHT -> GOING TO PREVIOUS WIDGET");
          },
          widgets: cards
              .map((e) => _Card(
                    cardData: e,
                  ))
              .toList(),
        )));
  }
}

class _Card extends StatefulWidget {
  final cardModel cardData;

  const _Card({super.key, required this.cardData});

  @override
  State<_Card> createState() => __CardState();
}

class __CardState extends State<_Card> {
  bool isBack = true;
  double angle = 0;

  void _flip() {
    setState(() {
      angle = (angle + pi) % (2 * pi);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //onTap: _flip,
      onLongPress: _flip,
      onLongPressUp: _flip,
      child: TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: angle),
          duration: Duration(milliseconds: 400),
          curve: Curves.easeOutBack,
          builder: (BuildContext context, double val, __) {
            //here we will change the isBack val so we can change the content of the card
            if (val >= (pi / 2)) {
              isBack = false;
            } else {
              isBack = true;
            }
            return (Transform(
              //let's make the card flip by it's center
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateX(val),
              child: Center(
                child: Container(
                    child: isBack
                        ? Container(
                            decoration: cardDecoration(),
                            child: Center(
                                child: Text(widget.cardData.num.toString())),
                          )
                        : Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.identity()..rotateX(pi),
                            child: Container(
                              decoration: cardDecoration(),
                              child: widget.cardData.isSpy
                                  ? const Center(child: Text('Шпион'))
                                  : Center(
                                      child: Text(widget.cardData.location)),
                            ),
                          ) //else we will display it here,
                    ),
              ),
            ));
          }),
    );
  }
}
