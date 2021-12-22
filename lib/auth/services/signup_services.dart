import 'package:dio/dio.dart';

import 'package:leamapp/common/api.dart';
import 'package:leamapp/common/const.dart';

/// Signup to app with [fname], [lname], [email], [password]
/// Use the renovation_core auth
Future<bool> signup({
  String fname,
  String lname,
  String email,
  String password,
}) async {
  Map data = {
    "cmd": Apis.signup,
    "args": {
      "first_name": fname,
      "last_name": lname,
      "email": email,
      "password": password,
    }
  };
  print(data);
  Response response;
  Dio dio = Dio();
  var header = {
    //"Accept": 'application/json',
  };

  try {
    response = await dio.post(
      Apis.root,
      data: data,
      options: Options(
          //headers: header,
          //sendTimeout: SEND_TIME_OUT,
          // receiveTimeout: SEND_TIME_OUT
          ),
    );

    if (response != null) {
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    }
  } on DioError catch (e) {
    if (e.type == DioErrorType.CONNECT_TIMEOUT) {}
    if (e.response != null) {
      print(e.response.statusCode);
      print("response = ${e.response.data}");
      print(e.response.headers);
      print(e.response.request);
    } else {}
    return false;
  }
  return false;
}
