import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:trainee_task/src/user.dart';
import 'package:trainee_task/src/user_parser.dart';

class ListPage extends StatelessWidget {
  ListPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('List of users')),
      child: FutureBuilder<List<User>>(
        future: fetchUsers(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError)
            Center(
                child: Column(
              children: <Widget>[
                Icon(Icons.error_outline),
                Text('Не удалось загрузить информацию ;(')
              ],
            ));
          return snapshot.hasData
              ? UserList(users: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class UserList extends StatefulWidget {
  final List<User> users;

  UserList({Key key, this.users}) : super(key: key);

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList>
    with SingleTickerProviderStateMixin {
  double _height;
  double _popHeight;
  double _elevate;
  double _popElevate;
  ShapeBorder _borderRadius;
  ShapeBorder _popBorderRadius;

  int _popUpCardIndx;

  AnimationController controller;

  @override
  void initState() {
    _height = 65;
    _popHeight = 100;

    _elevate = 1;
    _popElevate = 6;

    _borderRadius =
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15));
    _popBorderRadius =
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(5));

    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.users.length,
      itemBuilder: (context, index) {
        return fancyListCard(user: widget.users[index], index: index);
      },
    );
  }

  fancyListCard({User user, int index}) {
    return GestureDetector(
      child: AnimatedContainer(
        padding: EdgeInsets.symmetric(horizontal: 7),
        curve: Curves.easeIn,
        duration: Duration(milliseconds: 200),
        height: _popUpCardIndx == index ? _popHeight : _height,
        child: Card(
          shape: _popUpCardIndx == index ? _popBorderRadius : _borderRadius,
          elevation: _popUpCardIndx == index ? _popElevate : _elevate,
          child: Row(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Icon(Icons.person_outline, size: 45)),
              itemInfo(user, index)
            ],
          ),
        ),
      ),
      onTapDown: (_) {
        setState(() {
          _popUpCardIndx == index
              ? _popUpCardIndx = null
              : _popUpCardIndx = index;
        });
      },
    );
  }

  itemInfo(User user, int index) {
    return _popUpCardIndx == index
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                user.name,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              Text(
                user.email,
                style: TextStyle(
                  color: CupertinoColors.inactiveGray,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Text(
                user.company,
                style: TextStyle(fontWeight: FontWeight.w300),
              )
            ],
          )
        : Center(
            child: Text(
              user.name,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
          );
  }
}
