import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:trainee_task/src/user.dart';

Future<List<User>> fetchUsers(http.Client client) async {
  try {
    final response =
        await client.get('https://jsonplaceholder.typicode.com/users');

    Timer timer = Timer(Duration(seconds: 5), () {
      throw ('error');
    });
    
    return compute(parseUsers, response.body);
  } catch (e) {
    return null;
  }
}

List<User> parseUsers(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<User>((json) => User.fromJson(json)).toList();
}
