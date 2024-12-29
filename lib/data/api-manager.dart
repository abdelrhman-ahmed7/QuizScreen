import 'dart:convert';
import 'dart:io';
import 'package:quizscreen/model//results.dart';

import 'package:http/http.dart';

abstract class ApiManager{
  static Future loadcategorylist() async  {
  try{

   Uri url =Uri.parse("https://opentdb.com/api.php?amount=10");
   Response response= await(get(url));
   final mapBody = jsonDecode(response.body) as Map<String, dynamic>;
   if(response.statusCode>=200&&response.statusCode<300){
     Results result =Results.fromJson(mapBody);
     return result;
   }

   }
  catch(e){
    rethrow;
  }
   }


}