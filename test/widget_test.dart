import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:appflutter/projeto_service.dart';
import 'package:appflutter/view/project_list.dart';


void main() {
  testWidgets('Deve exibir o botão de adicionar projeto na AppBar', (WidgetTester tester) async {

    final projetoService = ProjetoService('http://localhost:3000');

    await tester.pumpWidget(
      MaterialApp(
        home: ProjectList(projetoService: projetoService),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.add), findsOneWidget);
  });
}
