import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'information.dart';

class ContactPageController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  var information = <Information>[].obs;
  int selectedIndex = -1;

  void save() {
    String name = nameController.text.trim();
    String contact = contactController.text.trim();
    if (name.isNotEmpty && contact.isNotEmpty) {
      nameController.clear();
      contactController.clear();
      information.add(Information(name: name, number: contact));
    }
  }

  void updateContact() {
    if (selectedIndex >= 0 && selectedIndex < information.length) {
      String name = nameController.text.trim();
      String contact = contactController.text.trim();
      if (name.isNotEmpty && contact.isNotEmpty) {
        information[selectedIndex] = Information(name: name, number: contact);
        nameController.text = "";
        contactController.text = "";

      }
    }
  }

  void edit(int index) {
    selectedIndex = index;
    nameController.text = information[index].name;
    contactController.text = information[index].number;
  }

  @override
  void onClose() {
    nameController.dispose();
    contactController.dispose();
    super.onClose();
  }
}
