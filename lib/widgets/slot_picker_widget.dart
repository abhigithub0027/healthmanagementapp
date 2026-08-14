import 'package:flutter/material.dart';
import '../app/theme.dart';

class SlotPickerWidget extends StatefulWidget {
  final Map<String, List<String>> availableSlots;
  final Function(String selectedDate, String selectedSlot) onSlotSelected;

  const SlotPickerWidget({
    super.key,
    required this.availableSlots,
    required this.onSlotSelected,
  });

  @override
  State<SlotPickerWidget> createState() => _SlotPickerWidgetState();
}

class _SlotPickerWidgetState extends State<SlotPickerWidget> {
  late String _selectedDate;
  late String _selectedTimeSlot;

  @override
  void initState() {
    super.initState();
    if (widget.availableSlots.isNotEmpty) {
      _selectedDate = widget.availableSlots.keys.first;
      final slots = widget.availableSlots[_selectedDate];
      _selectedTimeSlot = (slots != null && slots.isNotEmpty) ? slots.first : '10:30 AM';
    } else {
      _selectedDate = 'TUE OCT 24';
      _selectedTimeSlot = '08:30 AM';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.availableSlots.isEmpty) {
      return const SizedBox();
    }

    final dates = widget.availableSlots.keys.toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Available Appointments',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            Text(
              'Select a time to book',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: dates.map((dateKey) {
              final isSelectedDate = (dateKey == _selectedDate);
              final slots = widget.availableSlots[dateKey] ?? [];

              return Container(
                width: 140,
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isSelectedDate ? Colors.white : Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelectedDate ? AppColors.primary : AppColors.border,
                    width: isSelectedDate ? 2 : 1,
                  ),
                  boxShadow: isSelectedDate
                      ? [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.08),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          )
                        ]
                      : [],
                ),
                child: Column(
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        setState(() {
                          _selectedDate = dateKey;
                          if (slots.isNotEmpty) {
                            _selectedTimeSlot = slots.first;
                          }
                        });
                      },
                      child: Column(
                        children: [
                          Text(
                            dateKey.split(' ').first,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: isSelectedDate ? AppColors.primary : AppColors.textLight,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            dateKey.split(' ').skip(1).join(' '),
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: isSelectedDate ? AppColors.primary : AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    for (final timeSlot in slots) ...[
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedDate = dateKey;
                            _selectedTimeSlot = timeSlot;
                          });
                          widget.onSlotSelected(_selectedDate, _selectedTimeSlot);
                        },
                        child: Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: isSelectedDate && (timeSlot == _selectedTimeSlot)
                                ? AppColors.primary
                                : const Color(0xFFF3F4F6),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              timeSlot,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: isSelectedDate && (timeSlot == _selectedTimeSlot)
                                    ? Colors.white
                                    : AppColors.textPrimary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
