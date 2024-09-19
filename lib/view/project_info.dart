import 'dart:io';
import 'package:appflutter/my_app.dart';
import 'package:appflutter/projeto.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectInfo extends StatelessWidget {
  final Function(Projeto) onDelete;

  const ProjectInfo({required this.onDelete, super.key});

  @override
  Widget build(BuildContext context) {
    final Projeto projeto =
        ModalRoute.of(context)!.settings.arguments as Projeto;

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
                    onPressed: () async {
                      final projetoEditado = await Navigator.of(context)
                          .pushNamed(MyApp.PROJECT_EDIT, arguments: projeto);
                      if (projetoEditado != null && projetoEditado is Projeto) {
                        // ignore: use_build_context_synchronously
                        
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) =>
                                ProjectInfo(onDelete: onDelete),
                            settings: RouteSettings(arguments: projetoEditado),
                          ),
                        );
                      }
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
               
               
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final url = Uri.parse(projeto.link);

                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  } else {
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Não foi possível abrir o link')),
                    );
                  }
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
