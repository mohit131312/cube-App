import 'package:cube_app/component/app_bottom_button.dart';
import 'package:cube_app/component/app_datepicker.dart';
import 'package:cube_app/component/app_notes_textformfeild.dart';
import 'package:cube_app/component/app_text.dart';
import 'package:cube_app/component/app_textformfeild.dart';
import 'package:cube_app/component/cube_test_result_input.dart';
import 'package:cube_app/lab_operator/enter_test_result/enter_test_result_controller.dart';

import 'package:cube_app/utils/app_color.dart';
import 'package:cube_app/utils/app_const_text.dart';
import 'package:cube_app/utils/app_fontsize.dart';
import 'package:cube_app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class EnterTestResultScreen extends StatelessWidget {
  EnterTestResultScreen({super.key});
  EnterTestResultController enterTestResultController =
      Get.put(EnterTestResultController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          elevation: 0,
          backgroundColor: AppColors.buttoncolor,
          foregroundColor: AppColors.buttoncolor,
          toolbarHeight: SizeConfig.heightMultiplier * 8,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: AppConstText.enterTestResult,
                fontSize: AppFontsize.textSizeMedium,
                fontWeight: FontWeight.w500,
                color: AppColors.primary,
              ),
            ],
          ),
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 5, top: 12, bottom: 12),
              child: Image.asset(
                'assets/icons/forward_Arrow.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                width: SizeConfig.widthMultiplier * 100,
                height: SizeConfig.heightMultiplier * 100,
                decoration: BoxDecoration(
                  color: AppColors.buttoncolor,
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 1,
                  color: Colors.white,
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: SizeConfig.heightMultiplier * 2),
                      AppText(
                        text: AppConstText.cubetest,
                        fontSize: AppFontsize.textSizeSmallm,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primary,
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier * 1.5),
                      AppText(
                        text: AppConstText.bactchno,
                        fontSize: AppFontsize.textSizeSmall,
                        fontWeight: FontWeight.w400,
                        color: AppColors.primary,
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier * 0.5),
                      AppTextFormfeild(
                        controller: enterTestResultController.batchnoController,
                        hintText: 'Enter Batch Number',
                        focusNode: enterTestResultController.batchnoFocusNode,
                        onFieldSubmitted: (_) {
                          enterTestResultController.batchnoFocusNode.unfocus();
                        },
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'No Of Cube cannot be empty';
                          }
                          return null;
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        onChanged: (value) {},
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier * 1.5),
                      AppText(
                        text: AppConstText.scheduledate,
                        fontSize: AppFontsize.textSizeSmall,
                        fontWeight: FontWeight.w400,
                        color: AppColors.primary,
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier * 0.5),
                      Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: AppColors.primary,
                              width: 1,
                            ),
                          ),
                          child: AppDatepicker(
                            controller:
                                enterTestResultController.dateController,
                            onDateSelected: (date) =>
                                enterTestResultController.updateDate(date),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select a date';
                              }
                              return null;
                            },
                          )),
                      SizedBox(height: SizeConfig.heightMultiplier * 1.5),
                      AppText(
                        text: AppConstText.dateoftesting,
                        fontSize: AppFontsize.textSizeSmall,
                        fontWeight: FontWeight.w400,
                        color: AppColors.primary,
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier * 0.5),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColors.primary,
                            width: 1,
                          ),
                        ),
                        child: AppDatepicker(
                          controller:
                              enterTestResultController.dateTestingController,
                          onDateSelected: (date) =>
                              enterTestResultController.updateTestingDate(date),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select a date';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier * 1.5),
                      AppText(
                        text: AppConstText.notes,
                        fontSize: AppFontsize.textSizeSmall,
                        fontWeight: FontWeight.w400,
                        color: AppColors.primary,
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier * 0.5),
                      AppNotesTextformfeild(
                        controller: enterTestResultController.remarkController,
                        hintText: 'Enter here....',
                        focusNode: enterTestResultController.remarkFocusNode,
                        onFieldSubmitted: (_) {
                          enterTestResultController.remarkFocusNode.unfocus();
                        },
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Notes cannot be empty';
                          }
                          return null;
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'[a-zA-Z\s]')),
                        ],
                        onChanged: (value) {},
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                top: SizeConfig.heightMultiplier * 52,
                child: Container(
                  padding: EdgeInsets.only(
                      top: SizeConfig.heightMultiplier * 2,
                      bottom: SizeConfig.heightMultiplier * 0.5,
                      left: 20,
                      right: 20),
                  width: SizeConfig.widthMultiplier * 100,
                  height: SizeConfig.heightMultiplier * 64,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        AppText(
                          text: "Enter Cube Test Result",
                          fontSize: AppFontsize.textSizeSmall,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryText,
                        ),
                        SizedBox(height: SizeConfig.heightMultiplier * 0.5),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: enterTestResultController.cubeCount.value,
                          separatorBuilder: (_, __) => SizedBox(height: 16),
                          itemBuilder: (context, index) {
                            return CubeTestResultInputCard(
                              title: "${index + 1}",
                              lengthController: enterTestResultController
                                  .lengthControllers[index],
                              lengthFocusNode: enterTestResultController
                                  .lengthFocusNodes[index],
                              widthController: enterTestResultController
                                  .widthControllers[index],
                              widthFocusNode: enterTestResultController
                                  .widthFocusNodes[index],
                              heightController: enterTestResultController
                                  .heightControllers[index],
                              heightFocusNode: enterTestResultController
                                  .heightFocusNodes[index],
                              weightController: enterTestResultController
                                  .weightControllers[index],
                              weightFocusNode: enterTestResultController
                                  .weightFocusNodes[index],
                              loadController: enterTestResultController
                                  .loadControllers[index],
                              loadFocusNode: enterTestResultController
                                  .loadFocusNodes[index],
                            );
                          },
                        ),
                        SizedBox(height: SizeConfig.heightMultiplier * 5),
                        AppBottomButton(
                          leftText: 'Clear',
                          rightText: 'Send For Approval',
                          onLeftTap: () {},
                          onRightTap: () {
                            // if (_formKey.currentState!.validate()) {
                            // } else {}
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
