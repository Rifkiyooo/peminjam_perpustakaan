import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peminjam_perpustakaan_kelas_b/app/routes/app_pages.dart';

import '../../../data/constant/endpoint.dart';
import '../../../data/provider/api_provider.dart';

class RegisterController extends GetxController {final loading = false.obs;
final GlobalKey<FormState> formKey = GlobalKey<FormState>();
final TextEditingController namaController = TextEditingController();
final TextEditingController usernameController = TextEditingController();
final TextEditingController telpController = TextEditingController();
final TextEditingController alamatController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

//final RegisterController registerController = Get.put(RegisterController());
  //TODO: Implement RegisterController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
post() async {
  loading(true);
  try {
    FocusScope.of(Get.context!).unfocus(); //meng close keybord
    formKey.currentState?.save();
    if (formKey.currentState!.validate()) {
      final response = await ApiProvider.instance().post(Endpoint.register,
          data:
          {
            "nama": namaController.text.toString(),
            "username": usernameController.text.toString(),
            "telp": telpController.text.toString(),
            "alamat": alamatController.text.toString(),
            "password": passwordController.text.toString()
          });
      if (response.statusCode == 201) {
        Get.snackbar("Information", "Register Succes", backgroundColor: Colors.green);
        Get.offAllNamed(Routes.LOGIN);
      } else {
        Get.snackbar("Sorry", "Register gagal", backgroundColor: Colors.orange);
      }
    }
    loading(false);
  } on DioException catch (e) {
    loading(false);
    if (e.response != null) {
      if (e.response?.data != null) {
        Get.snackbar("sorry", "${e.response?.data['message']}",
            backgroundColor: Colors.red);
      }
    } else {
      Get.snackbar("Sorry", e.message ?? "", backgroundColor: Colors.red);
    }
  } catch (e) {
    loading(false);
    Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
  }
}
}
