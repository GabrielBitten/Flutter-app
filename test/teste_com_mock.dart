import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:appflutter/projeto_service.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late ProjetoService projetoService;
  late MockHttpClient mockHttpClient;

  const baseUrl = 'http://localhost:3000';

  setUp(() {
    mockHttpClient = MockHttpClient();
    projetoService = ProjetoService(baseUrl);
  });

  test('Get Projetos with Mock', () async {
    when(mockHttpClient.get(Uri.parse('$baseUrl/projetos')))
        .thenAnswer((_) async => http.Response(
            json.encode([
              {
                "id": "1",
                "titulo": "Projeto",
                "descricao": "Descrição",
                "link": "http://www.youtube.com",
                "imageUrl": "imagem de teste.png",
                "categoria": "desenvolvimentoWeb"
              },
            ]),
            200));

  
    projetoService.httpClient = mockHttpClient;

    final projetos = await projetoService.getProjetos();


    expect(projetos.length, 1);
    expect(projetos[0].titulo, 'Projeto');
    
  
    verify(mockHttpClient.get(Uri.parse('$baseUrl/projetos'))).called(1);
  });
}
