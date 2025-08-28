import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:image_picker/image_picker.dart';
import 'package:renvo_app/core/config/role.dart';
import 'package:renvo_app/core/localization/strings.dart';
import 'package:renvo_app/core/routes/routes.dart';
import 'package:dio/dio.dart';
import '../../../core/config/app_builder.dart';
import '../../../core/services/rest_api/api_service.dart';
import '../../../core/services/rest_api/constants/end_points.dart';
import '../../../core/services/rest_api/models/request.dart';
import '../../../core/style/repo.dart';

class CompleteInfoPageController extends GetxController {
  final AppBuilder appBuilder = Get.find();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var isLoading = false.obs;
  late TextEditingController name, lastName, email, nationalNumber, gender;
  late final String phoneNumber;
  late final String token;

  Rx<String> image = "".obs;
  Rx<String> imageId = "".obs;

  pickImage() async {
    XFile? picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked == null) return;
    image.value = picked.path;
  }

  pickImageID() async {
    XFile? picked = await ImagePicker().pickImage(source: ImageSource.camera);
    if (picked == null) return;
    imageId.value = picked.path;
  }

  int getGenderIdFromText(String input) {
    final value = input.toLowerCase().trim();
    if (value == 'male' || value == 'ذكر') return 1;
    if (value == 'female' || value == 'أنثى') return 2;
    throw Exception('Invalid gender value: $input');
  }

  Future<void> confirm() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;
    debugPrint("===== Sending Data =====");
    debugPrint("First Name: ${name.text}");
    debugPrint("Last Name: ${lastName.text}");
    debugPrint("Phone: $phoneNumber");
    debugPrint("Email: ${email.text}");
    debugPrint("Dial Code: 963");
    debugPrint("National ID: ${nationalNumber.text}");
    debugPrint("Gender ID: ${getGenderIdFromText(gender.text)}");
    debugPrint("Avatar Path: ${image.value}");
    debugPrint("ID Card Path: ${imageId.value}");
    debugPrint("========================");

    final response = await APIService.instance.request(
      Request(
        endPoint: EndPoints.update,
        method: RequestMethod.Post,
        header: {"Authorization": "Bearer $token", "Locale": "ar"},
        body: FormData.fromMap({
          "first_name": name.text,
          "last_name": lastName.text,
          "phone": phoneNumber,
          "email": email.text,
          "dial_country_code": "963",
          "nationalID": nationalNumber.text,
          "gender_id": getGenderIdFromText(gender.text),
          "avatar": await MultipartFile.fromFile(
            image.value,
            filename: "avatar.jpg",
          ),
          "IDcard": await MultipartFile.fromFile(
            imageId.value,
            filename: "idcard.jpg",
          ),
        }),
      ),
    );

    isLoading.value = false;

    if (response.success) {
      appBuilder.setRole(Role.user);
      appBuilder.setToken(token);

      Get.offAllNamed(Pages.home.value);
    } else {
      Get.snackbar(
        tr(LocaleKeys.error),
        response.message ,
        snackPosition: SnackPosition.TOP,
        backgroundColor: StyleRepo.red,
        colorText: StyleRepo.white,
      );
    }
  }

  @override
  void onInit() {
    final args = Get.arguments as Map;
    phoneNumber = args["phone"] as String;
    token = args["token"] as String;

    name = TextEditingController();
    lastName = TextEditingController();
    email = TextEditingController();
    nationalNumber = TextEditingController();
    gender = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    name.dispose();
    lastName.dispose();
    email.dispose();
    nationalNumber.dispose();
    gender.dispose();
    super.onClose();
  }
}
