import 'package:dio/dio.dart';

import '../constants/constants.dart';

class DioHelper {
  static late Dio dio ;
  static Init(){
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true ,
      ),
    );
  }

  static Future<Response> GetData({
    required String url ,
    Map<String,dynamic>? query ,
    String? token ,
})async{
    dio.options.headers ={
      'lang' :  enLan? 'en' : 'ar' ,
      'Content-Type' : 'application/json' ,
      'Authorization': token,
    };
   return await dio.get(
        url,
      queryParameters: query,
    );
  }

  static Future<Response> DeleteData(
  {
    required String url,
    Map<String,dynamic>? query ,
     dynamic data ,
    String? token ,
}
      )async{
    dio.options.headers= {
      'lang' :  enLan? 'en' : 'ar' ,
      'Content-Type' : 'application/json' ,
      'Authorization': token,
    };

    return await dio.delete(url);
  }

  static Future<Response> PostData ({
    required String url,
    Map<String,dynamic>? query ,
    required dynamic data ,

    String? token ,
})async{
    dio.options.headers= {
      'lang' : enLan? 'en' : 'ar',
      'Content-Type' : 'application/json' ,
      'Authorization': token,
    };
    return await dio.post(
      url,
      queryParameters: query,
      data: data ,
    );
  }

  static Future<Response> PutData({
    required String url,
    required dynamic data ,
    required String token ,
})async{
    dio.options.headers= {
      'lang' : enLan? 'en' : 'ar' ,
      'Content-Type' : 'application/json' ,
      'Authorization': token,
    };
    return await dio.put(
      url,
      data: data,
    );
  }


}