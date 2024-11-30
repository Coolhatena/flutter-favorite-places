import 'dart:convert';

import 'package:flutter/services.dart';

class Envs {
  static Future<Map<String, dynamic>> getEnvs() async {
    String jsonString = await rootBundle.loadString('assets/env.json');
    return jsonDecode(jsonString);
  }
}
