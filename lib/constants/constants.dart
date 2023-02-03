import 'package:shop_final/shared_preferences/shared_preferences.dart';

String? token = CasheHelper.GetData(key: 'token');
int? uId = CasheHelper.GetData(key: 'uId');

bool enLan = CasheHelper.GetData(key: 'enLan') ?? true;