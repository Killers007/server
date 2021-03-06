import 'package:hello/pages/state_management/navigation/fragments.dart';
import 'package:hello/pages/state_management/navigation/screens.dart';
import 'package:flutter/material.dart';

import 'package:hello/pages/state_management/_bloc_lib/app.dart';
import 'package:hello/pages/state_management/_inherited_model/app.dart';
// import 'package:hello/pages/state_management/_inherited_widget/app.dart';
// import 'package:hello/pages/state_management/_mobx/app.dart';
// import 'package:hello/pages/state_management/_provider/app.dart';
// import 'package:hello/pages/state_management/_redux/app.dart';
// import 'package:hello/pages/state_management/_scoped_model/app.dart';
// import 'package:hello/pages/state_management/_stateful_widget/app.dart';

class StateManagement extends StatelessWidget {
  const StateManagement({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class DrawerItem {
  String title;
  IconData icon;
  Function body;
  DrawerItem(this.title, this.icon, this.body);
}

class MyHomePage extends StatefulWidget {
  final drawerFragments = [
    new DrawerItem("Bloc Lib", Icons.rss_feed, () => new BlocLib()),
    new DrawerItem("Fragment 2", Icons.local_pizza, () => new SecondFragment()),
    new DrawerItem("Fragment 3", Icons.info, () => new ThirdFragment())
  ];

  final drawerScreens = [
    new DrawerItem("Counter", Icons.add_circle, () => new FirstScreen()),
    new DrawerItem("Screen 2", Icons.airport_shuttle, () => new SecondScreen()),
    new DrawerItem("Screen 3", Icons.all_inclusive, () => new ThirdScreen())
  ];

  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedDrawerFragmentIndex = 0;

  _getDrawerFragmentWidgetIndex(int pos) {
    if (widget.drawerFragments[pos] != null) {
      return widget.drawerFragments[pos].body();
    } else {
      return new Text("Error");
    }
  }

  _onSelectFragment(int index) {
    setState(() => _selectedDrawerFragmentIndex = index);
    Navigator.of(context).pop();
  }

  _onSelectScreen(int index) {
    if (widget.drawerScreens[index] != null) {
      Navigator.of(context).pop(); // close drawer
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  widget.drawerScreens[index].body()));
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> drawerOptions = [];

    for (var i = 0; i < widget.drawerFragments.length; i++) {
      var d = widget.drawerFragments[i];
      drawerOptions.add(new ListTile(
        leading: new Icon(d.icon),
        title: new Text(d.title),
        selected: i == _selectedDrawerFragmentIndex,
        onTap: () => _onSelectFragment(i),
      ));
    }

    for (var i = 0; i < widget.drawerScreens.length; i++) {
      var d = widget.drawerScreens[i];
      drawerOptions.add(new ListTile(
        leading: new Icon(d.icon),
        title: new Text(d.title),
        onTap: () => _onSelectScreen(i),
      ));
    }

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
            widget.drawerFragments[_selectedDrawerFragmentIndex].title),
      ),
      drawer: new SizedBox(
        width: MediaQuery.of(context).size.width * 0.80,
        child: new Drawer(
          child: new Column(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                accountName: new Text("John Doe"),
                accountEmail: new Text('ahmadjuhdi007@gmail.com'),
                currentAccountPicture: ClipRRect(
                  borderRadius: BorderRadius.circular(110),
                  child: Image.asset(
                    "assets/show_1.png",
                    fit: BoxFit.cover,
                  ),
                ),
                otherAccountsPictures: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(110),
                    child: Image.asset(
                      "assets/show_1.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(110),
                    child: Image.asset(
                      "assets/show_1.png",
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
              new Column(children: drawerOptions)
            ],
          ),
        ),
      ),
      body: _getDrawerFragmentWidgetIndex(_selectedDrawerFragmentIndex),
    );
  }
}
