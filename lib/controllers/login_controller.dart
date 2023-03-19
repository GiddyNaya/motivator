import 'package:get/get.dart';

class LoginController extends GetxController {
  var isLogin = false.obs;
  var isPasswordHidden = true.obs;
  setLoggedIn(bool v) => isLogin.value = v;
  setPasswordHidden(bool v) => isPasswordHidden.value = v;
}
