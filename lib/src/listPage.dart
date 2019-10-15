import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

Future<List<User>> fetchUsers(http.Client client) async {
  final response =
      await client.get('https://jsonplaceholder.typicode.com/users');
  return compute(parseUsers, response.body);
}

List<User> parseUsers(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<User>((json) => User.fromJson(json)).toList();
}

class User {
  final int id;
  final String name;
  final String email;
  final String city;
  final String street;
  final String phone;
  final String company;

  User(
      {this.city,
      this.company,
      this.email,
      this.id,
      this.name,
      this.phone,
      this.street});

  factory User.fromJson(Map<String, dynamic> json) => User(
        city: json['address']['city'] as String,
        company: json['company']['name'] as String,
        email: json['email'] as String,
        id: json['id'] as int,
        name: json['name'] as String,
        phone: json['phone'] as String,
        street: json['address']['street'] as String,
      );
}

class ListPage extends StatelessWidget {
  ListPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('List of users')),
      child: FutureBuilder<List<User>>(
        future: fetchUsers(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? UserList(users: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class UserList extends StatelessWidget {
  final List<User> users;

  UserList({Key key, this.users}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        return fancyListCard(user: users[index]);
      },
    );
  }

  fancyListCard({User user}) {
    return Container(
      height: 60,
      child: Card(elevation: 2, child: Text(user.name)),
    );
  }
}
