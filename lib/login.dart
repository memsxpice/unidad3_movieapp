import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/auth_service.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({ super.key });

  @override
  State<LoginPage> createState()=> _LoginPageState();
}


class _LoginPageState extends State<LoginPage>{

  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  
  @override
  void dispose(){
    controllerEmail.dispose();
    controllerPassword.dispose();
    super.dispose();
  }

  void register() async {

    try {
      await authService.value.createAccount(
        email: controllerEmail.text, 
        password: controllerPassword.text
      );
    } on FirebaseAuthException catch (e) {
      print(e.message);
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
              'Login',
              style: TextStyle(
                fontSize: 35,
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
                        controller: controllerEmail,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: 'Enter email',
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (String value){
                            
                        },
                        validator:(value){
                          return value!.isEmpty ? 'Please enter your email' : null;
                        },
                      ),
                    ),
              
                    SizedBox(height: 30,),
              
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextFormField(
                        controller: controllerPassword,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Enter password',
                          prefixIcon: Icon(Icons.password),
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (String value){
                                    
                        },
                        validator:(value){
                          return value!.isEmpty ? 'Please enter your password' : null;
                        },
                      ),
                    ),

                    SizedBox(height: 30,),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      child: MaterialButton(
                        minWidth: double.infinity,
                        onPressed:(){
                          register();
                        },
                        color: Colors.teal,
                        textColor: Colors.white,
                        child:Text('Register'),
                      ),
                    ),

                  ],
                )
              ),
            )
          ],
        ),
      ),
    );
  }

}
