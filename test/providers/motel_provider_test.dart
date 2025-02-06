import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:guia_de_moteis/providers/motel_provider.dart';
import 'motel_provider_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('MotelProvider', () {
    late MockClient mockClient;
    late ProviderContainer container;

    setUp(() {
      mockClient = MockClient();
      container = ProviderContainer(
        overrides: [
          httpClientProvider.overrideWithValue(mockClient),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    test('should return MotelModel when API call is successful', () async {
      when(mockClient.get(any)).thenAnswer((_) async => 
        http.Response(
          '{"sucesso":true,"data":{"moteis":[{"fantasia":"Test","logo":"","bairro":"","distancia":0,"qtdFavoritos":0,"media":0,"qtdAvaliacoes":0,"suites":[]}]}}',
          200
        ));

      final motel = await container.read(motelProvider.future);
      
      expect(motel, isNotNull);
      expect(motel?.fantasia, 'Test');
    });

    test('should throw exception when API call fails', () {
      when(mockClient.get(any)).thenAnswer((_) async => 
        http.Response('Not Found', 404));

      expect(
        container.read(motelProvider.future), 
        throwsA(isA<Exception>())
      );
    });
  });
} 