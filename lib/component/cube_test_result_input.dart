import 'package:cube_app/component/app_text.dart';
import 'package:cube_app/component/app_textformfeild_small.dart';
import 'package:cube_app/utils/app_color.dart';
import 'package:cube_app/utils/app_fontsize.dart';
import 'package:cube_app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CubeTestResultInputCard extends StatelessWidget {
  final String title;
  final TextEditingController lengthController;
  final FocusNode lengthFocusNode;

  final TextEditingController widthController;
  final FocusNode widthFocusNode;

  final TextEditingController heightController;
  final FocusNode heightFocusNode;

  final TextEditingController weightController;
  final FocusNode weightFocusNode;

  final TextEditingController loadController;
  final FocusNode loadFocusNode;

  const CubeTestResultInputCard({
    super.key,
    required this.title,
    required this.lengthController,
    required this.lengthFocusNode,
    required this.widthController,
    required this.widthFocusNode,
    required this.heightController,
    required this.heightFocusNode,
    required this.weightController,
    required this.weightFocusNode,
    required this.loadController,
    required this.loadFocusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 1.5,
              color: AppColors.buttoncolor,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                height: 36,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                  color: AppColors.buttoncolor,
                ),
                child: AppText(
                    text: title,
                    fontSize: AppFontsize.textSizeMedium,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left column
                    SizedBox(
                      width: SizeConfig.widthMultiplier * 38,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildField(
                            label: "Length (mm)",
                            controller: lengthController,
                            focusNode: lengthFocusNode,
                          ),
                          SizedBox(height: SizeConfig.heightMultiplier * 1.3),
                          _buildField(
                            label: "Height (mm)",
                            controller: heightController,
                            focusNode: heightFocusNode,
                          ),
                          SizedBox(height: SizeConfig.heightMultiplier * 1.3),
                          _buildField(
                            label: "Load (kn)",
                            controller: loadController,
                            focusNode: loadFocusNode,
                          ),
                        ],
                      ),
                    ),
                    // Right column
                    SizedBox(
                      width: SizeConfig.widthMultiplier * 38,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildField(
                            label: "Width (mm)",
                            controller: widthController,
                            focusNode: widthFocusNode,
                          ),
                          SizedBox(height: SizeConfig.heightMultiplier * 1.3),
                          _buildField(
                            label: "Weight (mm)",
                            controller: weightController,
                            focusNode: weightFocusNode,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    required FocusNode focusNode,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: label,
          fontSize: AppFontsize.textSizeExtraSmall,
          fontWeight: FontWeight.w500,
          color: AppColors.textcolorgrey,
        ),
        SizedBox(height: SizeConfig.heightMultiplier * 1),
        AppTextformfeildSmall(
          controller: controller,
          hintText: 'Enter ${label.split(' ')[0]}',
          focusNode: focusNode,
          onFieldSubmitted: (_) => focusNode.unfocus(),
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          validator: (value) {
            final cleanLabel = label.replaceAll(
                RegExp(r'\s*\(.*?\)'), ''); // removes (mm), (kg), etc.
            if (value == null || value.trim().isEmpty) {
              return '$cleanLabel cannot be empty';
            }
            return null;
          },
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
          ],
          onChanged: (value) {},
        ),
      ],
    );
  }
}
