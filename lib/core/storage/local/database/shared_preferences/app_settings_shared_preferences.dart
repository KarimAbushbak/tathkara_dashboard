import 'package:shared_preferences/shared_preferences.dart';
import '../../../../constants.dart';
import 'package:tathkara_dashboard/core/extensions/extensions.dart';


class AppSettingsSharedPreferences {
  static final _instance = AppSettingsSharedPreferences._internal();
  late SharedPreferences _sharedPreferences;

  AppSettingsSharedPreferences._internal();

  factory AppSettingsSharedPreferences() {
    return _instance;
  }

  Future<void> initPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }


  clear() {
    _sharedPreferences.clear();
  }

  Future<void> saveViewedOutBoarding() async {
    await _sharedPreferences.setBool(KeyConstants.outBoardingViewedKey, true);
  }

  bool get outBoardingViewed =>
      _sharedPreferences.getBool(KeyConstants.outBoardingViewedKey).onNull();

  Future<void> setDefaultLocale(String lang) async {
    await _sharedPreferences.setString(KeyConstants.localeKey, lang);
  }
  Future<void> setUserName(String name) async {
    await _sharedPreferences.setString(KeyConstants.userName, name);
  }


  // String get defaultLocale =>
  //     _sharedPreferences.getString(KeyConstants.localeKey).parseLocale();

  Future<void> setToken(String token) async {
    await _sharedPreferences.setString(KeyConstants.token, token);
  }

  String get defaultToken =>
      _sharedPreferences.getString(KeyConstants.token).onNull();

  Future<void> setLoggedIn() async {
    await _sharedPreferences.setBool(KeyConstants.loggedIn, true);
  }

  bool get LoggedIn =>
      _sharedPreferences.getBool(KeyConstants.loggedIn).onNull();

  // Future<void> saveUserInfo(User user) async {
  //   await _sharedPreferences.setInt(
  //     KeyConstants.userId,
  //     user.id,
  //   );
  //   await _sharedPreferences.setString(
  //     KeyConstants.userType,
  //     user.type,
  //   );
  //   await _sharedPreferences.setString(
  //     KeyConstants.userName,
  //     user.name,
  //   );
  //   await _sharedPreferences.setString(
  //     KeyConstants.userEmail,
  //     user.email,
  //   );
  //   await _sharedPreferences.setString(
  //     KeyConstants.userAvatar,
  //     user.avatar,
  //   );
  //   await _sharedPreferences.setString(
  //     KeyConstants.userAvatarOriginal,
  //     user.avatarOriginal,
  //   );
  //   await _sharedPreferences.setString(
  //     KeyConstants.userPhone,
  //     user.phone,
  //   );
  // }

  String get userName =>
      _sharedPreferences.getString(KeyConstants.userName).onNull();

  String get userEmail =>
      _sharedPreferences.getString(KeyConstants.userEmail).onNull();

  String get userId =>
      _sharedPreferences.getInt(KeyConstants.userId).toString().onNull();

  String get userPhone =>
      _sharedPreferences.getString(KeyConstants.userPhone).onNull();

  // Save selected gender value (1 for Male, 2 for Female)
  Future<void> saveSelectedValue(int selectedValue) async {
    await _sharedPreferences.setInt('selectedGender', selectedValue);
  }

  // Retrieve the saved gender value, defaulting to 1 (Male) if not set
  int get selectedValue => _sharedPreferences.getInt('selectedGender').onNull();
}
