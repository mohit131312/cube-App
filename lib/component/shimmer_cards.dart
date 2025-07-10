import 'package:cube_app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget shimmerCard() {
  return Container(
    alignment: Alignment.center,
    margin: EdgeInsets.symmetric(
      horizontal: SizeConfig.widthMultiplier * 5.5,
    ),
    height: SizeConfig.heightMultiplier * 9,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 2,
          offset: Offset(0, 0),
        )
      ],
    ),
    child: Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListTile(
        leading: Container(
          height: SizeConfig.imageSizeMultiplier * 9,
          width: SizeConfig.imageSizeMultiplier * 9,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            shape: BoxShape.circle,
          ),
        ),
        title: Container(
          height: 20,
          width: double.infinity,
          color: Colors.grey[300],
          margin: EdgeInsets.symmetric(vertical: 8),
        ),
      ),
    ),
  );
}
