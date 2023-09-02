import 'package:peach_market/services/api.dart';

Future easyAuth()async{
  var response = await API.account.verify();
  return response;
}