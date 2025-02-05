import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guia_de_moteis/models/suite_model.dart';
import 'package:guia_de_moteis/widgets/suite_grid.dart';
import 'package:guia_de_moteis/utils/size_config.dart';

void main() {
  group('SuiteGrid', () {
    testWidgets('should render grid with suites', (WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue = Size(1080, 1920);
      tester.binding.window.devicePixelRatioTestValue = 1.0;

      final suites = [
        SuiteModel(
          nome: 'Suite Test',
          qtd: 1,
          exibirQtdDisponiveis: true,
          fotos: ['test.jpg'],
          itens: [],
          categoriaItens: [],
          periodos: [
            PeriodoModel(
              tempoFormatado: '2h',
              tempo: '2:00',
              valor: 100.0,
              valorTotal: 100.0,
              temCortesia: false,
            ),
          ],
        ),
      ];

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Builder(
              builder: (context) {
                SizeConfig.init(context);
                return Scaffold(
                  body: SuiteGrid(suites: suites),
                );
              },
            ),
          ),
        ),
      );

      await tester.pump();

      expect(find.text('Suite Test'), findsOneWidget);
      expect(find.text('1 disponível'), findsOneWidget);
      expect(find.text('A partir de R\$ 100.00'), findsOneWidget);
    });
  });
} 