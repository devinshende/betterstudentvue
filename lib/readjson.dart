import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

Future<String> _loadFromAsset(filename) async {
  return await rootBundle.loadString("assets/" + filename.toString());
}

Future readJson(filename) async {
  String jsonString = await _loadFromAsset(filename);
  final jsonResponse = jsonDecode(jsonString);
  return jsonResponse;
}
