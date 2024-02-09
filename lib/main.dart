import 'package:flutter/material.dart';
import 'package:pizza/album.dart';
import 'package:pizza/api_calling.dart';
import 'package:pizza/widgets/appbar_widgets.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _widgetState();
}

 class _widgetState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: const AppbarWidget(
              bgColor: Colors.orange,
              title: Text('HOME')
          ),
         body: Card(
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