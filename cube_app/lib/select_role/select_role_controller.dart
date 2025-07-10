import 'dart:convert';
import 'dart:developer';

import 'package:cube_app/remote_service.dart';
import 'package:cube_app/select_role/select_role_model.dart';
import 'package:get/get.dart';

class SelectRoleController extends GetxController {
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    getSelectRole();
  }

  RxList<SelectRole> selectRoles = <SelectRole>[].obs;

  Future<bool> getSelectRole() async {
    isLoading.value = true;

    try {
      Map<String, dynamic> map = {};

      var response = await RemoteServices.postMethodWithToken(
          'get_assign_roles_cube', map);
      log("📥 Raw Response: $response");

      final responseData = jsonDecode(response.body);

      if (responseData.containsKey('token') && responseData['token'] == false) {
        await RemoteServices.handleTokenExpiry();
        isLoading.value = false;

        return false;
      }

      var project = assignRoleFromJson(response.body);

      if (project.data != null) {
        final filteredRoles = project.data!
            .where((role) => [12, 13, 14].contains(role.roleId))
            .toList();

        selectRoles.assignAll(filteredRoles);
        print("Filtered selectRoles Count: ${selectRoles.length}");
      } else {
        selectRoles.clear();
        print("No project data found.");
      }
      isLoading.value = false;

      return true;
    } catch (e) {
      print("Error: $e");
      isLoading.value = false;

      return false;
    }
  }
}
