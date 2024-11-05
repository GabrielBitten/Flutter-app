import 'package:appflutter/categoria.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:appflutter/projeto_service.dart';
import 'package:appflutter/projeto.dart';

void main() {
  late ProjetoService projetoService;
  const baseUrl = 'http://localhost:3000'; // Altere para a URL do seu backend

  setUp(() {
    projetoService = ProjetoService(baseUrl);
  });

  group('ProjetoService Tests', () {
    late Projeto projeto;

    setUp(() {
      projeto = Projeto(
        titulo: 'Teste',
        descricao: 'Descrição do projeto teste',
        link: 'http://www.youtube.com',
        imageUrl: 'imagem de teste.png',
        categoria: ProjectCategory.desenvolvimentoWeb,
      );
    });

    test('Post Projeto', () async {
      await projetoService.addProjeto(projeto);
  
      final projetos = await projetoService.getProjetos();
      expect(projetos, isNotEmpty);
    });

    test('Get Projetos', () async {
      final projetos = await projetoService.getProjetos();
      expect(projetos, isA<List<Projeto>>());
    });

    test('Update Projeto', () async {
      await projetoService.addProjeto(projeto);
      projeto.titulo = 'Projeto Atualizado';
      await projetoService.updateProjeto(projeto);
      final updatedProjeto = await projetoService.getProjetos().then((value) => value.firstWhere((p) => p.id == projeto.id));
      expect(updatedProjeto.titulo, 'Projeto Atualizado');
    });

    test('Delete Projeto', () async {
      await projetoService.addProjeto(projeto);
      await projetoService.deleteProjeto(projeto.id);
      final projetos = await projetoService.getProjetos();
      expect(projetos.any((p) => p.id == projeto.id), isFalse);
    });
  });
}
