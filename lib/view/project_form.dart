import 'package:appflutter/categoria.dart';
import 'package:appflutter/projeto.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProjectForm extends StatefulWidget {
  final String apiUrl; 
  ProjectForm({required this.apiUrl}); 

  @override
  _ProjectFormState createState() => _ProjectFormState();
}

class _ProjectFormState extends State<ProjectForm> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final linkController = TextEditingController();
  ProjectCategory? selectedCategory = ProjectCategory.desenvolvimentoWeb;
  XFile? _imageFile;

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    linkController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = image;
    });
  }

  Future<void> _saveProject() async {
    final novoProjeto = Projeto(
      titulo: nameController.text,
      descricao: descriptionController.text,
      link: linkController.text,
      imageUrl: _imageFile?.path ?? '',
      categoria: selectedCategory!,
    );

    final response = await http.post(
      Uri.parse('${widget.apiUrl}/projetos'), // Usando o endpoint fornecido
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(novoProjeto.toMap()),
    );

    if (response.statusCode == 201) {
      Navigator.of(context).pop(novoProjeto);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar o projeto.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Projeto'),
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
        child: ListView(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Nome do Projeto',
                labelStyle: TextStyle(
                  fontSize: 20,
                ),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<ProjectCategory>(
              value: selectedCategory,
              decoration: const InputDecoration(
                labelText: 'Categoria do Projeto',
                labelStyle: TextStyle(
                  fontSize: 20,
                ),
                border: OutlineInputBorder(),
              ),
              items: ProjectCategory.values.map((ProjectCategory category) {
                return DropdownMenuItem<ProjectCategory>(
                  value: category,
                  child: Text(_categoryToString(category)),
                );
              }).toList(),
              onChanged: (ProjectCategory? newValue) {
                setState(() {
                  selectedCategory = newValue;
                });
              },
            ),
            const SizedBox(height: 20),
            TextField(
              controller: linkController,
              decoration: const InputDecoration(
                labelText: 'Link do Projeto',
                labelStyle: TextStyle(
                  fontSize: 20,
                ),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'Descrição do Projeto',
                labelStyle: TextStyle(
                  fontSize: 20,
                ),
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Escolher Imagem'),
            ),
            const SizedBox(height: 20),
            _imageFile != null
                ? SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.file(
                      File(_imageFile!.path),
                      fit: BoxFit.cover,
                    ),
                  )
                : const Text('Nenhuma imagem selecionada'),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveProject,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF39D301),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                ),
                child: const Text(
                  'Salvar',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _categoryToString(ProjectCategory category) {
    switch (category) {
      case ProjectCategory.desenvolvimentoWeb:
        return 'Desenvolvimento Web';
      case ProjectCategory.desenvolvimentoMobile:
        return 'Desenvolvimento Mobile';
      case ProjectCategory.cienciaDeDados:
        return 'Ciência de Dados';
      case ProjectCategory.aprendizadoDeMaquina:
        return 'Aprendizado de Máquina';
      case ProjectCategory.desenvolvimentoDeJogos:
        return 'Desenvolvimento de Jogos';
      case ProjectCategory.design:
        return 'Design';
      case ProjectCategory.inteligenciaArtificial:
        return 'Inteligência Artificial';
      case ProjectCategory.estruturaDeDados:
        return 'Estrutura de Dados';
      case ProjectCategory.blockchain:
        return 'Blockchain';
      case ProjectCategory.outros:
        return 'Outros';
      default:
        return '';
    }
  }
}
