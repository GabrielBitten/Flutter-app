import 'package:appflutter/categoria.dart'; 
import 'package:appflutter/my_app.dart';
import 'package:appflutter/projeto.dart';
import 'package:flutter/material.dart';

class ProjectList extends StatefulWidget {
  @override
  ProjectListState createState() => ProjectListState();
}

class ProjectListState extends State<ProjectList> {

  List<Projeto> lista = [
    Projeto(
      titulo: 'Meu Primeiro Projeto',
      descricao: 'Este é o meu primeiro projeto de exemplo.',
      link: 'https://gabrielbitten.github.io/Portfolio/',
      imageUrl: 'https://storage.googleapis.com/website-production/uploads/2023/07/sweetkick-landing-page-example-1.png',
      categoria: ProjectCategory.desenvolvimentoDeJogos,
    ),
  ];

  void adicionarProjeto(Projeto novoProjeto) {
    setState(() {
      lista.add(novoProjeto);
    });
  }

  void removeProject(Projeto projeto) {
    setState(() {
      lista.remove(projeto);
    });
  }

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
            onPressed: () async {
              final Projeto? novoProjeto = await Navigator.of(context).pushNamed(MyApp.PROJECT_FORM) as Projeto?;
              if (novoProjeto != null) {
                adicionarProjeto(novoProjeto);
              }
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
              title: Text(
                projeto.titulo,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(projeto.categoria.name),
              trailing: SizedBox(
                width: 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          MyApp.PROJECT_INFO,
                          arguments: projeto,
                        ).then((_) {
                          setState(() {});
                        });
                      },
                      icon: const Icon(Icons.open_in_new),
                    ),
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Confirmar Exclusão'),
                            content: const Text(
                                'Você tem certeza que deseja excluir este projeto?'),
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
                                  Navigator.of(context).pop();
                                  removeProject(projeto);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                      icon: const Icon(Icons.delete),
                    ),
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
