import 'package:cube_app/component/app_bottom_button.dart';
import 'package:cube_app/component/app_datepicker_border.dart';
import 'package:cube_app/component/app_notes_textformfeild.dart';
import 'package:cube_app/component/app_search_dropdown.dart';
import 'package:cube_app/component/app_text.dart';
import 'package:cube_app/component/app_textformfeild.dart';
import 'package:cube_app/cube_engineer/dashboard_card/cube_casting_request/cube_casting_request_controller.dart';
import 'package:cube_app/utils/app_color.dart';
import 'package:cube_app/utils/app_confimationdialog.dart';
import 'package:cube_app/utils/app_const_text.dart';
import 'package:cube_app/utils/app_fontsize.dart';
import 'package:cube_app/utils/custom_loader.dart';
import 'package:cube_app/utils/custome_popup.dart';
import 'package:cube_app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CubeCastingRequestScreen extends StatelessWidget {
  final int projectId;
  final String projectName;
  final int buildingId;

  CubeCastingRequestScreen({
    super.key,
    required this.projectId,
    required this.projectName,
    required this.buildingId,
  });
  final CubeCastingRequestController cubeCastingRequestController = Get.find();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          scrolledUnderElevation: 0.0,
          elevation: 0,
          backgroundColor: AppColors.buttoncolor,
          foregroundColor: AppColors.buttoncolor,
          toolbarHeight: SizeConfig.heightMultiplier * 10,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: AppConstText.cubeCastingRequest,
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
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  AppText(
                    text: AppConstText.requestForCubeCasting,
                    fontSize: AppFontsize.textSizeSmallm,
                    fontWeight: FontWeight.w500,
                    color: AppColors.secondaryText,
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier * 3),
                  AppText(
                    text: AppConstText.leveloFConcerting,
                    fontSize: AppFontsize.textSizeSmall,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryText,
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier * 1),
                  Obx(
                    () => AppSearchDropdown(
                      key: cubeCastingRequestController.concertingKey,
                      items: cubeCastingRequestController.concertingLevelList
                          .map(
                            (name) => name.floorName!,
                          )
                          .toList(),
                      selectedItem: cubeCastingRequestController
                              .selectLevelOfConcerting.value.isNotEmpty
                          ? cubeCastingRequestController
                              .selectLevelOfConcerting.value
                          : null,
                      hintText: 'Select Level of Concreting',
                      onChanged: (value) {
                        cubeCastingRequestController
                            .selectLevelOfConcerting.value = value ?? '';
                        final selected = cubeCastingRequestController
                            .concertingLevelList
                            .firstWhereOrNull((e) => e.floorName == value);
                        cubeCastingRequestController
                            .selectLevelOfConcertingId.value = selected?.id;
                        cubeCastingRequestController.printSelectedValues();
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.toString().trim().isEmpty) {
                          return 'Please select a Level of Concreting';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier * 2),
                  AppText(
                    text: AppConstText.element,
                    fontSize: AppFontsize.textSizeSmall,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryText,
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier * 1),
                  Obx(
                    () => AppSearchDropdown(
                      key: cubeCastingRequestController.elementKey,
                      items: cubeCastingRequestController.elementList
                          .map(
                            (ele) => ele.elementName!,
                          )
                          .toList(),
                      selectedItem: cubeCastingRequestController
                              .selectElement.value.isNotEmpty
                          ? cubeCastingRequestController.selectElement.value
                          : null,
                      hintText: 'Select Element',
                      onChanged: (value) {
                        cubeCastingRequestController.selectElement.value =
                            value ?? '';
                        final selected = cubeCastingRequestController
                            .elementList
                            .firstWhereOrNull((e) => e.elementName == value);
                        cubeCastingRequestController.selectElementId.value =
                            selected?.id;
                        cubeCastingRequestController.printSelectedValues();
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.toString().trim().isEmpty) {
                          return 'Please select a Element';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier * 2),
                  AppText(
                    text: AppConstText.concrateGrade,
                    fontSize: AppFontsize.textSizeSmall,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryText,
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier * 1),
                  Obx(
                    () => AppSearchDropdown(
                      key: cubeCastingRequestController.gradeKey,
                      items: cubeCastingRequestController.concrateGradeList
                          .map(
                            (name) => name.gradeName!,
                          )
                          .toList(),
                      selectedItem: cubeCastingRequestController
                              .selectConcertOfGrade.value.isNotEmpty
                          ? cubeCastingRequestController
                              .selectConcertOfGrade.value
                          : null,
                      hintText: 'Select Concert Grade',
                      onChanged: (value) {
                        cubeCastingRequestController
                            .selectConcertOfGrade.value = value ?? '';
                        final selected = cubeCastingRequestController
                            .concrateGradeList
                            .firstWhereOrNull((e) => e.gradeName == value);
                        cubeCastingRequestController
                            .selectConcertOfGradeId.value = selected?.id;
                        cubeCastingRequestController.printSelectedValues();
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.toString().trim().isEmpty) {
                          return 'Please select a Concert Grade';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier * 2),
                  AppText(
                    key: cubeCastingRequestController.castingKey,
                    text: AppConstText.proposedDate,
                    fontSize: AppFontsize.textSizeSmall,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryText,
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier * 1),
                  AppDatepickerBorder(
                    controller: cubeCastingRequestController.dateController,
                    onDateSelected: (date) =>
                        cubeCastingRequestController.updateDate(date),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a date';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier * 2),
                  AppText(
                    text: AppConstText.cubicMeters,
                    fontSize: AppFontsize.textSizeSmall,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryText,
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier * 1),
                  AppTextFormfeild(
                    controller:
                        cubeCastingRequestController.cubicMeterController,
                    hintText: 'Cubic Meters',
                    focusNode: cubeCastingRequestController.cubicMeterFocusNode,
                    onFieldSubmitted: (_) {
                      cubeCastingRequestController.cubicMeterFocusNode
                          .unfocus();
                    },
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Cubic Meters cannot be empty';
                      }
                      final numValue = int.tryParse(value.trim());
                      if (numValue == null || numValue < 0 || numValue > 500) {
                        return 'Enter a value between 0 and 500';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      LengthLimitingTextInputFormatter(3),
                    ],
                    onChanged: (value) {
                      final cubicMeter = int.tryParse(value.trim());

                      if (cubicMeter != null) {
                        final samples = cubeCastingRequestController
                            .calculateCubes(cubicMeter);
                        cubeCastingRequestController.noOfCubeController.text =
                            samples?.toString() ?? '';
                      } else {
                        cubeCastingRequestController.noOfCubeController.text =
                            '';
                      }
                    },
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier * 2),
                  AppText(
                    text: AppConstText.noOfCubeRequired,
                    fontSize: AppFontsize.textSizeSmall,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryText,
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier * 1),
                  AppTextFormfeild(
                    readOnly: true,
                    fillColor: AppColors.textdisableColor,
                    controller: cubeCastingRequestController.noOfCubeController,
                    hintText: 'No of Cube',
                    focusNode: cubeCastingRequestController.noOfCubeFocusNode,
                    onFieldSubmitted: (_) {
                      cubeCastingRequestController.noOfCubeFocusNode.unfocus();
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
                  SizedBox(height: SizeConfig.heightMultiplier * 2),
                  AppText(
                    text: AppConstText.notes,
                    fontSize: AppFontsize.textSizeSmall,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryText,
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier * 1),
                  AppNotesTextformfeild(
                    controller: cubeCastingRequestController.notesController,
                    hintText: 'Enter here....',
                    focusNode: cubeCastingRequestController.notesFocusNode,
                    onFieldSubmitted: (_) {
                      cubeCastingRequestController.notesFocusNode.unfocus();
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
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
                    ],
                    onChanged: (value) {},
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(
            vertical: SizeConfig.heightMultiplier * 1,
            horizontal: SizeConfig.widthMultiplier * 4,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppBottomButton(
                  leftText: 'Clear',
                  rightText: 'Send For Approval',
                  onLeftTap: () async {
                    await cubeCastingRequestController.resetFormData();
                  },
                  onRightTap: () async {
                    await textfeildValidate(context);
                    if (_formKey.currentState!.validate()) {
                      showDialog(
                        context: context,
                        builder: (dialogContext) => ConfirmationDialog(
                          title: 'Are You Sure?',
                          message: 'You want to send data for Approval?',
                          onConfirm: () async {
                            Navigator.of(dialogContext).pop();

                            showLoaderDialog();

                            var success = await cubeCastingRequestController
                                .postForApproval(
                              projectId,
                              buildingId,
                              cubeCastingRequestController
                                  .selectLevelOfConcertingId.value,
                              cubeCastingRequestController
                                  .selectElementId.value,
                              cubeCastingRequestController
                                  .selectConcertOfGradeId.value,
                              cubeCastingRequestController.dateController.text
                                  .trim(),
                              cubeCastingRequestController
                                  .cubicMeterController.text
                                  .trim(),
                              cubeCastingRequestController
                                  .noOfCubeController.text
                                  .trim(),
                              cubeCastingRequestController.notesController.text
                                  .trim(),
                              context,
                            );

                            Get.back();

                            if (success) {
                              Get.back();

                              showDialog(
                                context: Get.context!,
                                builder: (_) => CustomValidationPopup(
                                  message: success
                                      ? "Casting Request Sent For Approval Successfully"
                                      : "Something went wrong. Please try again.",
                                  icon: success
                                      ? Icons.check_circle_outline
                                      : Icons.error_outline,
                                  iconColor:
                                      success ? Colors.green : Colors.red,
                                  onOk: () {},
                                ),
                              );
                            }
                          },
                          onCancel: () {
                            Navigator.of(dialogContext).pop();
                          },
                        ),
                      );
                    }
                  }),
            ],
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

  Future<void> textfeildValidate(BuildContext context) async {
    if (cubeCastingRequestController.selectLevelOfConcerting.value
        .trim()
        .isEmpty) {
      scrollToWidget(cubeCastingRequestController.concertingKey);
      return;
    }

    if (cubeCastingRequestController.selectElement.value.trim().isEmpty) {
      scrollToWidget(cubeCastingRequestController.elementKey);
      return;
    }
    if (cubeCastingRequestController.selectConcertOfGrade.value
        .trim()
        .isEmpty) {
      scrollToWidget(cubeCastingRequestController.gradeKey);
      return;
    }
    if (cubeCastingRequestController.dateController.text.trim().isEmpty) {
      scrollToWidget(cubeCastingRequestController.castingKey);
      return;
    }
    if (cubeCastingRequestController.cubicMeterController.text.trim().isEmpty) {
      FocusScope.of(context)
          .requestFocus(cubeCastingRequestController.cubicMeterFocusNode);
      return;
    }
    if (cubeCastingRequestController.notesController.text.trim().isEmpty) {
      FocusScope.of(context)
          .requestFocus(cubeCastingRequestController.notesFocusNode);
      return;
    }
  }
}
