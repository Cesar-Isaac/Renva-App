import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renvo_app/core/routes/routes.dart';

enum ServiceType { asap, specificDate }

class ControllerStep1 extends GetxController {
  final formKeyStep1 = GlobalKey<FormState>();
  final formKeyStep2 = GlobalKey<FormState>();
  final formKeyStep3 = GlobalKey<FormState>();
  late TextEditingController description;
  late TextEditingController date;
  late TextEditingController time;

  final Rx<TimeOfDay?> selectedTime = Rx<TimeOfDay?>(null);
  final Rx<DateTime?> selectedDate = Rx<DateTime?>(null);

  Future<void> pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      selectedDate.value = picked;
      date.text = picked.toLocal().toString().split(' ')[0]; 
    }
  }

  Future<void> pickTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime.value ?? TimeOfDay.now(),
    );
    if (picked != null) {
      selectedTime.value = picked;
      time.text = picked.format(context); 
    }
  }

  final RxInt currentStep = 0.obs;
  var isLoading = false.obs;
  void onBackStep() {
    if (currentStep.value > 0) currentStep.value--;
  }

  void onNextStep() {
    switch (currentStep.value) {
      case 0:
        if (formKeyStep1.currentState!.validate()) currentStep.value++;
        break;
      case 1:
        if (formKeyStep2.currentState!.validate()) currentStep.value++;
        break;
      case 2:
        if (formKeyStep2.currentState!.validate()) {
          
          Get.toNamed(Pages.home.value);
        }
        break;
    }
  }

  @override
  void onInit() {
    date = TextEditingController();
    time = TextEditingController();
    description = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    date.dispose();
    time.dispose();
    description.dispose();
    super.onClose();
  }



  var selectedType = ServiceType.asap.obs;
}
