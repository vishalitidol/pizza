import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

class ApiService {

  static Future<List<User>> getUserData() async {
    var response = await http.get(
        Uri.https('jsonplaceholder.typicode.com', 'users'));
    var jsonData = jsonDecode(response.body);
    List<User> users = [];

    (jsonDecode(response.body)).map((u){
      User user = jsonData(u['email']. u['username']);
      users.add(user);
      print(users.length);}
   //  for (var u in jsonData) {
   //    User user = User(u['email'], u['username']);
   //    users.add(user);
   //    }
   //  print(users.length);
       );
    return users;
   //  return users;
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
    List<UserAlbumModel> albumusers = [];

    for(var u in jsonData){
      UserAlbumModel data = UserAlbumModel(u['title'],u['id'].toString(), u['userId'].toString());
      albumusers.add(data);
    }
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

class ApiService3 {
  static Future getPhotoData() async{
    var responsephoto = await http.get(Uri.https('jsonplaceholder.typicode.com','photos', {'albumId':'1'}));
    var jsonData = jsonDecode(responsephoto.body);
    List<UserPhotoModel> _photousers = [];


    for (var u in jsonData) {
      UserPhotoModel data = UserPhotoModel(u['id'].toString(),u['url'], u['title']);
      _photousers.add(data);
    }
    print(_photousers.length);
    return _photousers;
  }
}
class UserPhotoModel {
  final String id, url, title;

  UserPhotoModel(this.id, this.url, this.title,);
}
