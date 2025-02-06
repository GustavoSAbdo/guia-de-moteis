import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/motel_model.dart';

final httpClientProvider = Provider<http.Client>((ref) => http.Client());

final motelProvider = FutureProvider<MotelModel?>((ref) async {
  final client = ref.watch(httpClientProvider);
  try {
    final response = await client.get(Uri.parse('https://api.npoint.io/e728bb91e0cd56cc0711'));
    
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      
      if (jsonData['sucesso'] == true && 
          jsonData['data'] != null && 
          jsonData['data']['moteis'] != null && 
          jsonData['data']['moteis'].isNotEmpty) {
        return MotelModel.fromJson(jsonData['data']['moteis'][0]);
      }
    } else {
      throw Exception('Falha na requisição: ${response.statusCode}');
    }
    return null;
  } catch (e) {
    throw Exception('Falha ao carregar dados do motel: $e');
  }
}); 