import 'dart:async';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nihongo/info.dart';

class KotobaScreen extends StatefulWidget {
  KotobaScreen({Key? key, this.id, this.title}) : super(key: key);

  _KotobaScreenState createState() => _KotobaScreenState();

  final String? id;
  final Widget? title;
}

class _KotobaScreenState extends State<KotobaScreen> {
  final Connectivity connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectionSubscription;

  late Future<List<Kotoba>> kotoba;

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

  Future<List<Kotoba>> getKotoba() async {
    List<Kotoba> lsKotoba = [];
    ConnectivityResult result = await check();
    var url = "mina.mazii.net";
    if (result == ConnectivityResult.none) return [];

    var response = await http.get(
        Uri.https(url, '/api/getKotoba.php', {'lessonid': '${widget.id}'}));
    if (response.statusCode == 200) {
      //print(response.body);
      var data = convert.jsonDecode(response.body);
      for (var i = 0; i < data.length; i++) {
        lsKotoba.add(Kotoba(
            data[i]['cn_mean'],
            data[i]['favorite'],
            data[i]['hiragana'],
            data[i]['id'],
            data[i]['kanji'],
            data[i]['kanji_id'],
            data[i]['lesson_id'],
            data[i]['mean'],
            data[i]['mean_unsigned'],
            data[i]['roumaji'],
            data[i]['tag']));
      }
      return lsKotoba;
    } else {
      throw new Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    kotoba = getKotoba();
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
    _connectionSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: widget.title,
        ),
      ),
      body: FutureBuilder(
        future: kotoba,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<Kotoba> data = snapshot.data;
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
                              Text(
                                data[index].hiragana,
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 20),
                              ),
                              Text(
                                '   ' + data[index].kanji,
                                style: TextStyle(
                                    color: Colors.deepPurple, fontSize: 20),
                              ),
                              Text(
                                '   ' + data[index].cn_mean,
                                style: TextStyle(
                                    color: Colors.deepOrange, fontSize: 20),
                                textAlign: TextAlign.left,
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  data[index].mean,
                                  style: TextStyle(fontSize: 24),
                                ),
                              )
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
              child: CircularProgressIndicator(
            backgroundColor: Colors.blue,
          ));
        },
      ),
    );
  }
}
