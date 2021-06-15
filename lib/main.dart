import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class Item {
  final String title;
  final String body;
  const Item({required this.title, required this.body});
}

const ITEMS_1 = [
  const Item(title: "Blarh", body: "You know it!"),
  const Item(
      title: "I'm a little teapot",
      body: "Short and predisposed to shattering!"),
];

const ITEMS_2 = [
  const Item(title: "Otherness", body: "Uncanny similarities!"),
  const Item(
      title: "I'm a little dog",
      body: "Short and predisposed to bark bark bark bark!"),
];

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Widget _getDrawerContents() {
    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text('Drawer Header'),
        ),
        ListTile(
          title: Text('Item 1'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text('Item 2'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  Widget _getListView(List<Item> items) {
    List<Widget> widgets = items
        .map((Item i) => ListTile(
              title: Text(i.title),
              onTap: () {
                Navigator.pop(context);
              },
            ))
        .toList();

    return ListView(
      padding: EdgeInsets.zero,
      children: widgets,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    List<Widget> bodyChildren = [
      Expanded(
        child: _getListView(ITEMS_1),
      ),
    ];

    print(screenSize);
    if (screenSize.width > 500) {
      bodyChildren.add(
        Expanded(
          child: Center(
              child: Container(
            color: Colors.blue,
            child: Text("Detail", style: TextStyle(fontSize: 72)),
            width: 200,
            height: 200,
          )),
        ),
      );
    }

    if (screenSize.width > 800) {
      bodyChildren.insert(
          0,
          Container(
            width: 300,
            child: _getDrawerContents(),
          ));
    }

    return Scaffold(
      appBar: screenSize.width > 400
          ? null
          : AppBar(
              title: Text(widget.title),
            ),
      body: Row(
        children: bodyChildren,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
      drawer: Drawer(child: _getDrawerContents()),
    );
  }
}
