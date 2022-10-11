import 'package:flutter/material.dart';
import 'roles_page.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);
  static const routeName = '/start';

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  List _values = [];
  List<FocusNode> focusStates = []; //для фокусировки на нужном ввод текста
  //List<Map<FocusNode, dynamic>> focusStates = [];
  late FocusNode myFocusNode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    List<TextEditingController> _controllers;
    focusStates = [];
    _values = [];
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Игроки"),
            //обернууть в геншн и мидл клик
            leading: IconButton(
                //required: () {_values.length>0},
                enableFeedback: true,
                onPressed: () {
                  Navigator.pushNamed(context, '/rules');
                },
                icon: Icon(Icons.help)),
            actions: [
              IconButton(
                  color: _canStartGame() ? Colors.white : Colors.grey,
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      RolesScreen.routeName,
                      arguments: _values,
                    );
                  },
                  icon: const Icon(Icons.start)),
            ],
          ),
          bottomSheet: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StartButton(
                width: 200.0, //double.infinity,
                borderRadius: BorderRadius.circular(20),
                onPressed: () {},
                child: const Text("Начать"),
              ),
            ],
          ),
          body: Container(
            padding: const EdgeInsets.all(20.0),
            //color: Colors.green,
            child: Stack(
              children: [
                GestureDetector(
                    onTap: _onCenterClick,
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            //без цвета контейнер сужается до строки
                            color: Colors.transparent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.touch_app,
                                  size: 30.0,
                                  color: Colors.grey,
                                ),
                                Text(
                                  "  Добавить игроков",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
                ListView.builder(
                  shrinkWrap:
                      true, //хз что это, но если false, то GerionDetector не работает
                  itemCount: _values.length,
                  itemBuilder: (context, index) => _row(index),
                ),
              ],
            ),
          )),
    );
  }

//Почему мы не добавляем возвращаемый функцией тип?
  _row(int index) {
    return Dismissible(
      background: Container(
        alignment: AlignmentDirectional.centerEnd,
        padding: EdgeInsets.only(right: 10.0),
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.red),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      key: Key(_values[index]),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) => _delRow(direction, index),
      dismissThresholds: {DismissDirection.endToStart: 0.5},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        margin: const EdgeInsets.symmetric(vertical: 3.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.black26,
        ),
        child: TextFormField(
          style: TextStyle(fontSize: 18),
          initialValue: _values[index], //костыль?
          focusNode: focusStates[index],
          onFieldSubmitted: _onCenterClick,
          autocorrect: false,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "Имя",
          ),
          onChanged: (val) {
            _onUpdate(index, val); //откуда взялся VAL?
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    for (FocusNode el in focusStates) {
      el.dispose();
    }
    super.dispose();
  }

  void _onCenterClick([String? text]) async {
    //Если нет активных инпутов, то создаем окно, делаем его активным
    //Учли есть активное окно, то делаем все окна неактивными, удаляем пустые
    //говнокод
    if (_values.length > 0) {
      if (_values.last == "") {
        //мб не быть last
        _delLastEmptyRow();
      } else
        _addRow();
    } else {
      _addRow();
    }
  }

  void _addRow([String? text]) async {
    // почему если void то мы вызываем функцию без скобок??
    // добавить логику: 9 игроков макс, чтобы не перекрывало экран
    // добавить "только вертикальное расположение устройства"
    //TODO говнокод
    //кейс с удалением имени в середине списка
    //async in func declaration broke logic
    setState(() {
      focusStates.add(FocusNode());
      _values.add("");
      focusStates[_values.length - 1].requestFocus();
    });
  }

  void _delLastEmptyRow() {
    setState(() {
      FocusManager.instance.primaryFocus?.unfocus();
      _values.removeLast();
    });
  }

  void _delRow(DismissDirection direction, int key) {
    setState(() {
      _values.removeAt(key);
      FocusManager.instance.primaryFocus?.unfocus();
    });
  }

  @override
  _onUpdate(int key, String val) {
    _values[key] = val;
  }

  bool _canStartGame() =>
      _values.length >= 3 && _values.last != "" ? true : false;
}

class StartButton extends StatelessWidget {
  final BorderRadiusGeometry? borderRadius;
  final double? width;
  final double height;
  final Gradient gradient;
  final VoidCallback? onPressed;
  final Widget child;

  const StartButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.width,
    this.height = 44.0,
    this.borderRadius,
    this.gradient = const LinearGradient(
        colors: [Color.fromARGB(255, 88, 100, 101), Colors.indigo]),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(15);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: borderRadius,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        // style: ButtonStyle(
        //     backgroundColor: MaterialStateProperty.all(Colors.transparent),
        //     //padding: MaterialStateProperty.all(EdgeInsets.all(50)),

        //     textStyle: MaterialStateProperty.all(
        //         TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
        child: child,
      ),
    );
  }
}
