import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class User {
  String id;
  String name;
  String password;
  String address;
  String mail;

  User({
    required this.id,
    required this.password,
    required this.name,
    required this.address,
    required this.mail,
  });
}
