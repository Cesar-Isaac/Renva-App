import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:renva/core/config/role.dart';
import 'package:renva/core/routes/routes.dart';
import 'package:renva/core/services/rest_api/api_service.dart';

class AppBuilder extends GetxService {
  GetStorage box = GetStorage("app");
  RxBool isProviderMode = false.obs;

  late Role? role;
  // GeneralUser? user;
  String? token;

  Future<void> loadTokenFromStorage() async {
    token = box.read<String>("token") ?? "";
  }

  loadData() async {
    await box.initStorage;

    if (!box.hasData("role")) {
      setRole(Role.new_user);
    } else {
      role = Role.fromString(box.read("role"));
    }

    if (box.hasData("token")) {
      token = box.read("token");
    }
  }

  setRole(Role role) {
    this.role = role;
    box.write("role", role.name);
  }

  // setUserData(GeneralUser user){}
  setToken(String? token) {
    this.token = token;
    Get.find<APIService>().setToken(token);
    if (token != null) {
      box.write("token", token);
    } else {
      box.remove("token");
    }
  }

  logout() {
    setRole(Role.unregistered);
    setToken(null);
    box.write("isLoggedIn", false);
    Get.find<APIService>().setToken(null);
  }

  Future<void> init() async {
    // first add APIService 
    Get.put(APIService());

    
    await loadData();

    
    if (token != null) {
      Get.find<APIService>().setToken(token);
    }

    if (role == Role.unregistered || role == Role.new_user) {
      Get.offAllNamed(Pages.login.value);
    } else {
      Get.offAllNamed(Pages.home.value);
    }
  }


}
