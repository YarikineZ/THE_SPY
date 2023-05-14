import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

import 'package:flutter_card_swiper/flutter_card_swiper.dart';

import 'package:the_spy/utils/theme.dart';
import 'package:the_spy/widgets/flipping_card.dart';
import 'package:the_spy/models/numerical_settings.dart';
import 'package:the_spy/models/locations.dart';

class RolesPage extends StatelessWidget {
  //const RolesPage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // var numSettings = context.read<NumericalSettingsModel>();
    // var locations = context.read<LocationsModel>();
    // var chosenPack = locations.getRandomChosenPack();
    // var randomLocation = locations.getRandomLocationInPack(chosenPack["id"]);

    final cards = List.generate(20, (index) => index);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      ),
      body: SafeArea(
        child: Deck(cards: cards),
      ),
    );
  }
}

class Deck extends StatefulWidget {
  const Deck({Key key, this.cards}) : super(key: key);

  final List<int> cards;

  @override
  State<Deck> createState() => _DeckState();
}

class _DeckState extends State<Deck> {
  var _offset = 0;

  Widget _buildCard(int value, double width, double height) {
    return SizedBox(
      width: width,
      height: height,
      child: PlayingCard(
        value: value,
        onClearTap: () {
          setState(() {
            _offset++;
          });
        },
      ),
    );
  }

  Widget _buildItem({
    int visibleIndex,
    int dataIndex,
    double width,
    double height,
    bool isLeaving,
    bool isEntering,
  }) {
    return Align(
      key: ValueKey('card_$dataIndex'),
      alignment: Alignment.center,
      child: DeckCardAnimationWrapper(
        indexInVisibleStack: visibleIndex,
        isLeaving: isLeaving,
        isEntering: isEntering,
        cardWidget: _buildCard(widget.cards[dataIndex], width, height),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      const visibleCardsCount = 3;
      const aspectRatio = 102 / 63; //TODO  надо как-то по человечески
      final cardWidth = constraints.maxWidth * 0.8;
      final cardHeight = cardWidth * aspectRatio;

      final cardsToShow = widget.cards.skip(_offset).take(visibleCardsCount);

      final indexToLeave = _offset - 1;
      final indexToEnter = _offset + visibleCardsCount;

      return Stack(
        children: [
          const Align(
            alignment: Alignment.center,
            child: DoneWidget(),
          ),
          if (indexToEnter < widget.cards.length)
            _buildItem(
              visibleIndex: visibleCardsCount,
              dataIndex: indexToEnter,
              width: cardWidth,
              height: cardHeight,
              isLeaving: false,
              isEntering: true,
            ),
          for (var i = cardsToShow.length - 1; i >= 0; i--)
            _buildItem(
              visibleIndex: i,
              dataIndex: i + _offset,
              width: cardWidth,
              height: cardHeight,
              isLeaving: false,
              isEntering: false,
            ),
          if (indexToLeave > 0)
            _buildItem(
              visibleIndex: -1,
              dataIndex: indexToLeave,
              width: cardWidth,
              height: cardHeight,
              isLeaving: true,
              isEntering: false,
            ),
        ],
      );
    });
  }
}

class DeckCardAnimationWrapper extends StatelessWidget {
  const DeckCardAnimationWrapper({
    Key key,
    this.isLeaving,
    this.isEntering,
    this.indexInVisibleStack,
    this.cardWidget,
  }) : super(key: key);

  final Widget cardWidget;
  final bool isLeaving;
  final bool isEntering;
  final int indexInVisibleStack;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 250),
      opacity: isEntering ? 0 : 1,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        transform: Matrix4.identity()
          ..translate(
            indexInVisibleStack * 16.0 +
                (isLeaving ? -MediaQuery.of(context).size.width : 0),
            indexInVisibleStack * 16.0,
          ),
        transformAlignment: Alignment.center,
        child: cardWidget,
      ),
    );
  }
}

class DoneWidget extends StatelessWidget {
  const DoneWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        Text(
          'ВСЁ!',
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

//КАРТА
//==================================

class PlayingCard extends StatefulWidget {
  const PlayingCard({
    Key key,
    this.value,
    this.onClearTap,
  }) : super(key: key);

  final int value; //поменять на параметры локации и игроков
  final VoidCallback onClearTap;

  @override
  State<PlayingCard> createState() => _PlayingCardState();
}

class _PlayingCardState extends State<PlayingCard>
    with TickerProviderStateMixin {
  AnimationController _flipAnimationController;

  var _isFlipped = false;

  @override
  void initState() {
    super.initState();
    _flipAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      lowerBound: 0,
      upperBound: 1,
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _isFlipped = true;
        }
      });
  }

  @override
  void dispose() {
    _flipAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_isFlipped) {
          widget.onClearTap();
          return;
        }
        if (!_flipAnimationController.isAnimating) {
          _flipAnimationController.forward();
        }
      },
      child: AnimatedBuilder(
        animation: _flipAnimationController,
        builder: (context, child) {
          final animValue = _flipAnimationController.value;
          final isFrontVisible = animValue < 0.5;

          Widget visibleCardSide;
          if (isFrontVisible) {
            visibleCardSide = CardLayoutBuilder(
              flipped: false,
              index: widget.value,
            );
          } else {
            visibleCardSide = Transform(
              transform: Matrix4.rotationY(math.pi),
              alignment: Alignment.center,
              child: CardLayoutBuilder(
                flipped: true,
                index: widget.value,
              ),
            );
          }

          return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.0005)
              ..rotateY(animValue * math.pi),
            alignment: Alignment.center,
            child: visibleCardSide,
          );
        },
      ),
    );
  }
}

class CardLayoutBuilder extends StatelessWidget {
  CardLayoutBuilder({
    Key key,
    this.index,
    //this.role,
    this.flipped,
  }) : super(key: key);

  final int index;
  //final String role;
  bool flipped;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: playingCardDecoration(context),
        child: flipped ? _rearSide() : _frontSide());
  }

  Widget _frontSide() {
    return Stack(fit: StackFit.expand, children: [
      Image.asset(
        "assets/Card_img.png",
        fit: BoxFit.fill,
      ),
      Positioned(
          right: 30,
          top: 30,
          child: Text(
            "$index",
            style: playingCardsH1Style,
          )),
      Center(
          child: Text(
        "Нажми, чтобы\n узнать свою роль",
        style: playingCardsH1Style,
        textAlign: TextAlign.center,
      ))
    ]);
  }

  Widget _rearSide() {
    return Stack(fit: StackFit.expand, children: [
      Image.asset(
        "assets/CivilCardBackgtound.png",
        fit: BoxFit.fill,
      ),
      Center(
          child: Text(
        "Игрок $index",
        style: playingCardsH1Style,
        textAlign: TextAlign.center,
      ))
    ]);
  }
}
