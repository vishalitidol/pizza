import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pizza/login.dart';
import 'package:pizza/register.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  String email = "";
  final _formkey =GlobalKey<FormState>();
  final FirebaseAuth _auth=FirebaseAuth.instance;
  TextEditingController emailReset = TextEditingController();

  resetpassword()async{
    try{
      await _auth.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            "Password Reset Email has been sent !",
            style: TextStyle(fontSize: 20.0),
          )));
    }on FirebaseAuthException catch(er) {
      if(er.code == "user-not-found") {}
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[300],
      body: Column(
        children: [
          const SizedBox(
            height: 60,
          ),
          Container(
            alignment: Alignment.topCenter,
            child: const Text(
              "Password Recovery",
              style: TextStyle(
                color: Colors.lime,
                fontSize: 30.0,
                fontWeight: FontWeight.bold,),
            ),
          ),
          const SizedBox(height: 20),
          const Text('Enter Your Mail',
          style: TextStyle(
            color: Colors.lime,
            fontSize: 20,
            fontWeight: FontWeight.w500),
          ),
          Expanded(
              child: Form(
                key: _formkey,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10,left: 10),
                  child: ListView(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 10,right: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black87, width: 2),
                              borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextFormField(
                          validator: (value){
                            if(value==null||value.isEmpty){
                              return 'please enter your email';
                            }
                            return null;
                          },
                          controller: emailReset,
                          style: const TextStyle(color: Colors.black87,fontSize: 20,fontWeight: FontWeight.w500),
                            cursorColor: Colors.black,
                            decoration: const InputDecoration(
                              hintText: "Email",
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)
                              ),
                              //iconColor: Colors.black,
                              hintStyle: TextStyle(
                                fontSize: 20,color: Colors.black,
                              ),
                              prefixIcon: Icon(Icons.person,color: Colors.black,size: 30,)
                            )
                          ),
                        ),
                      const SizedBox(
                        height: 40,
                      ),
                      GestureDetector(
                        onTap: () {
                          if(_formkey.currentState!.validate()){
                            setState(() {
                              email=emailReset.text;
                            });
                            resetpassword();
                          }
                        },
                        child: Container(
                          width: 100,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.orange.shade300,
                            borderRadius: BorderRadius.circular(20)),
                          child: const Center(
                            child: Text("Reset Email",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Text("Want to SignUp",
                              style: TextStyle(color: Colors.black,
                                  fontSize: 20,
                              fontWeight: FontWeight.w500),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: TextButton(
                              onPressed: () {Navigator.push(
                                  context, MaterialPageRoute(
                                  builder: (context) =>const Register())
                              );
                              },
                              child: const Text('Click Here!',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Text("Want to SignIn",
                              style: TextStyle(color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: TextButton(
                              onPressed: () {Navigator.push(
                                  context, MaterialPageRoute(
                                  builder: (context) =>const MyLogin())
                              );
                              },
                              child: const Text('Click Here!',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
          ),
        ],
      ),
    );
  }
}
