import 'package:shared_preferences/shared_preferences.dart';

class StorageService{

  static Future<void> storeNumber(String num) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('currentNumber', num);
  }

  static Future<String?> getNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('currentNumber');
  }

  static Future<void> clearNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('currentNumber');
  }

  static Future<void> storeName(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('currentName', name);
  }

  static Future<String?> getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('currentName');
  }

  static Future<void> clearName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('currentName');
  }

  static Future<void> storeMail(String mail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('currentMail', mail);
  }

  static Future<String?> getMail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('currentMail');
  }

  static Future<void> clearMail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('currentMail');
  }

  static Future<void> storePrivelege(int type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('currentPrivelege', type);
  }

  static Future<int?> getPrivelege() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('currentPrivelege');
  }

  static Future<void> clearPrivelege() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('currentPrivelege');
  }

  static Future<void> storePincode(String pincode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('currentPincode', pincode);
  }

  static Future<String?> getPincode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('currentPincode');
  }

  static Future<void> clearPincode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('currentPincode');
  }

}