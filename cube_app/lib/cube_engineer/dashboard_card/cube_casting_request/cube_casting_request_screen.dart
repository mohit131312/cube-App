import 'package:cube_app/component/app_bottom_button.dart';
import 'package:cube_app/component/app_datepicker_border.dart';
import 'package:cube_app/component/app_notes_textformfeild.dart';
import 'package:cube_app/component/app_search_dropdown.dart';
import 'package:cube_app/component/app_text.dart';
import 'package:cube_app/component/app_textformfeild.dart';
import 'package:cube_app/cube_engineer/dashboard_card/cube_casting_request/cube_casting_request_controller.dart';
import 'package:cube_app/utils/app_color.dart';
import 'package:cube_app/utils/app_const_text.dart';
import 'package:cube_app/utils/app_fontsize.dart';
import 'package:cube_app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CubeCastingRequestScreen extends StatelessWidget {
  CubeCastingRequestScreen({super.key});

  final CubeCastingRequestController cubeCastingRequestController =
      Get.put(CubeCastingRequestController());
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
                      items: cubeCastingRequestController.dummyNames
                          .map(
                            (name) => name,
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
                      items: cubeCastingRequestController.dummyNames
                          .map(
                            (name) => name,
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
                      items: cubeCastingRequestController.dummyNames
                          .map(
                            (name) => name,
                          )
                          .toList(),
                      selectedItem: cubeCastingRequestController
                              .selectElement.value.isNotEmpty
                          ? cubeCastingRequestController
                              .selectConcertOfGrade.value
                          : null,
                      hintText: 'Select Concert Grade',
                      onChanged: (value) {
                        cubeCastingRequestController
                            .selectConcertOfGrade.value = value ?? '';
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
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Cubic Meters cannot be empty';
                      }
                      return null;
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
                    ],
                    onChanged: (value) {},
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
                onLeftTap: () {},
                onRightTap: () {
                  if (_formKey.currentState!.validate()) {
                  } else {}
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
