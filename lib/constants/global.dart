class Global{
  String? fcmToken;
  static final Global _singleton = Global._internal();
  factory Global() {
    return _singleton;
  }
  Global._internal();
  void setFcmToken(String token){
    fcmToken = token;
  }
}