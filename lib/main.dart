import 'package:flutter/material.dart';
// 导入widget

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter_router',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/firstPage': (context) => new FistPage(),
        '/secondPage': (context) => new SecondPage(),
      },
      home: FistPage(),
    );
  }
}

class FistPage extends StatelessWidget {

  final String args;
  FistPage({this.args = '没参数'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FistPage'),
      ),
      body: Column(
        children: <Widget>[
          Text('是否有参数： ${this.args}'),
          Center(
            child: FlatButton(
              color: Colors.deepOrange,
              textColor: Colors.white,
              child: Text('带参路由 -> 去SecondPage'),
              onPressed: () {
                Navigator.push(context, 
                  new MaterialPageRoute(builder: (context) => new SecondPage(args: '来自FistPage的参数'))
                );
              },
            )
          )
        ]
      )
    );
  }
}

class SecondPage extends StatelessWidget{

  final String args;
  SecondPage({this.args = '没参数'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SecondPage'),
      ),
      body: Column(
        children: <Widget>[
          Text('是否有参数： ${this.args}'),
          Center(
            child: FlatButton(
              color: Colors.pink,
              textColor: Colors.white,
              child: Text('带参路由 -> 去FistPage'),
              onPressed: () {
                Navigator.push(context, 
                  new MaterialPageRoute(builder: (context) => new FistPage(args: '来自SecondPage的参数'))
                );
              },
            )
          )
        ],
      )
    );
  }
}