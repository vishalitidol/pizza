import 'package:flutter/material.dart';
import 'package:pizza/widgets/appbar_widgets.dart';

class FullScreenImage extends StatefulWidget {
  final imageUrls;
  final int initialIndex;

  const FullScreenImage({super.key, required this.imageUrls,required this.initialIndex});

  @override
  Scroll createState() => Scroll();
  }

  class Scroll extends State<FullScreenImage>{
  late PageController _pageController;
  int currentindex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialIndex);
    currentindex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(bgColor: Colors.pinkAccent,title: Text('SCREEN'),),
      body: Stack(
        children: [PageView.builder(allowImplicitScrolling: true,
          itemCount: widget.imageUrls.length * 1000,
          itemBuilder: (context, i) {
            final index = (i % widget.imageUrls.length);
            return Center(
              child: Image.network(
                widget.imageUrls[index],
                fit: BoxFit.contain,
              ),
            );
          },
              controller: _pageController,
          onPageChanged: (i) {
            setState((){
              currentindex = ((i % widget.imageUrls.length).toInt());
            });
            }

        ),
          Positioned(
              left: 16,
              bottom: 350,
            //top: MediaQuery.of(context).size.height / 2,
              child: IconButton(icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                if (currentindex < widget.imageUrls.length) {
                  _pageController.previousPage(
                      duration: const Duration(microseconds: 200),
                      curve: Curves.easeInCubic);
                }
              }
           ),
        ),
          Positioned(
            right: 16,
            bottom: 350,
            //top: MediaQuery.of(context).size.height / 2,
            child: IconButton(icon: const Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  if (currentindex < widget.imageUrls.length * 1000) {
                    _pageController.nextPage(
                        duration: const Duration(microseconds: 200),
                        curve: Curves.easeInCubic);
                  }
                }
            ),
          ),
        ]
      ),
    );
  }
}