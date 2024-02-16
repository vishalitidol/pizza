import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:pizza/album.dart';
import 'package:pizza/api_calling.dart';
import 'package:pizza/login.dart';
import 'package:pizza/photos.dart';
import 'package:pizza/widgets/appbar_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _widgetState();
}

class _widgetState extends State<HomeScreen> {

  // final FirebaseMessaging _firebaseMessaging2 = FirebaseMessaging.instance;
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _firebaseMessaging2.getToken().then((token) => print(token));
  // }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: const AppbarWidget(
            bgColor: Colors.orange,
            title: Text('HOME')
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(curve: Curves.bounceInOut,
                decoration: BoxDecoration(
                  color: Colors.lightBlue,
                ),
                  child: Text('Drawer Header',style: TextStyle(fontSize: 50),),
              ),
              ListTile(
                title: const Text('Album',style: TextStyle(fontSize: 30,color: Colors.green),),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const Album()));

                },
              ),
              ListTile(
                title: const Text('Photos',style: TextStyle(fontSize: 30,color: Colors.green),),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const Photos()));
                },
              ),

              Padding(
                padding: const EdgeInsets.only(top: 478),
                child: ListTile(leading: Icon(Icons.person,size: 35,color: Colors.black87,),
                  tileColor: Colors.red,
                  title: Text('SignOut',style: TextStyle(fontSize: 30,color: Colors.cyan),),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyLogin()));
                  },
                ),
              ),
            ],
          ),
        ),
        body: Center(
          child: FutureBuilder(
            future: ApiService.getUserData(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return const Center(
                  child: Text('Loading...'),
                );
              } else {
                return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, i){
                      return Container(
                        padding: const EdgeInsets.only(top: 5,bottom: 5,left: 0),
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                  color: Colors.red,
                                  width: 1,
                                )
                            )
                        ),
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const Album()),
                            );
                          },
                          leading: const Padding(
                            padding: EdgeInsets.only(right: 0),
                            child: CircleAvatar(
                              maxRadius: 30,
                              backgroundImage: NetworkImage(
                                  "https://images.pexels.com/photos/1880651/pexels-photo-1880651.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
                              ),
                            ),
                          ),
                          title: Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(snapshot.data![i].email,
                              style: const TextStyle(fontSize: 25),
                            ),
                          ),
                          subtitle: Text(snapshot.data![i].name,
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                      );
                    });
              }
            },
          ),
        ),
      ),
    );
  }
}