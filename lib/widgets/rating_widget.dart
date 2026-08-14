import 'package:flutter/material.dart';
import '../app/theme.dart';

class RatingWidget extends StatelessWidget {
  final double rating;
  final String? distance;
  final int? reviewCount;

  const RatingWidget({
    super.key,
    required this.rating,
    this.distance,
    this.reviewCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.star_rounded,
          color: AppColors.starYellow,
          size: 18,
        ),
        const SizedBox(width: 4),
        Text(
          rating.toStringAsFixed(1),
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        if (reviewCount != null) ...[
          const SizedBox(width: 4),
          Text(
            '($reviewCount reviews)',
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
        ],
        if (distance != null && distance!.isNotEmpty) ...[
          const SizedBox(width: 8),
          const Text(
            '•',
            style: TextStyle(color: AppColors.textLight, fontSize: 12),
          ),
          const SizedBox(width: 8),
          const Icon(
            Icons.location_on_outlined,
            color: AppColors.textSecondary,
            size: 14,
          ),
          const SizedBox(width: 2),
          Text(
            distance!,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ],
    );
  }
}
