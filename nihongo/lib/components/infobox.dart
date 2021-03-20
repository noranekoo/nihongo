import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/*
  @className: InfoBox
  @func: Hiển thị thông tin của App
*/
class InfoBox extends StatelessWidget {
  final String _url = 'https://github.com/anhthi99/nihongo';
  final String _mail =
      'mailto:thi12171999@gmail.com?subject=Bug%20report%20ứng%20dụng%20Học%20Tiếng%20Nhật'; // Trang mã nguồn của dự án
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'HỌC TIẾNG NHẬT',
              style: TextStyle(
                  color: Colors.teal,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Times New Roman'),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Author: ',
              style: TextStyle(color: Colors.purple),
            ),
            Text(
              'Nguyễn Anh Thi',
              style: TextStyle(color: Colors.red, fontSize: 15),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Mã nguồn: '),
            TextButton(onPressed: () => launch(_url), child: Text('Github')),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Bug report: '),
            TextButton(onPressed: () => launch(_mail), child: Text('Gmail')),
          ],
        ),
      ],
    );
  }
}
