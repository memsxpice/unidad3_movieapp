import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/home.dart';
import 'package:movie_app/login.dart';

final FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instance;



Future<void> add({
  required String path,
  required Map<String, dynamic> data,
}) async {
  final DatabaseReference ref = _firebaseDatabase.ref().child(path);
  await ref.set(data);
}


Future<void> delete ({required String path}) async {
  final DatabaseReference ref = _firebaseDatabase.ref().child(path);
  await ref.remove();
}


class AdminPage extends StatefulWidget {
  const AdminPage({ super.key });

  @override
  State<AdminPage> createState()=> _AdminPageState();
}


class _AdminPageState extends State<AdminPage>{

  TextEditingController controllerNombre = TextEditingController();
  TextEditingController controllerYear = TextEditingController();
  TextEditingController controllerDirector = TextEditingController();
  TextEditingController controllerGenero = TextEditingController();
  TextEditingController controllerSinopsis = TextEditingController();
  TextEditingController controllerUrl = TextEditingController();
  
  @override
  void dispose(){
    controllerNombre.dispose();
    controllerYear.dispose();
    controllerDirector.dispose();
    controllerGenero.dispose();
    controllerSinopsis.dispose();
    controllerUrl.dispose();
    super.dispose();
  }

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
        // Ya estas en la pagina de admin
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginPage()));
        break;
    }
  }

  @override
  Widget build(BuildContext context){
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Administracion',
              style: TextStyle(
                fontSize: 35,
                color: Colors. teal,
                fontWeight: FontWeight.bold
              ),
            ),
            
            SizedBox(height: 30,),

            Text(
              'Alta de nueva pelicula',
              style: TextStyle(
                fontSize: 20,
                color: Colors. teal,
                fontWeight: FontWeight.bold
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Form(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextFormField(
                        controller: controllerNombre,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Nombre de pelicula',
                          hintText: 'Nombre de pelicula',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (String value){
                            
                        }
                      ),
                    ),
              
                    SizedBox(height: 30,),
              
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextFormField(
                        controller: controllerYear,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          labelText: 'Año de estreno',
                          hintText: 'Año de estreno',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (String value){          
                        },
                      ),
                    ),

                    SizedBox(height: 30,),
              
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextFormField(
                        controller: controllerDirector,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          labelText: 'Director',
                          hintText: 'Director',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (String value){          
                        },
                      ),
                    ),

                    SizedBox(height: 30,),
              
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextFormField(
                        controller: controllerGenero,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          labelText: 'Genero',
                          hintText: 'Genero',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (String value){          
                        },
                      ),
                    ),

                    SizedBox(height: 30,),
              
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextFormField(
                        controller: controllerSinopsis,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          labelText: 'Sinopsis',
                          hintText: 'Sinopsis',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (String value){          
                        },
                      ),
                    ),

                    SizedBox(height: 30,),
              
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextFormField(
                        controller: controllerUrl,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          labelText: 'URL de imagen',
                          hintText: 'URL de imagen',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (String value){          
                        },
                      ),
                    ),

                    SizedBox(height: 30,),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      child: MaterialButton(
                        minWidth: double.infinity,
                        onPressed:(){
                          add(path: 'data1', data:{'form': 'fieldsAdd'});
                        },
                        color: Colors.teal,
                        textColor: Colors.white,
                        child:Text('Agregar'),
                      ),
                    ),

                    SizedBox(height: 60,),

                    Text(
                      'Baja de pelicula',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors. teal,
                        fontWeight: FontWeight.bold
                      ),
                    ),

                    SizedBox(height: 30,),
              
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextFormField(
                        controller: controllerUrl,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          labelText: 'Buscar',
                          hintText: 'Buscar',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (String value){          
                        },
                      ),
                    ),

                    SizedBox(height: 30,),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      child: MaterialButton(
                        minWidth: double.infinity,
                        onPressed:(){
                          delete(path: 'searchRes');
                        },
                        color: Colors.teal,
                        textColor: Colors.white,
                        child:Text('Eliminar'),
                      ),
                    ),
                    
                  ],
                )
              ),
            )
          ],
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
      ),
    );

    
  }

}
