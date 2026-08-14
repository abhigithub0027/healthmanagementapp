import 'package:flutter/material.dart';
import '../../app/routes.dart';
import '../../app/theme.dart';
import '../../models/doctor.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/slot_picker_widget.dart';

class AboutDoctorScreen extends StatefulWidget {
  final Doctor doctor;

  const AboutDoctorScreen({
    super.key,
    required this.doctor,
  });

  @override
  State<AboutDoctorScreen> createState() => _AboutDoctorScreenState();
}

class _AboutDoctorScreenState extends State<AboutDoctorScreen> {
  late String _selectedDate;
  late String _selectedTimeSlot;
  int _selectedBottomTab = 2;

  @override
  void initState() {
    super.initState();
    if (widget.doctor.availableSlots.isNotEmpty) {
      _selectedDate = widget.doctor.availableSlots.keys.first;
      final slots = widget.doctor.availableSlots[_selectedDate];
      _selectedTimeSlot =
          (slots != null && slots.isNotEmpty) ? slots.first : '10:30 AM';
    } else {
      _selectedDate = 'TUE OCT 24';
      _selectedTimeSlot = '08:30 AM';
    }
  }

  void _navigateToConfirmation() {
    Navigator.pushNamed(
      context,
      AppRoutes.confirmation,
      arguments: {
        'doctor': widget.doctor,
        'selectedDate': _selectedDate,
        'selectedSlot': _selectedTimeSlot,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final doctor = widget.doctor;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        // centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.primary,
            size: 24,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'HealthBridge',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
            fontSize: 22,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.compare_arrows_sharp,
              size: 26,
              color: AppColors.primary,
            ),
            onPressed: () {},
          ),
          const Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 18,
              backgroundImage: AssetImage('assets/images/userprofile.png'),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Doctor Summary Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Doctor Profile Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      doctor.image,
                      width: 110,
                      height: 110,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 110,
                        height: 110,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFEAF8),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(
                          Icons.person,
                          size: 55,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Doctor Name
                  Text(
                    doctor.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Badges: Specialty & Experience
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFEAF8),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          doctor.specialty.contains('&')
                              ? doctor.specialty.split('&').first.trim()
                              : (doctor.specialty.contains('Specialist')
                                  ? doctor.specialty.replaceAll('Specialist', '').trim()
                                  : doctor.specialty),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3F4F6),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          doctor.experience,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4B5563),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // Bio / About Paragraph
                  Text(
                    doctor.about,
                    style: const TextStyle(
                      fontSize: 13.5,
                      color: Color(0xFF4B5563),
                      height: 1.45,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // ACCEPTED INSURANCE Header
                  const Text(
                    'ACCEPTED INSURANCE',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textLight,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Insurance Chips
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: doctor.insuranceProviders.map((provider) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F5E9),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          provider.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1B5E20),
                            letterSpacing: 0.4,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Available Appointments Section
            SlotPickerWidget(
              availableSlots: doctor.availableSlots,
              onSlotSelected: (date, slot) {
                setState(() {
                  _selectedDate = date;
                  _selectedTimeSlot = slot;
                });
                // _navigateToConfirmation();
              },
            ),

            const SizedBox(height: 12),
            PrimaryButton(
              text: 'Book Appointment',

              icon: Icons.calendar_month_rounded,
              onPressed: _navigateToConfirmation,
            ),

            const SizedBox(height: 20),

            // Call Front Desk Banner
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0x4DE1D4FD),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFE8E1F5), width: 1),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      color: Color(0xFFE5DCF6),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.call,
                      color: AppColors.primary,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Prefer to book over the phone?',
                          style: TextStyle(
                            fontSize: 15,
                            color:  AppColors.textLight,
                          ),
                        ),
                        const SizedBox(height: 4),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 13,
                              color:  AppColors.textLight,
                              height: 1.3,
                            ),
                            children: [
                              TextSpan(
                                  text:
                                      'Call ${doctor.name.split(' ').first} ${doctor.name.split(' ').last}\'s Front Desk Directly at '),
                              TextSpan(
                                text: doctor.phone.isNotEmpty
                                    ? doctor.phone
                                    : '+1 (555) 123-4567',
                                style: const TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: AppColors.textLight,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Open Mon-Fri, 8:00 AM - 5:00 PM EST',
                          style: TextStyle(
                            fontSize: 11,
                            color: AppColors.textLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Office Location Card with Map Preview
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.location_on_outlined,
                          color: AppColors.primary, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Office Location',
                        style: TextStyle(
                          fontSize: 15,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    doctor.location.contains(',')
                        ? doctor.location.split(',').first.trim()
                        : doctor.location,
                    style: const TextStyle(
                      fontSize: 13.5,
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    doctor.location.contains(',')
                        ? doctor.location.split(',').skip(1).join(',').trim()
                        : doctor.hospital,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 14),
                  _buildMapPreview(),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Key Highlights Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildHighlightRow(
                    icon: Icons.verified_outlined,
                    iconColor: AppColors.primary,
                    text: 'Verified Care',
                    isBoldText: true,
                    textColor: AppColors.primary,
                  ),
                  const SizedBox(height: 14),
                  _buildHighlightRow(
                    icon: Icons.star_outline_rounded,
                    iconColor: const Color(0xFFD97706),
                    text: '${doctor.rating} / 5.0 Patient Rating',
                  ),
                  const SizedBox(height: 14),
                  _buildHighlightRow(
                    icon: Icons.thumb_up_outlined,
                    iconColor: const Color(0xFFD97706),
                    text: '98% Recommend ${doctor.name.split(' ').last}',
                  ),
                  const SizedBox(height: 14),
                  _buildHighlightRow(
                    icon: Icons.access_time_rounded,
                    iconColor: const Color(0xFFD97706),
                    text: 'Low wait times (Avg 8 mins)',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildHighlightRow({
    required IconData icon,
    required Color iconColor,
    required String text,
    bool isBoldText = false,
    Color? textColor,
  }) {
    return Row(
      children: [
        Icon(icon, color: iconColor, size: 22),
        const SizedBox(width: 14),
        Text(
          text,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isBoldText ? FontWeight.bold : FontWeight.w500,
            color: textColor ?? AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildMapPreview() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Container(
        height: 130,
        width: double.infinity,
        color: const Color(0xFFE8F5E9),
        child: Stack(
          children: [
            CustomPaint(
              size: const Size(double.infinity, 130),
              painter: _MapPainter(),
            ),
            Positioned(
              bottom: 14,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.circle,
                    size: 14,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFF0ECF8), width: 1)),
      ),
      child: BottomNavigationBar(
        currentIndex: _selectedBottomTab,
        onTap: (index) {
          setState(() {
            _selectedBottomTab = index;
          });
          if (index == 2) {
            Navigator.popUntil(context, ModalRoute.withName(AppRoutes.home));
          }
        },
        elevation: 0,
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textLight,
        selectedLabelStyle: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
        type: BottomNavigationBarType.fixed,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined, size: 20),
            activeIcon: Icon(Icons.calendar_today_rounded, size: 20),
            label: 'Timeline',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.verified_user_outlined, size: 20),
            activeIcon: Icon(Icons.verified_user, size: 20),
            label: 'Coverage',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.search_rounded, size: 20),
            activeIcon: Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: Color(0xFFEFEAF8),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.search_rounded,
                size: 20,
                color: AppColors.primary,
              ),
            ),
            label: 'Search',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded, size: 20),
            activeIcon: Icon(Icons.person_rounded, size: 20),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class _MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final landPaint = Paint()..color = const Color(0xFFE2F3E7);
    final waterPaint = Paint()..color = const Color(0xFF90CAF9);
    final roadPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 9
      ..style = PaintingStyle.stroke;
    final minorRoadPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 4.5
      ..style = PaintingStyle.stroke;

    // Background land
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), landPaint);

    // Water river on bottom left
    final waterPath = Path()
      ..moveTo(0, size.height * 0.45)
      ..cubicTo(size.width * 0.25, size.height * 0.3, size.width * 0.45,
          size.height * 0.75, size.width * 0.35, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(waterPath, waterPaint);

    // Diagonal roads
    canvas.drawLine(Offset(size.width * 0.05, 0),
        Offset(size.width * 0.85, size.height), roadPaint);
    canvas.drawLine(Offset(size.width * 0.25, 0),
        Offset(size.width * 1.05, size.height), roadPaint);
    canvas.drawLine(Offset(-size.width * 0.1, size.height * 0.35),
        Offset(size.width * 0.65, size.height * 1.1), roadPaint);

    // Cross grid roads
    canvas.drawLine(Offset(0, size.height * 0.75),
        Offset(size.width, size.height * 0.2), roadPaint);
    canvas.drawLine(Offset(0, size.height * 0.35),
        Offset(size.width, -size.height * 0.15), roadPaint);
    canvas.drawLine(Offset(size.width * 0.15, size.height),
        Offset(size.width * 0.75, 0), minorRoadPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
