
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

 class TokenController{
  var storage = FlutterSecureStorage();

   void  saveToken(String token)async{
     storage.write(key: "token", value: token);
     Map<String, String> allValues = await storage.readAll();
     print(allValues);
  }

  void deleteToken(String token)async
  {
   storage.delete(key: token);
   Map<String, String> allValues = await storage.readAll();
   print(allValues);
  }

  Future<String>  retrieveToken(String token)async{
     return storage.read(key: token);
  }

  void  refreshToken(){
  }

  bool isTokenExpired(){}
  bool isTokenValid(){}

}