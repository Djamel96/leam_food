import 'package:renovation_core/core.dart';

/// Login to app with [email] and [password]
/// Use the renovation_core auth
Future<bool> login({String email, String password}) async {
  try {
    final loginResponse = await getFrappeAuthController().login(
      email,
      password,
    );

    if (loginResponse.isSuccess) {
      print(loginResponse.data);
      loginResponse.data.toString();
      return true;
    } else {
      print(loginResponse.error.type.name);
      return false;
    }
  } catch (e) {
    print(e);
    return false;
  }
}
