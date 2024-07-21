import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  test('test', ()async {SharedPreferences? sharedPreferences = await SharedPreferences.getInstance();}, testOn: 'windows');

}
