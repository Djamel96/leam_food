// import 'package:leamapp/home/models/recipe.dart';
// import 'package:renovation_core/core.dart';

import 'package:dio/dio.dart';
import 'package:leamapp/common/api.dart';
import 'package:leamapp/home/models/recipe.dart';
import 'package:leamapp/main_store.dart';

Future getRecipe(MainStore mainStore) async {
  Response response;
  Dio dio = Dio();
  var header = {
    "Accept": 'application/json',
  };

  try {
    response = await dio.get(
      Apis.getRecipe,
      queryParameters: {
        "number": 10,
        "apiKey": "87111256b1b941b78679be8f10820094"
      },
      options: Options(
        headers: header,
      ),
    );

    if (response != null) {
      if (response.statusCode == 200) {
        mainStore.recipes = Recipe.listFromMap(response.data);
        mainStore.notify();
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



// Future getRecipe() async {
//   // try {

//   // Recipe rec = Recipe("Recipe");

//   // final response = await getFrappeModelController().getList(
//   //   rec,
//   //   fields: ["*"],
//   // );

//   // if (response.isSuccess) {
//   //   print(response.data);
//   //   response.data.toString();
//   //   return true;
//   // } else {
//   //   print(response.error.type.name);
//   //   return false;
//   // }
//   // } catch (e) {
//   //   print(e);
//   //   return false;
//   // }
// }
