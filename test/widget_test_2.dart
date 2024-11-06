import 'package:appflutter/categoria.dart';
import 'package:appflutter/view/project_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Deve preencher e enviar o formulário de cadastro de projeto', (WidgetTester tester) async {

    const apiUrl = 'http://localhost:3000';
    
 
    await tester.pumpWidget(
      MaterialApp(
        home: ProjectForm(apiUrl: apiUrl),
      ),
    );

    await tester.pumpAndSettle();

   
    expect(find.byType(TextField), findsNWidgets(3));  
    expect(find.byType(DropdownButtonFormField<ProjectCategory>), findsOneWidget);  
    expect(find.byType(ElevatedButton), findsNWidgets(2));  


    await tester.enterText(find.bySemanticsLabel('Nome do Projeto'), 'Projeto Teste');
    await tester.enterText(find.bySemanticsLabel('Link do Projeto'), 'http://www.youtube.com.');
    await tester.enterText(find.bySemanticsLabel('Descrição do Projeto'), 'Descrição');

   
    await tester.tap(find.byType(DropdownButtonFormField<ProjectCategory>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Desenvolvimento Web').last); 
    await tester.pumpAndSettle();
 
    expect(find.text('Desenvolvimento Web'), findsOneWidget);

    await tester.tap(find.text('Escolher Imagem'));
    await tester.pumpAndSettle();

    expect(find.text('Salvar'), findsOneWidget);

    await tester.tap(find.text('Salvar'));
    await tester.pumpAndSettle();
  });
}
