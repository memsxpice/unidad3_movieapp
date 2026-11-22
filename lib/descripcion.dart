import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:movie_app/login.dart';
import 'package:movie_app/home.dart';
import 'package:movie_app/administracion.dart';


class DescPage extends StatefulWidget {
  const DescPage({ super.key, required this.descripcion});

  final String descripcion;

  @override
  State<DescPage> createState() => _DescPageState();

}

class _DescPageState extends State<DescPage> {
  
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Acción específica según el ítem presionado
    switch (index) {
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (context)=> AdminPage()));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginPage()));
        break;
    }
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(

        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(60, 150, 112, 1),
          iconTheme: IconThemeData(color: Colors.white),
          title: const Text(
            'MemoFlix', 
            style: TextStyle(color: Colors.white),
          ),
        ),

        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("./assets/images/BG_IMG.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text('Catalogo de MemoFlix!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 189, 241, 226).withValues(alpha: 0.8),
                    height: 5, fontSize: 30
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: 
                        GridView.count(
                            primary: false,
                            padding: const EdgeInsets.all(20),
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            crossAxisCount: 2,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  developer.log('click aqui 1');
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  color: Colors.teal[200],
                                  child: Text(widget.descripcion),
                                  )), 
                            ],
                      ),  
                    ),
                  ],
                )
              )
            ]
          )
        ), 

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed, 
          selectedItemColor: Color.fromRGBO(60, 150, 112, 1),
          items: const[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Inicio',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.search),
            //   label: 'Buscar',
            // ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              label: 'Configuracion',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.exit_to_app),
              label: 'Salir',
            ),
          ],
        ),

        // drawer: Drawer(
        //   child: Text('Hello'),
        // ),
        drawer: Drawer(
          child: Text ('hola :v')
        )
      )
    );
  }
}

