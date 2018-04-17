import 'package:flutter/material.dart';

void main() => runApp(new TodoApp());

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Todo App',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<String> itemList = [];
  List<bool> itemCheckBoxList = [];
  bool showDialog = false;
  TextEditingController textEditingController = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
            'Todo App'
        ),
        actions: <Widget>[
          new IconButton(
            onPressed: _addTask,
            icon: new Icon(Icons.add),
          ),
          new IconButton(
              onPressed: _removeTask,
              icon: new Icon(Icons.remove),
          ),
        ],
      ),
      body: new Column(
          children: <Widget>[
            showDialog == true?
            new AlertDialog(
              title: new Text('Add task'),
              content: new TextField(
                controller: textEditingController,
                onSubmitted: (String task) {
                    
                },
              ),
              actions: <Widget>[
                new FlatButton(
                    onPressed: () {
                      setState(() {
                         showDialog = false;
                         itemList.add(textEditingController.text);
                         itemCheckBoxList.add(false);
                         textEditingController.clear();
                      });
                    },
                    child: new Text("Ok")
                ),
              ],
            ): new Text(""),
            _listViewBuilder(),
          ],
        ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _addTask() {
    setState(() {
      showDialog = true;
    });
  }

  void _removeTask() {
    setState(() {
      int counter = 0;
      while (counter < itemList.length) {
        if(itemCheckBoxList[counter] == true) {
          itemList.removeAt(counter);
          itemCheckBoxList.removeAt(counter);
          counter = 0;
        }else{
          counter++;
        }
      }
    });
  }

  void _addCheckBoxValue(int index, bool newValue) {
    setState(() {
      itemCheckBoxList[index] = newValue;
    });
  }

  _listViewBuilder() {
    return new Flexible(
      child: new ListView.builder(
        padding: new EdgeInsets.all(8.0),
        itemCount: itemList.length,
        itemBuilder: (BuildContext context, int index) {
          return new Row(
            children: <Widget>[
              new Checkbox(
                  value: itemCheckBoxList[index],
                  onChanged: (bool newValue) {
                    _addCheckBoxValue(index, newValue);
                  },
              ),
              new Text(itemList[index])
            ],
          );
        },
      ),
    );
  }

}
