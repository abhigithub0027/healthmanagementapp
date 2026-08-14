import 'package:flutter/material.dart';
import '../app/theme.dart';

class DoctorImage extends StatelessWidget {
  final String imagePath;
  final double width;
  final double height;
  final double borderRadius;

  const DoctorImage({
    super.key,
    required this.imagePath,
    this.width = 72,
    this.height = 72,
    this.borderRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.asset(
        imagePath,
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: width,
            height: height,
            color: AppColors.primaryLight,
            child: const Icon(
              Icons.person,
              color: AppColors.primary,
              size: 36,
            ),
          );
        },
      ),
    );
  }
}
