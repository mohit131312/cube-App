import 'dart:convert';
import 'dart:developer';

import 'package:cube_app/cube_engineer/view_test_result/card_details/card_details_model.dart';
import 'package:cube_app/remote_service.dart';
import 'package:get/get.dart';

class CardDetailsController extends GetxController {
  RxList<DetailsResult> viewDetailstestResult = <DetailsResult>[].obs;

  Future getviewTestDetailsResult(cubeId) async {
    viewDetailstestResult.clear();
    try {
      Map<String, dynamic> map = {"cube_register_id": cubeId};

      var response = await RemoteServices.postMethodWithToken(
          'view_detailed_test_result', map);
      log("📥 Raw Response: $response");
      final responseData = jsonDecode(response.body);

      if (responseData.containsKey('token') && responseData['token'] == false) {
        await RemoteServices.handleTokenExpiry();
        return false;
      }
      var project = viewTestDetailsFromJson(response.body);

      if (project.data != null) {
        viewDetailstestResult.assignAll(project.data!);
        print("viewDetailstestResult Count: ${viewDetailstestResult.length}");
      } else {
        viewDetailstestResult.clear();
        print("No project data found.");
      }
      print('viewDetailstestResult Count: ${viewDetailstestResult.length}');
      return true;
    } catch (e) {
      print("Error: $e");
      return true;
    }
  }

  //--------------------
  void resetData() {}

  //-------------------
}
