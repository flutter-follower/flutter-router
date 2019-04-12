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
      // 命名路由配置表
      routes: {
        '/firstPage': (context) => new FistPage(),
        '/secondPage': (context) => new SecondPage(),
      },
      home: FistPage(),
    );
  }
}

// Flutter的路由回退默认是保持状态的
// 所以需要 replace 和 remove等

class FistPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // 一个popup
    _doCallbackPopup (args) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(args)
          );
        }
      );
    }
    
    return Scaffold(
      appBar: AppBar(
        title: Text('FistPage'),
      ),
      body: Column(
        children: <Widget>[
          Text('各种路由跳转', style: TextStyle(fontSize: 22)),
          Center(
            child: FlatButton(
              color: Colors.deepOrange,
              textColor: Colors.white,
              child: Text('带参路由 -> 去SecondPage'),
              onPressed: () {
                Navigator.push(context, 
                  new MaterialPageRoute(
                    // 手动路由：可以传参
                    builder: (context) => new SecondPage(args: '来自FistPage的参数')
                  )
                );
              },
            )
          ),
          Center(
            child: FlatButton(
              color: Colors.deepOrange,
              textColor: Colors.white,
              child: Text('命名路由 -> /secondPage'),
              onPressed: () {
                // 命名路由：不能传参 ？ arguments是什么？ 怎么接？
                Navigator.pushNamed(context, '/secondPage',
                  arguments: '命名路由的参数');
              },
            )
          ),
          Center(
            child: FlatButton(
              color: Colors.deepOrange,
              textColor: Colors.white,
              child: Text('跳转 -> 监听回调'),
              onPressed: () {
                // Navigator都是Future对象
                Navigator.pushNamed(context, '/secondPage')
                  .then((res) { // 路由pop后的回调函数
                    _doCallbackPopup(res);
                  });
              },
            )
          ),
          Text('各种路由动画', style: TextStyle(fontSize: 22)),
          Center(
            child: FlatButton(
              color: Colors.deepOrange,
              textColor: Colors.white,
              child: Text('Slide路由动画'),
              onPressed: () {
                Navigator.push(context,
                  // 启用动画路由，在回退时也有效
                  PageRouteBuilder(
                    transitionDuration: Duration(milliseconds: 500), //动画时间为500毫秒
                    pageBuilder: (context, animation, secondaryAnimation) {
                        return new SlideTransition( // 移动动画
                          textDirection: TextDirection.ltr,
                          position: Tween(
                            begin: Offset(1.0, 1.0), // 1.0表示100%宽/高
                            end: Offset.zero
                          ).animate(animation),
                          child: SecondPage()
                        );
                      }
                  )
                );
              },
            )
          ),
          Center(
            child: FlatButton(
              color: Colors.deepOrange,
              textColor: Colors.white,
              child: Text('Scale路由动画'),
              onPressed: () {
                Navigator.push(context,
                  // 启用动画路由，在回退时也有效
                  PageRouteBuilder(
                    transitionDuration: Duration(milliseconds: 500), //动画时间为500毫秒
                    pageBuilder: (context, animation, secondaryAnimation) {
                        return new ScaleTransition( // 移动动画
                          scale: animation,
                          child: SecondPage()
                        );
                      }
                  )
                );
              },
            )
          ),
          Center(
            child: FlatButton(
              color: Colors.deepOrange,
              textColor: Colors.white,
              child: Text('Fade路由动画'),
              onPressed: () {
                Navigator.push(context,
                  // 启用动画路由，在回退时也有效
                  PageRouteBuilder(
                    transitionDuration: Duration(milliseconds: 500), //动画时间为500毫秒
                    pageBuilder: (context, animation, secondaryAnimation) {
                        return new FadeTransition( // 移动动画
                          opacity: animation,
                          child: SecondPage()
                        );
                      }
                  )
                );
              },
            )
          ),
          Center(
            child: FlatButton(
              color: Colors.deepOrange,
              textColor: Colors.white,
              child: Hero(
                tag: 'zmz',
                child: Text('默认Hero动画路由'),
              ),
              onPressed: () {
                Navigator.push(context,
                  // 启用动画路由，在回退时也有效
                  PageRouteBuilder(
                    transitionDuration: Duration(milliseconds: 500), //动画时间为500毫秒
                    pageBuilder: (context, animation, secondaryAnimation) {
                        return new FadeTransition( // 移动动画
                          opacity: animation,
                          child: ThirdPage()
                        );
                      }
                  )
                );
              },
            )
          ),
          MyLoadingDialog(text: '疯狂输出',)
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
          Text('${this.args}', style: TextStyle(fontSize: 22)),
          Center(
            child: FlatButton(
              color: Colors.pink,
              textColor: Colors.white,
              child: Text('回退'),
              onPressed: () {
                // 路由回退操作
                Navigator.pop(context, '来自回退的参数');
              },
            )
          )
        ],
      )
    );
  }
}

class ThirdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ThirdPage'),
      ),
      body: Hero(
        tag: 'zmz',
        child: Center(
          child: Text('这里是ThirdPage'),
        )
      )
    );
  }
}

class MyLoadingDialog extends Dialog {

  final String text;
  MyLoadingDialog({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Material( //创建透明层
      type: MaterialType.transparency, //透明类型
      child: new Center( //保证控件居中效果
        child: new Container(
          width: 120.0,
          height: 120.0,
          decoration: ShapeDecoration(
            color: Color(0xffffffff),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
          ),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new CircularProgressIndicator(), // 圆形指示符
              new Padding(
                padding: const EdgeInsets.only(top: 20.0,),
                child: new Text(text),
              ),
            ],
          ),
        ),
      ),
    );
  }
}