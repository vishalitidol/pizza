import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pizza/register.dart';
import 'forgot_password.dart';
import 'homescreen.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({super.key});

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String email ='',password = '';
  TextEditingController emailControllerLogin = TextEditingController();
  TextEditingController passwordControllerLogin = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  signIn()async {
    try{
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    } on FirebaseAuthException catch (ex) {
      if(ex.code == 'user-not-found') {
        print('No user found for that email');
      }else if(ex.code == 'wrong-password') {
        print('Wrong password provided for that user');
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
              padding: const EdgeInsets.only(right: 10,left: 20,top: 90),
              child: const Text(
                'Welcome Back,',
                style: TextStyle(color: Colors.black87, fontSize: 40),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 20,left: 20,top: 200),
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) {
                      if(value==null||value.isEmpty){
                        return 'please enter your email';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      hintText: 'Email',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                    ),
                    controller: emailControllerLogin,
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 20,left: 20,top: 280),
              child: Column(
                children: [
                  TextFormField(
                    validator: (value){
                      if(value==null||value.isEmpty){
                        return 'please enter your password';
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                        fillColor: Colors.grey.shade200,
                        filled: true,
                        hintText: 'Password',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                    ),
                    controller: passwordControllerLogin,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 230, top: 335),
              child: TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPassword()));
              },
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 18
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20,left: 20, top: 380),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: 50,
                    width: 370,
                    child: TextButton(
                      onPressed: () {
                        {
                          if (_formkey.currentState!.validate()) {
                            setState(() {
                              email = emailControllerLogin.text;
                              password = passwordControllerLogin.text;
                            });
                            signIn();
                          }
                        }
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: const Text(
                        'Sign In',
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
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20,top: 440),
                  child: Text("Don't have account?",
                  style: TextStyle(color: Colors.black54,
                  fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10,top: 440),
                  child: TextButton(
                    onPressed: () {Navigator.push(
                        context, MaterialPageRoute(
                        builder: (context) => const Register())
                       );
                      },
                    child: const Text('Create new account.',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
