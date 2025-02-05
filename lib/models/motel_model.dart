import 'package:guia_de_moteis/models/suite_model.dart';

class MotelModel {
  final String fantasia;
  final String logo;
  final String bairro;
  final double distancia;
  final int qtdFavoritos;
  final double media;
  final int qtdAvaliacoes;
  final List<SuiteModel> suites;

  MotelModel({
    required this.fantasia,
    required this.logo,
    required this.bairro,
    required this.distancia,
    required this.qtdFavoritos,
    required this.media,
    required this.qtdAvaliacoes,
    required this.suites,
  });

  factory MotelModel.fromJson(Map<String, dynamic> json) {
    return MotelModel(
      fantasia: json['fantasia'] ?? '',
      logo: json['logo'] ?? '',
      bairro: json['bairro'] ?? '',
      distancia: (json['distancia'] ?? 0.0).toDouble(),
      qtdFavoritos: json['qtdFavoritos'] ?? 0,
      media: (json['media'] ?? 0.0).toDouble(),
      qtdAvaliacoes: json['qtdAvaliacoes'] ?? 0,
      suites: (json['suites'] as List?)?.map((suite) => SuiteModel.fromJson(suite)).toList() ?? [],
    );
  }
} 