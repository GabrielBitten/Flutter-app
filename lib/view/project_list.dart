import 'package:appflutter/categoria.dart';
import 'package:appflutter/my_app.dart';
import 'package:appflutter/projeto.dart';
import 'package:flutter/material.dart';

class ProjectList extends StatefulWidget {
  @override
  ProjectListState createState() => ProjectListState();
}

class ProjectListState extends State<ProjectList> {
  List<Projeto> lista = [];

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
void editarProjeto(Projeto projeto, Projeto novoProjeto) {
  setState(() {
    final index = lista.indexOf(projeto);
    if (index != -1) {
      lista[index] = novoProjeto; // Atualiza o projeto existente
    }
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
              final Projeto? novoProjeto = await Navigator.of(context)
                  .pushNamed(MyApp.PROJECT_FORM) as Projeto?;
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
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              subtitle: Row(
                children: [
                  Expanded(
                    child: Text(
                      projeto.categoria.name,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              trailing: SizedBox(
                width: 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(
                          MyApp.PROJECT_INFO,
                          arguments: projeto,
                        )
                            .then((_) {
                          setState(() {});
                        });
                      },
                      icon: const Icon(Icons.open_in_new),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(MyApp.PROJECT_EDIT, arguments: projeto)
                            .then((novoProjeto) {
                          if (novoProjeto is Projeto) {
                            editarProjeto(projeto,
                                novoProjeto); 
                          }
                        });
                      },
                      icon: const Icon(Icons.edit),
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
