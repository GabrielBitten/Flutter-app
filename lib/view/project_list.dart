import 'package:appflutter/my_app.dart';
import 'package:appflutter/projeto.dart';
import 'package:appflutter/projeto_service.dart';
import 'package:flutter/material.dart';

class ProjectList extends StatefulWidget {
  final ProjetoService projetoService; 

  const ProjectList({Key? key, required this.projetoService}) : super(key: key);

  @override
  ProjectListState createState() => ProjectListState();
}

class ProjectListState extends State<ProjectList> {
  late Future<List<Projeto>> projetos;

  @override
  void initState() {
    super.initState();
    projetos = widget.projetoService.getProjetos(); 
  }

  void removeProject(Projeto projeto) async {
    try {
      await widget.projetoService.deleteProjeto(projeto.id); 
      setState(() {
        projetos = widget.projetoService.getProjetos();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao excluir projeto: $e')),
      );
    }
  }

  void editarProjeto(Projeto projeto, Projeto novoProjeto) {
    setState(() {
      projetos = widget.projetoService.getProjetos(); 
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
                setState(() {
                  projetos = widget.projetoService.getProjetos();
                });
              }
            },
          )
        ],
      ),
      body: FutureBuilder<List<Projeto>>(
        future: projetos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhum projeto encontrado.'));
          }

          final List<Projeto> projetosList = snapshot.data!;

          return ListView.builder(
            itemCount: projetosList.length,
            itemBuilder: (context, i) {
              var projeto = projetosList[i];
              return Container(
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromARGB(255, 187, 187, 187),
                      width: 1.5),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ListTile(
                  title: Text(
                    projeto.titulo,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
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
                                .pushNamed(MyApp.PROJECT_EDIT,
                                    arguments: projeto)
                                .then((novoProjeto) {
                              if (novoProjeto is Projeto) {
                                editarProjeto(projeto, novoProjeto);
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
          );
        },
      ),
    );
  }
}
