import 'package:shared_preferences/shared_preferences.dart';

import '../../model/login_model/login_model.dart';


class UserPreference {
  Future<bool> saveUser(LoginModel responseModel) async {
    print('Saving user...');

    SharedPreferences sp = await SharedPreferences.getInstance();

    sp.setString('token', responseModel.data!.bearerToken ?? '');
    sp.setString('unique_id', responseModel.data!.uniqueId!);
    sp.setBool('isLogin', responseModel.isLogin ?? false);
    print('User saved.');
    return true;
  }
  Future<String?> uid() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString('unique_id');
  }

  Future<bool> saveFcmToken(String fcmToken) async {
    print('Saving FCM token...');
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('fcmToken', fcmToken);
    print('FCM token saved.');
    return true;
  }
  Future<bool> saveLocationAllow(bool value) async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool('isLocation', value);
    return true;
  }
  getLocationAllow(){
    SharedPreferences.getInstance().then((value){
      return value.getBool("isLocation");
    });
  }

  getfcmToken() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString('fcmToken');
  }
  Future<LoginModel> getUser() async {
    print('Getting user...');
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString('token');
    int? user = sp.getInt('user');
    bool? isLogin = sp.getBool('isLogin');
    print('User got.');
    return LoginModel(
      data: Data(bearerToken: token),
      isLogin: isLogin,
    );
  }

  Future<bool> removeUser() async {
    print('Removing user...');
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
    print('User removed.');
    return true;
  }
}
