
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

 class TokenController{
  var storage = FlutterSecureStorage();

   void  saveToken(String token)async{
     storage.write(key: "token", value: token);
     storage.write(key: "isLoggedIn",value: "Yes");
     Map<String, String> allValues = await storage.readAll();

     print(allValues);
  }

  void deleteToken(String token)async
  {
   storage.delete(key: token);
   storage.delete(key: "isLoggedIn");

   print("all values from storage will be deleted");
   Map<String, String> allValues = await storage.readAll();
   print(allValues);
  }

  Future<String>  retrieveToken(String token)async{
     print("all values is storage");
    Map<String, String> allValues = await storage.readAll();
    print(allValues);
     return storage.read(key: token);
  }

  void  refreshToken(){
  }

  bool isTokenExpired(){}
  bool isTokenValid(){}

}