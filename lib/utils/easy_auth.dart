import 'package:peach_market/services/api.dart';

Future easyAuth(String nickname)async{
  var response = await API.account.verify();
  return response.data['nickname'] == nickname;
}