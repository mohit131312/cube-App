import 'dart:convert';
import 'dart:developer';

import 'package:cube_app/remote_service.dart';
import 'package:cube_app/select_role/select_role_model.dart';
import 'package:get/get.dart';

import 'user_profile_model.dart';

class SelectRoleController extends GetxController {
  RxBool isLoading = true.obs;
 // Check environment based on base URL
  bool get isLocalEnvironment =>
      RemoteServices.baseUrl.contains('192.168.');

  bool get isStagingEnvironment =>
      RemoteServices.baseUrl.contains('34.133.');

 bool get isProdEnvironment =>
      RemoteServices.baseUrl.contains('12.444');
  @override
  void onInit() {
    super.onInit();
    getSelectRole();
    getuserprofile();
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

      // if (project.data != null) {
      //   final filteredRoles = project.data!
      //       .where((role) => [12, 13, 14].contains(role.roleId))
      //       .toList();

      //   selectRoles.assignAll(filteredRoles);
      //   print("Filtered selectRoles Count: ${selectRoles.length}");
      // } else {
      //   selectRoles.clear();
      //   print("No project data found.");
      // }
      // isLoading.value = false;

      // return true;

       final allRoles = project.data!;

        // Main & fallback roles
        final primaryRoles = allRoles.where((role) => [12, 13, 14].contains(role.roleId)).toList();
        final fallbackRoles = allRoles.where((role) => [44, 45, 46].contains(role.roleId)).toList();
        final prodRoles = allRoles.where((role) => [20, 21, 22].contains(role.roleId)).toList();

        if (primaryRoles.isNotEmpty) {
          selectRoles.assignAll(primaryRoles);
          print("✔️ Using primary roles (12, 13, 14): ${selectRoles.length}");
        } else if (fallbackRoles.isNotEmpty) {
          selectRoles.assignAll(fallbackRoles);
          print("⚠️ Using fallback roles (44, 45, 46): ${selectRoles.length}");
        } else if(prodRoles.isNotEmpty){
          selectRoles.assignAll(prodRoles);
          print("⚠️ Using prod roles (20, 21, 22): ${selectRoles.length}");
        }
        
        else {
          selectRoles.clear();
          print("❌ No matching roles found.");
        }
     

      isLoading.value = false;
      return true;
    } catch (e) {
      print("Error: $e");
      isLoading.value = false;

      return false;
    }
  }

  var userProfile = <String, dynamic>{}.obs;

  Future<bool> getuserprofile() async {
    try {
      Map<String, dynamic> map = {};

      var response =
          await RemoteServices.postMethodWithToken('get_user_profile', map);
      log("📥 Raw Response: ${response.body}");

      final responseData = jsonDecode(response.body);

      if (responseData.containsKey('token') && responseData['token'] == false) {
        await RemoteServices.handleTokenExpiry();
        return false;
      }

      var project = await userProfileFromJson(response.body);

      if (project.data != null) {
        userProfile.value = project.data!.toJson(); // <-- Observable update
        print("User loaded: ${userProfile['first_name']}");
      } else {
        userProfile.value = {};
        print("No user profile data found.");
      }

      return true;
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }
}
