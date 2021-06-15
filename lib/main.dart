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

const SUPER_ITEMS = [
  ITEMS_1,
  ITEMS_2,
];

class _MyHomePageState extends State<MyHomePage> {
  int? _selectedIndex;
  int _selectedSuperIndex = 0;

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
            setState(() {
              _selectedSuperIndex = 0;
            });
          },
        ),
        ListTile(
          title: Text('Item 2'),
          onTap: () {
            setState(() {
              _selectedSuperIndex = 1;
            });
          },
        ),
      ],
    );
  }

  Widget _getDetailView() {
    return Center(
        child: Container(
      color: Colors.blue,
      child: Text("Detail", style: TextStyle(fontSize: 72)),
      width: 200,
      height: 200,
    ));
  }

  Widget _getListView(BuildContext context, List<Item> items) {
    Size screenSize = MediaQuery.of(context).size;

    List<Widget> widgets = [];
    for (int i = 0; i < items.length; i++) {
      widgets.add(ListTile(
          title: Text(items[i].title),
          onTap: () {
            setState(() {
              _selectedIndex = i;
              if (screenSize.width <= 500) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Scaffold(body: _getDetailView())));
              }
            });
          }));
    }

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
        child: _getListView(context, ITEMS_1),
      ),
    ];

    if (screenSize.width > 500) {
      bodyChildren.add(
        Expanded(child: _getDetailView()),
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
      appBar: screenSize.width > 800
          ? null
          : AppBar(
              title: Text(widget.title),
            ),
      body: Row(
        children: bodyChildren,
      ),
      drawer: Drawer(child: _getDrawerContents()),
    );
  }
}
