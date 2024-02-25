import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart'; // Importe isso

import 'package:dti_digital/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Testar a exclusão de um lembrete', (WidgetTester tester) async {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color(0xFF456189),
        systemNavigationBarColor: Colors.white,
      ),
    );
    initializeDateFormatting('pt_BR', null);
    await tester.pumpWidget(

      ChangeNotifierProvider(
        create: (context) => AppState(),
        child: Builder(
          builder: (context) {
            return const DtiDigital();
          },
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Verificar se o botão "Criar Novo Lembrete" está na tela
    expect(find.text('29'), findsOneWidget);
    //expect(find.byType(OutlinedButton), findsOneWidget);
    await tester.pumpAndSettle();

    // Selecionar dia 29
    await tester.tap(find.text('29'));
    await tester.pumpAndSettle();

    // excluir
    await tester.tap(find.byIcon(Icons.close));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Sim'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Ok'));
    await tester.pumpAndSettle();


  });
}
