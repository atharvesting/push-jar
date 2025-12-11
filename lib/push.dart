import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'dart:convert';

class Push {
  final int id;
  final String title;
  final DateTime dateTime;
  final List<String> tags;

  const Push({
    required this.id,
    required this.title,
    required this.dateTime,
    required this.tags,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'date_time': dateTime.millisecondsSinceEpoch,
      'tags': jsonEncode(tags),
    };
  }

  factory Push.fromMap(Map<String, dynamic> map) {
    return Push(
      id: map['id'],
      title: map['title'],
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['date_time']),
      tags: List<String>.from(jsonDecode(map['tags'])),
    );
  }
}