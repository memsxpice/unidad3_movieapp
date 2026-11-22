import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:movie_app/login.dart';
import 'package:movie_app/descripcion.dart';
import 'package:movie_app/administracion.dart';


Future<Album> fetchAlbum() async {
  final response = await http.get(
    Uri.parse('https://pokeapi.co/api/v2/pokemon/pikachu'),
    headers: {'Accept': 'application/json'},
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}


class Album {
  final int order;
  final int id;
  final String name;

  const Album({required this.order, required this.id, required this.name});

  factory Album.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'order': int order, 'id': int id, 'name': String name} => Album(
        order: order,
        id: id,
        name: name,
      ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}


class HomePage extends StatefulWidget {
  const HomePage({ super.key });

  @override
  State<HomePage> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
  late Future<Album> futureAlbum;
  
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Acción específica según el ítem presionado
    switch (index) {
      case 0:
        // Ya estas en la pagina de Inicio
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
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
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
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> DescPage(
                                    descripcion: 
                                    'Pokemon: Detective Pikachu. \nDirector: Rob Letterman \nLanzamiento 2019 \nValoracion: 9/10 \nGenero: Animada\n\nSinopsis:  Tim Goodman viaja a Ryme City para investigar la misteriosa desaparición de su padre (Harry Goodman). Allí forma equipo con un peculiar Pikachu parlante, adicto al café y con amnesia, para resolver el caso y destapar una conspiración.'
                                    )));
                                },
                                child: Container(
                                    padding: const EdgeInsets.all(8),
                                    color: Colors.teal[600],
                                    child: FutureBuilder<Album>(
                                      future: futureAlbum,
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Text('Disfruta la nueva pelicula de: ' + snapshot.data!.name, style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30
                                        ),);
                                        } else if (snapshot.hasError) {
                                          return Text('${snapshot.error}');
                                        }
                                        return const CircularProgressIndicator();
                                      },
                                    ),
                                  )
                                ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> DescPage(
                                    descripcion: 
                                    'Avengers: End Game. \nDirector: Anthony Russo \nLanzamiento 2019 \nValoracion: 9/10 \nGenero: Accion\n\nSinopsis:Los Vengadores idean un plan para traer de regreso a sus aliados vencidos para un enfrentamiento épico con Thanos.'
                                    )));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage("./assets/images/avengers.png"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Text('Avengers: End Game', style: TextStyle(
                                      color: const Color.fromARGB(255, 255, 255, 255),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30
                                    ),),
                                  )), 
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> DescPage(
                                    descripcion: 
                                    'El Padrino. \nDirector: Francis Ford Coppola \nLanzamiento 1972 \nValoracion: 9.5/10 \nGenero: Drama\n\nSinopsis: Una familia criminal intenta establecer su supremacía en Estados Unidos tras la Segunda Guerra Mundial.'
                                    )));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage("./assets/images/padrino.png"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Text('El Padrino', style: TextStyle(
                                    color: const Color.fromARGB(255, 255, 255, 255),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30
                                    ),),
                                )),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> DescPage(
                                    descripcion: 
                                    'Forrest Gump. \nDirector: Robert Zemeckis \nLanzamiento 1994 \nValoracion: 8.8/10 \nGenero: Drama\n\nSinopsis: Forrest Gump, un joven sureño, tenaz e inocente, es protagonista de acontecimientos cruciales en la historia de los Estados Unidos.'
                                    )));
                                },
                                  child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage("./assets/images/forrest.png"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Text('Forrest Gump', style: TextStyle(
                                    color: const Color.fromARGB(255, 0, 0, 0),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30
                                    ),),
                                )),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> DescPage(
                                    descripcion: 
                                    'Matrix. \nDirector: Hermanas Wachowski \nLanzamiento 1999 \nValoracion: 8.7/10 \nGenero: Ciencia Ficcion\n\nSinopsis: un programador y hacker llamado Neo (Keanu Reeves), quien descubre que su mundo cotidiano es en realidad una simulación virtual creada por máquinas inteligentes para mantener controlada a la humanidad.'
                                    )));
                                },
                                  child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage("./assets/images/matrix.png"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child:  Text('Matrix', style: TextStyle(
                                    color: const Color.fromARGB(255, 255, 255, 255),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30
                                    ),),
                                )),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> DescPage(
                                    descripcion: 
                                    'Volver al Futuro. \nDirector: Robert Zemeckis \nLanzamiento 1985 \nValoracion: 8.5/10 \nGenero: Ciencia Ficcion\n\nSinopsis: Una máquina del tiempo transporta a un adolescente a los años 50, cuando sus padres todavía estudiaban en la secundaria.'
                                    )));
                                },
                                  child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage("./assets/images/volver.png"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Text('Volver al Futuro', style: TextStyle(
                                    color: const Color.fromARGB(255, 255, 255, 255),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30
                                    ),),
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
          child: FutureBuilder<Album>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!.name);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();

            },
          ),
        )
      )
    );
  }
}

