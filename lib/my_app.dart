import 'package:appflutter/projeto.dart';
import 'package:appflutter/view/project_edit.dart';
import 'package:appflutter/view/project_form.dart';
import 'package:appflutter/view/project_info.dart';
import 'package:flutter/material.dart';
import 'view/project_list.dart';

class MyApp extends StatelessWidget {
  static const HOME = '/';
  static const PROJECT_FORM = '/project_form';
  static const PROJECT_INFO = '/project_info';
  static const PROJECT_EDIT = '/project_edit';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        HOME: (context) => ProjectList(),
        PROJECT_EDIT: (context) => ProjectEdit(),
        PROJECT_FORM: (context) => ProjectForm(),
        PROJECT_INFO: (context) => ProjectInfo(
              onDelete: (Projeto projeto) {
                final projectListState =
                    context.findAncestorStateOfType<ProjectListState>();
                projectListState?.removeProject(projeto);
              },
            ),
      },
      initialRoute: HOME,
    );
  }
}
