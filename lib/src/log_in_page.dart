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

class LogInPage extends StatelessWidget {
  LogInPage({Key key, this.backgroundImage}) : super(key: key);

  final Image backgroundImage;

  @override
  Widget build(BuildContext context) => CupertinoPageScaffold(
        resizeToAvoidBottomInset: false,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            backgroundImage,
            Positioned(
              bottom: 10,
              top: 70,
              left: 25,
              right: 25,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 5, bottom: 25),
                    child: Text(
                      'Вход',
                      style: TextStyle(fontSize: 35.0, color: Colors.white),
                    ),
                  ),
                  //todo создать "правильный" сдвиг формы входа при появлении клавиатуры
                  LogInCard(onButtonPress: ListPage()),
                ],
              ),
            ),
          ],
        ),
      );
}
