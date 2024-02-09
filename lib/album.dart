import 'package:flutter/material.dart';
import 'package:pizza/api_calling.dart';
import 'package:pizza/photos.dart';
import 'package:pizza/widgets/appbar_widgets.dart';

class Album extends StatefulWidget {
  const Album({super.key});

  @override
  State<Album> createState() => _AlbumState();
}

class _AlbumState extends State<Album> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(bgColor: Colors.red,title: Text("ALBUM"),),
      body: Card(
        child: FutureBuilder(
          future: ApiService2.getAlbumData(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return const Center(
                child: Text('Loading...'),
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.length,
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
                        MaterialPageRoute(builder: (context) => const Photos()),
                      );
                    },
                    leading: const Padding(
                      padding: EdgeInsets.only(right: 0),
                      child: CircleAvatar(
                        maxRadius: 30,
                       backgroundImage: NetworkImage(
                           'https://images.pexels.com/photos/19983805/pexels-photo-19983805/free-photo-of-musical-prelude.jpeg'
                       ),
                      ),
                    ),
                    title: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(snapshot.data[i].title,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    subtitle: Text(snapshot.data[i].id,
                    style: const TextStyle(fontSize: 20),),
                  ),
                );
              });
            }
          },
        ),
      ),
    );
  }
}