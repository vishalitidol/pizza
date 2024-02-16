import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pizza/login.dart';
import 'homescreen.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String name = "",
      email = "",
      password = "";
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  signUp() async {
    if (passwordController != "" && nameController.text!= "" &&
        emailController.text!= "") {
      try {
        UserCredential userCredential = await _auth
            .createUserWithEmailAndPassword(
          email: email, password: password,
        );
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
              "Registered Successfully",
              style: TextStyle(fontSize: 20.0),
            )));
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomeScreen()));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade100,
      body: Form(
        key: _formkey,
        child: Stack(
            children: [
                  Container(
                    padding: const EdgeInsets.only(right: 10, left: 20, top: 90),
                    child: const Text(
                      'Create Account,',
                      style: TextStyle(color: Colors.black87, fontSize: 40),
                    ),
                  ),
              Container(
                padding: const EdgeInsets.only(right: 20, left: 20, top: 200),
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value){
                          if(value==null||value.isEmpty){
                            return 'please enter your name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade200,
                            filled: true,
                            hintText: 'Full Name',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))
                        ),
                        controller: nameController,
                      )
                    ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(right: 20, left: 20, top: 280),
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value){
                        if(value==null||value.isEmpty){
                          return 'please enter your Email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          hintText: 'Email',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))
                      ),
                      controller: emailController,
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(right: 20, left: 20, top: 360),
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value){
                        if(value==null||value.isEmpty){
                          return 'please enter your Password';
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          hintText: 'Password',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))
                      ),
                      controller: passwordController,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 20, top: 460),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 50,
                      width: 370,
                      child: TextButton(
                        onPressed: () {
                          if(_formkey.currentState!.validate()){
                            {
                              setState(() {
                                email = emailController.text;
                                name = nameController.text;
                                password = passwordController.text;
                              });
                            }
                              signUp();
                          }
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 200, top: 510),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(
                        builder: (context) => const MyLogin())
                    );
                  },
                  child: const Text('Already have account?',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ]
        ),
      ),
    );
  }
}