import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/motel_model.dart';

class MotelService {
  Future<MotelModel?> getMotelDetails() async {
    try {
      final String jsonString = await rootBundle.loadString('assets/json/info_moteis.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      
      if (jsonData['sucesso'] == true && 
          jsonData['data'] != null && 
          jsonData['data']['moteis'] != null && 
          jsonData['data']['moteis'].isNotEmpty) {
        return MotelModel.fromJson(jsonData['data']['moteis'][0]);
      }
      return null;
    } catch (e) {
      return null;
    }
  }
} 