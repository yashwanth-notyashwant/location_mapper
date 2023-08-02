import 'package:flutter/material.dart';
import '../models/user.dart';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Users with ChangeNotifier {
  Future<void> addMethodForUser(User newUser) async {
    final url = Uri.parse(
        'https://settyl-bf80c-default-rtdb.firebaseio.com/USER_LIST_FOR_AUTH.json');
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'id': newUser.id,
          'password': newUser.password,
          'address': newUser.address,
          'name': newUser.name,
          'mail': newUser.mail,
        }),
      );

      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<List> allUserLoaderFromServer(
    String id,
    String password,
  ) async {
    final url = Uri.parse(
        'https://settyl-bf80c-default-rtdb.firebaseio.com/USER_LIST_FOR_AUTH.json');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      var listByServer = [];
      extractedData.forEach(
        (key, value) {
          listByServer.add(
            User(
              password: value['password'],
              id: value['id'],
              address: value['address'],
              name: value['name'],
              mail: value['mail'],
            ),
          );
        },
      );

      bool userFound = listByServer.any(
        (user) => user.id == id && user.password == password,
      );

      if (!userFound) {
        notifyListeners();
        return [listByServer.firstWhere((prod) => prod.id == id), []];
      } else {
        notifyListeners();
        return [
          User(id: '', password: '', address: '', mail: '', name: ''),
          []
        ];
      }
    } catch (error) {
      return [User(id: '', password: '', address: '', mail: '', name: ''), []];
    }
  }
}
