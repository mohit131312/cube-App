import 'dart:convert';
import 'dart:developer';

import 'package:cube_app/cube_lab_operator/select_project_model_opt.dart';
import 'package:cube_app/remote_service.dart';
import 'package:get/get.dart';

class SelectProjectOptController extends GetxController {
  RxList<ProjectModel> assignProject = <ProjectModel>[].obs;

  Future getassignProject(roleId) async {
    try {
      Map<String, dynamic> map = {"role_id": roleId};

      var response =
          await RemoteServices.postMethodWithToken('get_assign_project', map);
      log("📥 Raw Response: $response");
      final responseData = jsonDecode(response.body);

      if (responseData.containsKey('token') && responseData['token'] == false) {
        await RemoteServices.handleTokenExpiry();
        return false;
      }
      var project = assignProjectFromJson(response.body);

      if (project.data != null) {
        assignProject.assignAll(project.data!);
        print("Project Count: ${assignProject.length}");
      } else {
        assignProject.clear();
        print("No project data found.");
      }
      print('Project Count: ${assignProject.length}');
      return true;
    } catch (e) {
      print("Error: $e");
      return true;
    }
  }
}
