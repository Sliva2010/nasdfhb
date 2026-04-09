import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  String _userName = '';
  String? _userPhotoPath;

  bool get isLoggedIn => _isLoggedIn;
  String get userName => _userName;
  String? get userPhotoPath => _userPhotoPath;

  AppProvider() {
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    _userName = prefs.getString('userName') ?? '';
    _userPhotoPath = prefs.getString('userPhotoPath');
    notifyListeners();
  }

  Future<void> login(String name, {String? photoPath}) async {
    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn = true;
    _userName = name;
    _userPhotoPath = photoPath;
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('userName', name);
    if (photoPath != null) {
      await prefs.setString('userPhotoPath', photoPath);
    }
    notifyListeners();
  }

  Future<void> updateProfile(String name, {String? photoPath}) async {
    final prefs = await SharedPreferences.getInstance();
    _userName = name;
    if (photoPath != null) {
      _userPhotoPath = photoPath;
      await prefs.setString('userPhotoPath', photoPath);
    }
    await prefs.setString('userName', name);
    notifyListeners();
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn = false;
    _userName = '';
    _userPhotoPath = null;
    await prefs.remove('isLoggedIn');
    await prefs.remove('userName');
    await prefs.remove('userPhotoPath');
    notifyListeners();
  }
}
