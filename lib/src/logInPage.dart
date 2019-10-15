import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trainee_task/src/widgets/logInCard.dart';
import 'package:trainee_task/src/listPage.dart';

void main() => runApp(MyApp());
//void main() => runApp(());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trainee Task',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        primaryColor: Colors.lightBlue[700],
        accentColor: Colors.lightBlue[500],
      ),
      home: LogInPage(
          backgroundImage:
              Image.asset('assets/background_mountain.jpg', fit: BoxFit.cover)),
    );
  }
}

class LogInPage extends StatelessWidget {
  final Image backgroundImage;
  LogInPage({Key key, this.backgroundImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          backgroundImage,
          Positioned(
            bottom: 10,
            top: 120,
            left: 30,
            right: 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(left: 5, bottom: 15),
                    child: Text(
                      'Вход',
                      style: TextStyle(fontSize: 35.0, color: Colors.white),
                    )),
                LogInCard(onButtonPress: ListPage()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
