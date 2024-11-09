import 'package:flutter/material.dart';
import 'package:appflutter/view/project_list.dart';
import 'package:appflutter/projeto_service.dart';

class HomeScreen extends StatefulWidget {
  final ProjetoService projetoService;

  HomeScreen({required this.projetoService});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;


  final List<Widget> _screens = [];

  @override
  void initState() {
    super.initState();
    _screens.addAll([
      HomeContent(), 
      ProjectList(projetoService: widget.projetoService), 
    ]);
  }
  void selectedItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      appBar: _selectedIndex == 0
          ? AppBar(
              title: const Text('Portfólio'),
              backgroundColor: const Color(0xFF2196F3),
               titleTextStyle: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
              centerTitle: true,
            )
          : null,
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Projetos',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        onTap: selectedItem,
      ),
    );
  }
}


class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Bem-vindo ao seu Portfólio!',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Text(
            'Cadastre seus projetos e tenha eles na palma da sua mão!',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
