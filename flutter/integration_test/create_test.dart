import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart'; // Importe isso

import 'package:dti_digital/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Testar a criação de um novo lembrete', (WidgetTester tester) async {
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
    expect(find.text('Criar Novo Lembrete'), findsOneWidget);
    //expect(find.byType(OutlinedButton), findsOneWidget);
    await tester.pumpAndSettle();

    // Mudando para tela de criacao de lembrete
    await tester.tap(find.text('Criar Novo Lembrete'));
    // Aguarde a conclusão das animações
    await tester.pumpAndSettle();


    // Inserindo nome do lembrete
    await tester.enterText(find.byKey(const Key('nome')), "Teste unitário");
    await tester.pumpAndSettle();

    // Clicando em data do lembrete
    await tester.tap(find.text('Data do Lembrete'));
    await tester.pumpAndSettle();

    // Selecionando dia 29
    await tester.tap(find.text('29'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    // Enviando
    await tester.tap(find.text('Criar Lembrete'));
    await tester.pumpAndSettle();


    // Finalizando
    await tester.tap(find.text('Voltar ao Início'));
    await tester.pumpAndSettle();
  });
}
