import 'package:flutter_test/flutter_test.dart';
import 'package:guia_de_moteis/models/motel_model.dart';

void main() {
  group('MotelModel', () {
    test('should create a MotelModel from json', () {
      final json = {
        'fantasia': 'Motel Test',
        'logo': 'logo.png',
        'bairro': 'Centro',
        'distancia': 2.5,
        'qtdFavoritos': 10,
        'media': 4.5,
        'qtdAvaliacoes': 100,
        'suites': [],
      };

      final motel = MotelModel.fromJson(json);

      expect(motel.fantasia, 'Motel Test');
      expect(motel.logo, 'logo.png');
      expect(motel.bairro, 'Centro');
      expect(motel.distancia, 2.5);
      expect(motel.qtdFavoritos, 10);
      expect(motel.media, 4.5);
      expect(motel.qtdAvaliacoes, 100);
      expect(motel.suites, isEmpty);
    });

    test('should handle null values in json', () {
      final json = <String, dynamic>{};
      
      final motel = MotelModel.fromJson(json);

      expect(motel.fantasia, '');
      expect(motel.logo, '');
      expect(motel.bairro, '');
      expect(motel.distancia, 0.0);
      expect(motel.qtdFavoritos, 0);
      expect(motel.media, 0.0);
      expect(motel.qtdAvaliacoes, 0);
      expect(motel.suites, isEmpty);
    });
  });
} 