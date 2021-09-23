import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<FullForms>> fetchFullForms(http.Client client) async {
  final response = await client
      .get(Uri.parse('https://api.jsonbin.io/b/614c34bdaa02be1d444d3b0c'));
  return compute(parseFullForms, response.body);
}

List<FullForms> parseFullForms(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<FullForms>((json) => FullForms.fromJson(json)).tolist();
}

class FullForms {
  final String shortform;
  final String fullform;

  FullForms({required this.fullform, required this.shortform});

  factory FullForms.fromJson(Map<String, dynamic> json) {
    return FullForms(shortform: json["shortform"], fullform: json["fullform"]);
  }
}
