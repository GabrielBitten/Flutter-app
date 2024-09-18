import 'dart:io';

import 'package:appflutter/projeto.dart';
import 'package:flutter/material.dart';


class ProjectInfo extends StatelessWidget {
  final Function(Projeto) onDelete;

  const ProjectInfo({required this.onDelete, super.key});

  @override
  Widget build(BuildContext context) {
    final Projeto projeto = ModalRoute.of(context)!.settings.arguments as Projeto;
    

    return Scaffold(
      appBar: AppBar(
        title: const Text('Informações do Projeto'),
        centerTitle: true,
        backgroundColor: const Color(0xFF2196F3),
        titleTextStyle: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.file(
               File(projeto.imageUrl),
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            Text(
              projeto.titulo,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              projeto.descricao,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 10),
            Text(
              'Categoria: ${projeto.categoria.name}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Ação de editar o projeto
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text(
                      'Editar',
                      style: TextStyle(
                        fontSize: 24,
                        height: 2,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                       showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Confirmar Exclusão'),
                          content: const Text('Você tem certeza que deseja excluir este projeto?'),
                          actions: [
                            TextButton(
                              child: const Text('Cancelar'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: const Text('Excluir'),
                              onPressed: () {
                                Navigator.of(context).pop(); // Fecha o diálogo
                                onDelete(projeto); // Chama a função de exclusão
                                 
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                          ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF20808),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text(
                      'Excluir',
                      style: TextStyle(
                        fontSize: 24,
                        height: 2,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Ação de acessar o link do projeto
                  
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF39D301),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  'Acessar',
                  style: TextStyle(
                    fontSize: 24,
                    height: 2,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

 
}