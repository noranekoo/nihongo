import 'dart:async';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nihongo/info.dart';

class BunpouScreen extends StatefulWidget {
  BunpouScreen({Key? key, @required this.id, this.title}) : super(key: key);
  _BunpouScreenState createState() => _BunpouScreenState();

  final String? id;
  final Widget? title;
}

class _BunpouScreenState extends State<BunpouScreen> {
  final Connectivity connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectionSubscription;

  late Future<List<Bunpou>> bunpou;

  //_KotobaScreenState(id);

  Future<ConnectivityResult> check() async {
    ConnectivityResult result = ConnectivityResult.none;
    try {
      result = await connectivity.checkConnectivity();
    } catch (e) {
      result = ConnectivityResult.none;
    }
    return result;
  }

  Future<List<Bunpou>> getBunpou() async {
    List<Bunpou> lsBunpou = [];
    ConnectivityResult result = await check();
    var url = "mina.mazii.net";
    if (result == ConnectivityResult.none) return [];

    var response = await http.get(
        Uri.https(url, '/api/getGrammar.php', {'lessonid': '${widget.id}'}));
    if (response.statusCode == 200) {
      //print(response.body);
      var data = convert.jsonDecode(response.body);
      for (var i = 0; i < data.length; i++) {
        lsBunpou.add(Bunpou(data[i]['id'], data[i]['name'], data[i]['content'],
            data[i]['lesson_id'], data[i]['favorite']));
      }
      return lsBunpou;
    } else {
      throw new Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    bunpou = getBunpou();

    _connectionSubscription =
        connectivity.onConnectivityChanged.listen((update) async {
      switch (update) {
        case ConnectivityResult.wifi:
        case ConnectivityResult.mobile:
          setState(() {});
          break;
        case ConnectivityResult.none:
          setState(() {});
          break;
        default:
          break;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _connectionSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.title,
      ),
      body: FutureBuilder(
        future: bunpou,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<Bunpou> data = snapshot.data;
            if (data.length == 0)
              return Text(
                  'Không lấy được dữ liệu. Có thể do bạn chưa kết nối internet.');
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Flexible(
                                  child: Text(
                                data[index].name,
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 22),
                              ))
                            ],
                          ),
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  data[index].content,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              Container()
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: Colors.lightBlue,
                    )
                  ],
                );
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
