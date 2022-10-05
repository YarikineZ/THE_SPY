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
    return Scaffold(
        appBar: AppBar(
          title: Text("ШПИОН"), //обернууть в геншн и мидл клик
          leading: SizedBox(
            child: Row(
              children: [
                IconButton(
                    //required: () {_values.length>0},
                    enableFeedback: true,
                    onPressed: () {
                      Navigator.pushNamed(context, '/rules');
                    },
                    icon: Icon(Icons.help))
              ],
            ),
          ),
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
                icon: Icon(Icons.start)),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(20.0),
          child: Stack(
            alignment: AlignmentDirectional.topStart,
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                  //TODO как сделать так чтобы был на полный экран? Не было button overloaded?
                  onTap: _onCenterClick,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Container(
                          alignment: AlignmentDirectional.bottomCenter,
                          color: Colors.transparent,
                        ),
                      ),
                      Container(
                        //Зафиксировать внизу чтобы не скакал с клавиатурой
                        padding: const EdgeInsets.fromLTRB(30, 0, 0, 30),
                        decoration: BoxDecoration(color: Colors.transparent),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.add_circle,
                              size: 30.0,
                            ),
                            Text(
                              "  Игроки",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0),
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _values.length,
                itemBuilder: (context, index) => _row(index),
              ),
            ],
          ),
        ));
  }

//Почему мы не добавляем возвращаемый функцией тип?
  _row(int index) {
    return Dismissible(
      background: Container(
        color: Colors.red,
        alignment: AlignmentDirectional.centerEnd,
        child: Padding(
          padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
      //ПРОБЛЕМА В KEY
      key: Key(_values[index]),
      direction: DismissDirection.endToStart,
      //onDismissed: _delRow(direction, key),
      onDismissed: (direction) {
        _delRow(direction, index);
      },
      child: Row(
        children: [
          Text('$index'),
          SizedBox(
            width: 30.0,
          ),
          Expanded(
              child: TextFormField(
            textCapitalization: TextCapitalization.characters,
            initialValue: _values[index],
            focusNode: focusStates[index],
            onFieldSubmitted: _onCenterClick,
            onChanged: (val) {
              _onUpdate(index, val); //откуда взялся VAL?
            },
          )),
        ],
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
    //print("values: $_values, ${_values.length}");
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
      print("values: $_values");
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
