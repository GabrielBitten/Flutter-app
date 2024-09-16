import 'package:appflutter/my_app.dart';
import 'package:flutter/material.dart';

class ProjectList extends StatelessWidget {
  final List<Map<String, String>> lista = [
    {
      'titulo': 'Meu Primeiro Projeto',
      'descricao': 'Este é o meu primeiro projeto de exemplo.',
      'link': 'https://gabrielbitten.github.io/Portfolio/',
      'imageUrl':
          'https://storage.googleapis.com/website-production/uploads/2023/07/sweetkick-landing-page-example-1.png',
      'categoria': 'ProjectCategory.webDevelopment',
    },
    {
      'titulo': 'Projeto Flutter',
      'descricao':
          'Aplicativo Flutter que desenvolvi Aplicativo Flutter que desenvolvi recentemente Aplicativo Flutter que desenvolvi recentemente Aplicativo Flutter que desenvolvi recentemente.',
      'link': 'https://gabrielbitten.github.io/Portfolio/',
      'imageUrl':
          'https://storage.googleapis.com/website-production/uploads/2023/07/sweetkick-landing-page-example-1.png',
      'categoria': 'ProjectCategory.gameDevelopment',
    },
    {
      'titulo': 'E-commerce Website',
      'descricao': 'Website de e-commerce feito com React e Node.js.',
      'link': 'https://gabrielbitten.github.io/Portfolio/',
      'imageUrl':
          'https://storage.googleapis.com/website-production/uploads/2023/07/sweetkick-landing-page-example-1.png',
      'categoria': 'ProjectCategory.mobileDevelopment'
    },
    {
      'titulo': 'E-commerce Website',
      'descricao': 'Website de e-commerce feito com React e Node.js.',
      'link': 'https://gabrielbitten.github.io/Portfolio/',
      'imageUrl':
          'https://storage.googleapis.com/website-production/uploads/2023/07/sweetkick-landing-page-example-1.png',
      'categoria': 'ProjectCategory.mobileDevelopment'
    },
  ];

  get onPressed => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Projetos'),
        backgroundColor: const Color(0xFF2196F3),
        titleTextStyle: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            iconSize: 35.0,
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).pushNamed(MyApp.PROJECT_FORM);
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: lista.length,
        itemBuilder: (context, i) {
          var projeto = lista[i];
          return Container(
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border: Border.all(
                  color: const Color.fromARGB(255, 187, 187, 187), width: 1.5),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: ListTile(
              title: Text(projeto['titulo']!),
              subtitle: Text(projeto['categoria']!),
              trailing: Container(
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(MyApp.PROJECT_INFO,
                              arguments: projeto);
                        },
                        icon: const Icon(Icons.open_in_new))
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
