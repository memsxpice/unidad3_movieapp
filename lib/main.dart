import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';


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


void main(){
  runApp( MyApp() );
}


class MyApp extends StatefulWidget {
  const MyApp({ super.key });

  @override
  State<MyApp> createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> {
  late Future<Album> futureAlbum;
  

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
                child: Text('Bienvenido a MemoFlix!',
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
                              Container(
                                padding: const EdgeInsets.all(8),
                                color: Colors.teal[600],
                                child: FutureBuilder<Album>(
                                  future: futureAlbum,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Text('Disfruta la nueva pelicula de: ' + snapshot.data!.name);
                                    } else if (snapshot.hasError) {
                                      return Text('${snapshot.error}');
                                    }
                                    // By default, show a loading spinner.
                                    return const CircularProgressIndicator();
                                  },
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                color: Colors.teal[200],
                                child: const Text('Pelicula 2'),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                color: Colors.teal[300],
                                child: const Text('Pelicula 3'),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                color: Colors.teal[400],
                                child: const Text('Pelicula 4'),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                color: Colors.teal[500],
                                child: const Text('Pelicula 5'),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                color: Colors.teal[600],
                                child: const Text('Pelicula 6'),
                              ),
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
          type: BottomNavigationBarType.fixed, 
          selectedItemColor: Color.fromRGBO(60, 150, 112, 1),
          items: const[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Inicio',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Buscar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              label: 'Novedades',
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

