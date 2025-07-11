import 'dart:developer';

import 'package:cube_app/component/app_bottom_button.dart';
import 'package:cube_app/component/app_date_picker_textform.dart';
import 'package:cube_app/component/app_notes_textformfeild.dart';
import 'package:cube_app/component/app_search_dropdown.dart';
import 'package:cube_app/component/app_text.dart';
import 'package:cube_app/component/app_textformfeild.dart';
import 'package:cube_app/component/cube_test_result_input.dart';
import 'package:cube_app/cube_lab_operator/dashboard_lab_operator/enter_test_result/enter_test_result_controller.dart';

import 'package:cube_app/utils/app_color.dart';
import 'package:cube_app/utils/app_const_text.dart';
import 'package:cube_app/utils/app_fontsize.dart';
import 'package:cube_app/utils/check_internet.dart';
import 'package:cube_app/utils/custom_loader.dart';
import 'package:cube_app/utils/custome_popup.dart';
import 'package:cube_app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class EnterTestResultScreen extends StatelessWidget {
  EnterTestResultScreen({super.key});
  EnterTestResultController enterTestResultController =
      Get.put(EnterTestResultController());
  Future<bool> showConfirmationDialog(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (
        BuildContext context,
      ) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          backgroundColor: Colors.white,
          title: AppText(
            text: 'Are You Sure?',
            fontSize: AppFontsize.textSizeMediumm,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          content: AppText(
              text: 'Are you sure you want to Submit Test Result',
              fontSize: AppFontsize.textSizeSmall,
              fontWeight: FontWeight.w500,
              color: AppColors.searchfeild),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: AppText(
                        text: 'Cancel',
                        fontSize: AppFontsize.textSizeSmallm,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    Navigator.of(context).pop(true);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                        color: AppColors.buttoncolor,
                        borderRadius: BorderRadius.circular(12)),
                    child: AppText(
                        text: 'Yes',
                        fontSize: AppFontsize.textSizeSmallm,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                )
              ],
            )
          ],
        );
      },
    );
    return result ??
        false; // fallback to false if dialog dismissed unexpectedly
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
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
          child: Form(
            key: enterTestResultController.formKey,
            child: Column(
              children: [
                Container(
                  height: 1,
                  color: Colors.white,
                ),
                Container(
                  padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                  decoration: BoxDecoration(
                    color: AppColors.buttoncolor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: SizeConfig.heightMultiplier * 1.5),
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
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'No Of Cube cannot be empty';
                          }
                          return null;
                        },
                        onChanged: (value) async {
                          if (await CheckInternet.checkInternet()) {
                            await enterTestResultController.getBacthData(
                                enterTestResultController.batchnoController.text
                                    .trim());
                          } else {
                            await showDialog(
                              context: Get.context!,
                              builder: (BuildContext context) {
                                return CustomValidationPopup(
                                    icon: Icons.info,
                                    iconColor: AppColors.buttoncolor,
                                    message:
                                        "Please check your internet connection.");
                              },
                            );
                          }
                        },
                      ),
                      Obx(() {
                        final msg = enterTestResultController.msg.value;
                        final batchNo = enterTestResultController
                            .batchnoController.text
                            .trim();

                        // Only show message if batchNo is not empty and msg is not empty
                        if (batchNo.isEmpty || msg.isEmpty) {
                          return SizedBox.shrink();
                        }

                        return Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            msg,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        );
                      }),
                      SizedBox(height: SizeConfig.heightMultiplier * 1.5),
                      AppText(
                        text: AppConstText.scheduledate,
                        fontSize: AppFontsize.textSizeSmall,
                        fontWeight: FontWeight.w400,
                        color: AppColors.primary,
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier * 0.5),
                      Obx(
                        () => AppSearchDropdown(
                          key: enterTestResultController.scheduledateFormKey,
                          items: enterTestResultController.batchNoList
                              .map((batch) => batch.testingDate ?? '')
                              .toList(),
                          selectedItem: enterTestResultController
                                  .scheduleDate.value.isNotEmpty
                              ? enterTestResultController.scheduleDate.value
                              : null,
                          hintText: 'Select  Date',
                          onChanged: (value) {
                            enterTestResultController.scheduleDate.value =
                                value!;
                            final selectedBatch = enterTestResultController
                                .batchNoList
                                .firstWhereOrNull(
                                    (batch) => batch.testingDate == value);

                            if (selectedBatch != null) {
                              final cubeCount = selectedBatch.cubeCount ?? 0;
                              enterTestResultController.cubeCount.value =
                                  cubeCount;
                              enterTestResultController.cubeReuestingId.value =
                                  selectedBatch.id ?? 0;
                              enterTestResultController
                                  .initCubeInputs(cubeCount);
                            }
                            print("📅 Selected schedule date: $value");
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null ||
                                value.toString().trim().isEmpty) {
                              return 'Please select a Date';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier * 1.5),
                      AppText(
                        text: AppConstText.dateoftesting,
                        fontSize: AppFontsize.textSizeSmall,
                        fontWeight: FontWeight.w400,
                        color: AppColors.primary,
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier * 0.5),
                      AppDatePickerTextform(
                        key: enterTestResultController.dateOfTestingFormkey,
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
                Container(
                  padding: EdgeInsets.only(
                      top: SizeConfig.heightMultiplier * 2,
                      bottom: SizeConfig.heightMultiplier * 0.5,
                      left: 20,
                      right: 20),
                  width: SizeConfig.widthMultiplier * 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
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
                      Obx(
                        () => ListView.separated(
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
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier * 5),
                      AppBottomButton(
                          leftText: 'Clear',
                          rightText: 'Send For Approval',
                          onLeftTap: () {
                            enterTestResultController.clearFormData();
                          },
                          onRightTap: () async {
                            if (await CheckInternet.checkInternet()) {
                              bool isValid = await textfeildValidate(context);

                              if (!isValid) {
                                return;
                              }
                              bool confirm =
                                  await showConfirmationDialog(context);
                              log("confirm $confirm");

                              if (confirm) {
                                if (enterTestResultController
                                    .formKey.currentState!
                                    .validate()) {
                                  showLoaderDialog();
                                  bool success = await enterTestResultController
                                      .saveTestResult(context);
                                  Get.back();
                                  if (success) {
                                    Get.back();
                                    showDialog(
                                      context: Get.context!,
                                      builder: (_) => CustomValidationPopup(
                                        message: enterTestResultController
                                            .validatemsg.value,
                                        icon: Icons.check_circle_outline,
                                        iconColor: Colors.green,
                                        onOk: () {},
                                      ),
                                    );
                                  }
                                }
                              }
                            } else {
                              await showDialog(
                                context: Get.context!,
                                builder: (BuildContext context) {
                                  return CustomValidationPopup(
                                      icon: Icons.info,
                                      iconColor: AppColors.buttoncolor,
                                      message:
                                          "Please check your internet connection.");
                                },
                              );
                            }
                          }),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void scrollToWidget(GlobalKey key) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final context = key.currentContext;
      if (context != null) {
        Scrollable.ensureVisible(
          context,
          duration: const Duration(milliseconds: 300),
          alignment: 0.1,
          curve: Curves.easeInOut,
        );
      }
    });
  }

  Future<bool> textfeildValidate(BuildContext context) async {
    if (enterTestResultController.formKey.currentState!.validate()) {}

    if (enterTestResultController.batchnoController.text.trim().isEmpty) {
      FocusScope.of(context)
          .requestFocus(enterTestResultController.batchnoFocusNode);
      return false;
    }
    if (enterTestResultController.scheduleDate.value.trim().isEmpty) {
      scrollToWidget(enterTestResultController.scheduledateFormKey);
      return false;
    }
    if (enterTestResultController.dateTestingController.text.trim().isEmpty) {
      scrollToWidget(enterTestResultController.dateOfTestingFormkey);
      return false;
    }
    if (enterTestResultController.remarkController.text.trim().isEmpty) {
      FocusScope.of(context)
          .requestFocus(enterTestResultController.remarkFocusNode);
      return false;
    }

    for (int i = 0; i < enterTestResultController.cubeCount.value; i++) {
      if (enterTestResultController.lengthControllers[i].text.trim().isEmpty) {
        FocusScope.of(context)
            .requestFocus(enterTestResultController.lengthFocusNodes[i]);
        return false;
      }
      if (enterTestResultController.widthControllers[i].text.trim().isEmpty) {
        FocusScope.of(context)
            .requestFocus(enterTestResultController.widthFocusNodes[i]);
        return false;
      }
      if (enterTestResultController.heightControllers[i].text.trim().isEmpty) {
        FocusScope.of(context)
            .requestFocus(enterTestResultController.heightFocusNodes[i]);
        return false;
      }
      if (enterTestResultController.weightControllers[i].text.trim().isEmpty) {
        FocusScope.of(context)
            .requestFocus(enterTestResultController.weightFocusNodes[i]);
        return false;
      }
      if (enterTestResultController.loadControllers[i].text.trim().isEmpty) {
        FocusScope.of(context)
            .requestFocus(enterTestResultController.loadFocusNodes[i]);
        return false;
      }
    }

    return true; // ✅ All validations passed
  }
}
