import 'package:flutter/material.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget{
  final Color bgColor;
  final Icon? icon;
  final Text? title;

  const AppbarWidget({super.key,
    required this.bgColor,
    this.icon,
    this.title});
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
          backgroundColor: bgColor,
          title: title,
          elevation: 100,
          //title: const Text(' HOME '),
          iconTheme: const IconThemeData(color: Colors.black),
          foregroundColor: Colors.black,
          centerTitle: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              )
          ),
    );
  }
}