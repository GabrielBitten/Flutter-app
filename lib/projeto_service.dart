import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:appflutter/projeto.dart';

class ProjetoService {
  final String baseUrl;

  ProjetoService(this.baseUrl);

  Future<List<Projeto>> getProjetos() async {
    final response = await http.get(Uri.parse('$baseUrl/projetos'));
    final List<dynamic> jsonList = json.decode(response.body);
    return jsonList.map((json) => Projeto.fromMap(json)).toList();
  }

  Future<void> addProjeto(Projeto projeto) async {
    await http.post(
      Uri.parse('$baseUrl/projetos'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(projeto.toMap()),
    );
  }

  Future<void> updateProjeto(Projeto projeto) async {
    await http.put(
      Uri.parse('$baseUrl/projetos/${projeto.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(projeto.toMap()),
    );
  }

  Future<void> deleteProjeto(String id) async {
    await http.delete(
      Uri.parse('$baseUrl/projetos/$id'),
    );
  }
}
