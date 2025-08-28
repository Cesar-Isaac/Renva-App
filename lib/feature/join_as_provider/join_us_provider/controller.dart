import 'package:easy_localization/easy_localization.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:renvo_app/core/localization/strings.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:dio/dio.dart';
import '../../../core/config/app_builder.dart';
import '../../../core/routes/routes.dart';
import '../../../core/services/rest_api/api_service.dart';
import '../../../core/services/rest_api/constants/end_points.dart';
import '../../../core/services/rest_api/models/request.dart';
import '../../../core/services/rest_api/models/response_model.dart';
import '../../../core/services/state_management/obs.dart';
import '../../../core/style/repo.dart';
import '../../home/models/all_categories.dart';

class JoinUsProviderPageController extends GetxController {
  
  final formKeyStep1 = GlobalKey<FormState>();
  final formKeyStep2 = GlobalKey<FormState>();

  
  final RxInt currentStep = 0.obs;

  
  late final TextEditingController nameProv;
  late final TextEditingController email;
  late final TextEditingController phoneNumber;
  late final TextEditingController gender;
  late final TextEditingController street;
  late final TextEditingController streetNumber;
  late final TextEditingController postCode;
  late final TextEditingController city;
  late final TextEditingController state;
  late final TextEditingController country;
  late final TextEditingController description;
  late final TextEditingController addressId;
  late final TextEditingController cityId;
  late final TextEditingController countryId;
  late final TextEditingController longitude;
  late final TextEditingController latitude;

  
  final Rx<String> image = ''.obs;

  pickImage() async {
    XFile? picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked == null) return;
    image.value = picked.path;
  }

  final RxList<XFile> uploadedPhotos = <XFile>[].obs;

  
  final RxSet<int> selectedIndexes = <int>{}.obs;
  final RxSet<int> selectedCategoryIds = <int>{}.obs;

  final RxString selectedOption = ''.obs;
  final RxString servicePlace = ''.obs;

  
  final RxString photoError = ''.obs;
  final RxString radioError = ''.obs;

  Rx<TimeOfDay?> startTime = Rx<TimeOfDay?>(null);
  Rx<TimeOfDay?> endTime = Rx<TimeOfDay?>(null);
  RxBool selectedAnyTime = false.obs;
  late final String token;

  void selectAnyTime(bool value) {
    selectedAnyTime.value = value;
  }

  ObsList<AllCategories> categories = ObsList([]);

  var isLoading = false.obs;
  final AppBuilder appBuilder = Get.find();

  fetch() async {
    final token = appBuilder.token;
    ResponseModel response = await APIService.instance.request(
      Request(
        endPoint: EndPoints.categories,
        fromJson: AllCategories.fromJson,
        header: {"Authorization": "Bearer $token"},
      ),
    );
    if (response.success) {
      categories.value = response.data;
    } else {
      categories.error = response.message;
    }
  }

  Future<void> join() async {
    isLoading.value = true;
    final token = appBuilder.token;

    Map<String, dynamic> map = {
      "name": nameProv.text,
      "dial_country_code": "963",
      "phone": phoneNumber.text,
      "email": email.text,
      "description": description.text,
      "avatar": await MultipartFile.fromFile(
        image.value,
        filename: "avatar.jpg",
      ),

      "start_at":
          selectedAnyTime.value
              ? null
              : "${startTime.value?.hour.toString().padLeft(2, '0')}:${startTime.value?.minute.toString().padLeft(2, '0')}",
      "end_at":
          selectedAnyTime.value
              ? null
              : "${endTime.value?.hour.toString().padLeft(2, '0')}:${endTime.value?.minute.toString().padLeft(2, '0')}",
      "latitude": 55.99,
      "longitude": 44.22,
      "street_name": "Damas",
      "street_number": 12345,
      "post_code": 455,
      "city_id": 1,
      "country_id": 1,
    };

    
    for (int i = 0; i < uploadedPhotos.length; i++) {
      map["gallery[$i]"] = await MultipartFile.fromFile(
        uploadedPhotos[i].path,
        filename: "gallery_$i.jpg",
      );
    }
    
    final selectedIdsList = selectedCategoryIds.toList();

    for (int i = 0; i < selectedIdsList.length; i++) {
      map["prv_category_ids[$i]"] = selectedIdsList[i];
    }

    print("🚀 Sending join data:");
    map.forEach((key, value) {
      if (value is MultipartFile) {
        print("📷 $key: [File - ${value.filename}]");
      } else {
        print("🔹 $key: $value");
      }
    });

    final response = await APIService.instance.request(
      Request(
        endPoint: EndPoints.join_as_provider,
        method: RequestMethod.Post,
        header: {
          "Authorization": "Bearer $token",
          
        },
        body: FormData.fromMap(map),
      ),
    );

    isLoading.value = false;

    if (response.success) {
      Get.snackbar(
        "Success",
        "The request has been submitted and will be confirmed soon",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.until((rout) => Pages.home.value == rout.settings.name);
    } else {
      Get.snackbar(
        "Error",
        response.message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: StyleRepo.red,
        colorText: StyleRepo.white,
      );
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetch();
    addressId = TextEditingController();
    cityId = TextEditingController();
    countryId = TextEditingController();
    longitude = TextEditingController();
    latitude = TextEditingController();
    nameProv = TextEditingController();
    email = TextEditingController();
    phoneNumber = TextEditingController();
    gender = TextEditingController();
    street = TextEditingController();
    streetNumber = TextEditingController();
    postCode = TextEditingController();
    city = TextEditingController();
    state = TextEditingController();
    country = TextEditingController();
    description = TextEditingController();
  }

  @override
  void onClose() {
    addressId.dispose();
    cityId.dispose();
    countryId.dispose();
    longitude.dispose();
    latitude.dispose();
    nameProv.dispose();
    email.dispose();
    phoneNumber.dispose();
    gender.dispose();
    street.dispose();
    streetNumber.dispose();
    postCode.dispose();
    city.dispose();
    state.dispose();
    country.dispose();
    description.dispose();
    super.onClose();
  }

  void selectOption(String value) {
    selectedOption.value = value;
    radioError.value = '';
  }

  void toggleSelection(int id) {
    if (selectedCategoryIds.contains(id)) {
      selectedCategoryIds.remove(id);
    } else {
      selectedCategoryIds.add(id);
    }
  }

  bool isSelected(int categoryId) => selectedCategoryIds.contains(categoryId);

  Future<void> pickImageProvider() async {
    final XFile? picked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (picked != null) {
      image.value = picked.path;
    }
  }

  Future<void> pickImageUploadPhoto() async {
    final List<XFile>? images = await ImagePicker().pickMultiImage();
    if (images == null || images.isEmpty) return;

    int total = uploadedPhotos.length + images.length;
    if (total > 10) {
      Get.snackbar(
        tr(LocaleKeys.error),
        tr(LocaleKeys.the_maximum_number_of_images_is_10),
      );
      return;
    }

    uploadedPhotos.addAll(images);
    photoError.value = '';
  }

  bool validateCustomFields() {
    bool isValid = true;

    if (uploadedPhotos.length < 2) {
      
      photoError.value = tr(LocaleKeys.at_least_two_images_must_be_uploaded);
      isValid = false;
    }

    if (selectedOption.value.isEmpty) {
      
      radioError.value = tr(LocaleKeys.select_one_option);
      isValid = false;
    }

    return isValid;
  }

  void onBackStep() {
    if (currentStep.value > 0) currentStep.value--;
  }

  void onNextStep() {
    switch (currentStep.value) {
      case 0:
        if (formKeyStep1.currentState!.validate()) currentStep.value++;
        break;
      case 1:
        if (formKeyStep2.currentState!.validate() && validateCustomFields()) {
          join();
        }
        break;
    }
  }
}
