import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:trainee_task/src/user.dart';
import 'package:trainee_task/src/user_parser.dart';
import 'package:trainee_task/src/widgets/user_list.dart';

class ListPage extends StatelessWidget {
  ListPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(middle: Text('Пользователи')),
        child: FutureBuilder<List<User>>(
          future: fetchUsers(http.Client()),
          //todo не получить "корректное" состояние ошибки
          builder: (context, snapshot) {
            if (snapshot.hasError)
              Center(
                child: Column(
                  children: <Widget>[
                    Icon(Icons.error_outline),
                    Text('Не удалось загрузить информацию ;(')
                  ],
                ),
              );
            return snapshot.hasData
                ? UserList(users: snapshot.data)
                : Center(child: CircularProgressIndicator());
          },
        ),
      );
}
