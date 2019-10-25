import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:trainee_task/src/widgets/log_in_card.dart';
import 'package:trainee_task/src/list_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Trainee Task',
      theme: CupertinoThemeData(
        barBackgroundColor: CupertinoColors.white,
        primaryColor: CupertinoColors.activeBlue,
        scaffoldBackgroundColor: CupertinoColors.extraLightBackgroundGray,
      ),
      home: LogInPage(
          backgroundImage:
              Image.asset('assets/background_mountain.jpg', fit: BoxFit.cover)),
    );
  }
}

class LogInPage extends StatefulWidget {
  LogInPage({Key key, this.backgroundImage}) : super(key: key);

  final Image backgroundImage;

  final double bottom = 180;
  final double bottomWithInset = 10;

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  bool keyBoardOn = false;
  double keyBoardInset = 0;

  @override
  Widget build(BuildContext context) {
    _checkKeyBoard(context);
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          widget.backgroundImage,
          AnimatedContainer(
            curve: Curves.easeIn,
            duration: Duration(milliseconds: 1000),
            child: Positioned(
              bottom: keyBoardOn
                  ? keyBoardInset + widget.bottomWithInset
                  : widget.bottom,
              left: 25,
              right: 25,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 5, bottom: 25),
                    child: Opacity(
                      opacity:
                          keyBoardOn ? 0 : 1,
                      child: Text(
                        'Вход',
                        style: TextStyle(fontSize: 35.0, color: Colors.white),
                      ),
                    ),
                  ),
                  LogInCard(onButtonPress: ListPage()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _checkKeyBoard(BuildContext context) {
    keyBoardInset = MediaQuery.of(context).viewInsets.bottom;
    setState(() {
      if (keyBoardInset > 0)
        keyBoardOn = true;
      else
        keyBoardOn = false;
    });
  }
}
