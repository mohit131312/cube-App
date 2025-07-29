import 'package:cube_app/component/app_text.dart';
import 'package:cube_app/utils/app_color.dart';
import 'package:cube_app/utils/app_fontsize.dart';
import 'package:cube_app/utils/color_loader.dart';
import 'package:cube_app/utils/size_config.dart';
import 'package:flutter/material.dart';

class CustomLoadingPopup extends StatelessWidget {
  const CustomLoadingPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  Widget dialogContent(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.all(Radius.circular(4 * SizeConfig.widthMultiplier)),
      ),
      child: Stack(
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Center(
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ColorLoader(),
                      AppText(
                          text: "Please wait..",
                          fontSize: AppFontsize.textSizeMediumm,
                          color: AppColors.buttoncolor,
                          fontWeight: FontWeight.w700),
                    ],
                  ),
                ],
              ) //
                  ),
              SizedBox(height: 6 * SizeConfig.widthMultiplier),
            ],
          ),
        ],
      ),
    );
  }
}
