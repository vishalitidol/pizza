import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class ApiService {

  static Future<List<User>> getUserData() async {
    var response = await http.get(
        Uri.https('jsonplaceholder.typicode.com', 'users'));
    var jsonData = jsonDecode(response.body);
    List<User> users = jsonData.map<User>((u) => User(u['email'], u['username'])).toList();
    print(users.length);


    // for (var u in jsonData) {
    //   User user = User(u['email'], u['username']);
    //   users.add(user);
    //   }
    // print(users.length);

    return users;
    }
}
class User {
  final String name, email;
  User(this.name, this.email);
}

class ApiService2 {
  static Future getAlbumData() async{
    var responsealbum = await http.get(Uri.http('jsonplaceholder.typicode.com','/albums',{'userId':'1'}));
    var jsonData = jsonDecode(responsealbum.body);
    var albumusers =
    jsonData.map<UserAlbumModel>((v) =>
        UserAlbumModel(v['title'], v['id'].toString(), v['userId'].toString())).toList();

    // for(var u in jsonData){
    //   UserAlbumModel data = UserAlbumModel(u['title'],u['id'].toString(), u['userId'].toString());
    //   albumusers.add(data);
    // }
    print(albumusers.length);
    return albumusers;
  }
}
class UserAlbumModel {
  final String title, id, userId;

  UserAlbumModel(
      this.title, this.id, this.userId
      );
}

// class ApiService2 {
//   static Future getAlbumData() async{
//     final dio =Dio();
//     final response2 = await dio.get('https://jsonplaceholder.typicode.com/albums?userId=1');
//     //print(response2.data);
//     var jsonData = jsonDecode(response2.data);
//     var albumusers = [];
//     for(var u in jsonData){
//       UserAlbumModel data = UserAlbumModel(u['title'],u['id'].toString(), u['userId'].toString());
//       albumusers.add(data);
//     }
//     print(albumusers.length);
//     return albumusers;
//   }
// }
// class UserAlbumModel {
//   final String title, id, userId;
//
//   UserAlbumModel(
//       this.title, this.id, this.userId
//       );
// }

class ApiService3 {
  static Future getPhotoData() async{
    var responsephoto = await http.get(Uri.https('jsonplaceholder.typicode.com','photos', {'albumId':'1'}));
    var jsonData = jsonDecode(responsephoto.body);
    List<UserPhotoModel> photousers = [];

    for (var u in jsonData) {
      UserPhotoModel data = UserPhotoModel(u['id'].toString(),u['url'], u['title']);
      photousers.add(data);
    }
    print(photousers.length);
    return photousers;
  }
}
class UserPhotoModel {
  final String id, url, title;

  UserPhotoModel(this.id, this.url, this.title,);
}
