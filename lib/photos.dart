import 'package:flutter/material.dart';
import 'package:pizza/api_calling.dart';
import 'package:pizza/fullscreen.dart';
import 'package:pizza/widgets/appbar_widgets.dart';

class Photos extends StatefulWidget {
  const Photos({super.key});

  @override
  State<Photos> createState() => _PhotosState();
  }

class _PhotosState extends State<Photos> {
  final PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(bgColor: Colors.pinkAccent,title: Text('PHOTOS'),),
      body: FutureBuilder(
        future: ApiService3.getPhotoData(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const Center(
              child:Text('Loading....'),
            );
          } else {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
              ),
                itemCount: snapshot.data.length,
                itemBuilder: (context, i){
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => FullScreenImage(
                            imageUrls: snapshot.data.map((i) =>
                            i.url).toList(),initialIndex: i))
                        );
                     },
                    child: Row(
                       children: [
                        Column(
                          children: [
                            SizedBox(
                              height: 136,
                              width: 136,
                              child: Image.network(snapshot.data[i].url)
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                });
             }
          },
      ),
    );
  }
}