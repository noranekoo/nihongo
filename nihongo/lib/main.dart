import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nihongo/components/infobox.dart';
import 'package:nihongo/const.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabcontroller;
  final Connectivity connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectionSubscription;
  @override
  void initState() {
    super.initState();

    _tabcontroller = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabcontroller.dispose();
    _connectionSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: SafeArea(
            child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            ListTile(
              leading: Icon(
                FontAwesomeIcons.language,
                color: Colors.blue,
              ),
              title: Text('Hán Tự'),
              onTap: () {},
            ),
          ],
        )),
      ),
      appBar: AppBar(
        title: TabBar(
          controller: _tabcontroller,
          tabs: tabs,
        ),
        //bottom:
      ),
      body: TabBarView(
        controller: _tabcontroller,
        children: [
          SingleChildScrollView(
              child: Column(
            children: Init().createMina(),
          )),
          SingleChildScrollView(child: Column(children: Init().createLevel())),
          Center(
              child: Column(children: [
            Container(
              height: 5,
            ),
            InfoBox()
          ])),
        ],
      ),
    );
  }
}
