import 'package:flutter/material.dart';
import '../../app/routes.dart';
import '../../app/theme.dart';
import '../../models/doctor.dart';
import '../../widgets/doctor_image.dart';
import '../../widgets/primary_button.dart';

class AppointmentConfirmationScreen extends StatefulWidget {
  final Doctor doctor;
  final String selectedSlot;
  final String selectedDate;

  const AppointmentConfirmationScreen({
    super.key,
    required this.doctor,
    required this.selectedSlot,
    required this.selectedDate,
  });

  @override
  State<AppointmentConfirmationScreen> createState() =>
      _AppointmentConfirmationScreenState();
}

class _AppointmentConfirmationScreenState
    extends State<AppointmentConfirmationScreen> {
  bool _syncGoogleCalendar = true;
  bool _turnOffDuplicateSms = false;
  bool _sendReceiptToCaregiver = false;

  @override
  Widget build(BuildContext context) {
    final doctor = widget.doctor;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),

      // ============================================================
      // TOP HEADER
      // ============================================================
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(78),
        child: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xFFFCF7FF),
          automaticallyImplyLeading: false,
          titleSpacing: 20,
          title: Row(
            children: [
              CircleAvatar(
                radius: 22, // half of your 54 width/height
                backgroundColor: const Color(0xFFEAF0F4),
                child: Image.asset("assets/images/avatar.png")
              ),

              const SizedBox(width: 14),

              const Text(
                'HealthBridge',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF563B95),
                  letterSpacing: -0.8,
                ),
              ),

              const Spacer(),

              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.swap_horiz_rounded,
                  size: 30,
                  color: Color(0xFF563B95),
                ),
              ),
            ],
          ),
        ),
      ),

      // ============================================================
      // BODY
      // ============================================================
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(18, 38, 18, 24),
          child: Column(
            children: [
              // ======================================================
              // SUCCESS ICON
              // ======================================================
              Container(
                width: 64,
                height: 64,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFD1A945),
                ),
                child: Center(
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF6A5000),
                    ),
                    child: const Icon(
                      Icons.check_rounded,
                      color: Color(0xFFD1A945),
                      size: 27,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 27),

              // ======================================================
              // BOOKING CONFIRMED
              // ======================================================
              const Text(
                'Booking Confirmed',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF202027),
                  letterSpacing: -0.7,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Your appointment has been successfully\nscheduled.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  height: 1.45,
                  color: Color(0xFF5E5B68),
                ),
              ),

              const SizedBox(height: 42),

              // ======================================================
              // APPOINTMENT DETAILS CARD
              // ======================================================
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.035),
                      blurRadius: 18,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25, 28, 25, 27),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ==================================================
                          // PHYSICIAN
                          // ==================================================
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'PHYSICIAN',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF594294),
                                        letterSpacing: 0.5,
                                      ),
                                    ),

                                    const SizedBox(height: 8),

                                    Text(
                                      doctor.name,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFF29282F),
                                        letterSpacing: -0.4,
                                      ),
                                    ),

                                    const SizedBox(height: 3),

                                    Text(
                                      doctor.specialty,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Color(0xFF5D5965),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(width: 12),

                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: DoctorImage(
                                  imagePath: doctor.image,
                                  width: 56,
                                  height: 56,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 32),

                          // ==================================================
                          // DATE & TIME
                          // ==================================================
                          _buildInfoRow(
                            icon: Icons.calendar_today_rounded,
                            title: 'DATE & TIME',
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.selectedDate,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF29282F),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '${widget.selectedSlot} EST',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF5D5965),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 27),

                          // ==================================================
                          // LOCATION
                          // ==================================================
                          _buildInfoRow(
                            icon: Icons.location_on_outlined,
                            title: 'LOCATION',
                            child: Text(
                              doctor.location,
                              style: const TextStyle(
                                fontSize: 20,
                                height: 1.45,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF29282F),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // ======================================================
                    // DASHED DIVIDER
                    // ======================================================
                    _buildDashedDivider(),

                    // ======================================================
                    // PAYMENT SECTION
                    // ======================================================
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25, 28, 25, 28),
                      child: Column(
                        children: [
                          _buildCostRow(
                            'Consultation Fee',
                            '\$${doctor.consultationFee.toStringAsFixed(2)}',
                            strikeThrough: true,
                          ),

                          const SizedBox(height: 17),

                          _buildCostRow(
                            'Insurance Coverage',
                            '- \$${doctor.insuranceCoverage.toStringAsFixed(2)}',
                            isDiscount: true,
                          ),

                          const SizedBox(height: 22),

                          const Divider(height: 1, color: Color(0xFFD0C7DB)),

                          const SizedBox(height: 23),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Expanded(
                                child: Text(
                                  'Total Due',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF29282F),
                                  ),
                                ),
                              ),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '\$${(doctor.consultationFee - doctor.insuranceCoverage).clamp(0.0, 9999.0).toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF563B95),
                                    ),
                                  ),

                                  const SizedBox(height: 4),

                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 9,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE5F4E8),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: const Text(
                                      'FULLY COVERED',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFF388E3C),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          const SizedBox(height: 57),

                          // ==================================================
                          // CONFIRMATION ID
                          // ==================================================
                          const Center(
                            child: Text(
                              'CONFIRMATION ID: HB-992-04X',
                              style: TextStyle(
                                fontSize: 10,
                                color: Color(0xFFB4B0BA),
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // ============================================================
              // PREFERENCES CARD
              // ============================================================
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.035),
                      blurRadius: 12,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SwitchListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 9,
                      ),
                      value: _syncGoogleCalendar,
                      activeTrackColor: const Color(0xFF563B95),
                      activeThumbColor: const Color(0xFF9287A5),
                      onChanged: (val) {
                        setState(() {
                          _syncGoogleCalendar = val;
                        });
                      },
                      title: const Text(
                        'Automatically sync to my\nGoogle Calendar',
                        style: TextStyle(
                          fontSize: 16,
                          height: 1.4,
                          color: Color(0xFF29282F),
                        ),
                      ),
                    ),

                    const Divider(
                      height: 1,
                      indent: 22,
                      endIndent: 22,
                      color: Color(0xFFF0EEF2),
                    ),

                    SwitchListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 9,
                      ),
                      value: _turnOffDuplicateSms,
                      activeTrackColor: const Color(0xFF563B95),
                      activeThumbColor: const Color(0xFF9287A5),
                      onChanged: (val) {
                        setState(() {
                          _turnOffDuplicateSms = val;
                        });
                      },
                      title: const Text(
                        'Turn off duplicate SMS alerts',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF29282F),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 22),

              // ============================================================
              // SEND RECEIPT TO CAREGIVER
              // ============================================================
              GestureDetector(
                onTap: () {
                  setState(() {
                    _sendReceiptToCaregiver = !_sendReceiptToCaregiver;
                  });
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 22,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFFDCD2EB),
                      width: 1.4,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.forum_outlined,
                        color: Color(0xFF563B95),
                        size: 30,
                      ),

                      const SizedBox(width: 14),

                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.messenger_outline,
                              color: Colors.white,
                              size: 20,
                            ),

                            const SizedBox(width: 8),

                            Expanded(
                              child: Text(
                                'Send appointment receipt details '
                                    'to family or caregiver via text '
                                    'message',
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontSize: 16,
                                  height: 1.45,
                                  color: Color(0xFF563B95),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 22),

              // ============================================================
              // DONE BUTTON
              // ============================================================
              SizedBox(
                width: double.infinity,
                height: 64,
                child: PrimaryButton(
                  backgroundColor: AppColors.primary,
                  text: 'Done',
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutes.home,
                      (route) => false,
                    );
                  },
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),

      // ================================================================
      // BOTTOM NAVIGATION
      // UI ONLY - NO NAVIGATION LOGIC CHANGED
      // ================================================================
      bottomNavigationBar: Container(
        height: 82,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0x12000000),
              blurRadius: 12,
              offset: Offset(0, -3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildBottomItem(
              icon: Icons.calendar_month_outlined,
              label: 'Timeline',
            ),
            _buildBottomItem(
              icon: Icons.verified_user_outlined,
              label: 'Coverage',
            ),
            _buildBottomItem(
              icon: Icons.search_rounded,
              label: 'Search',
              selected: true,
            ),
            _buildBottomItem(
              icon: Icons.account_circle_outlined,
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  // ======================================================================
  // INFO ROW
  // ======================================================================
  Widget _buildInfoRow({
    required IconData icon,
    required String title,
    required Widget child,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFF6F0FA),
          ),
          child: Icon(icon, color: const Color(0xFF563B95), size: 27),
        ),

        const SizedBox(width: 18),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF898491),
                  letterSpacing: 0.4,
                ),
              ),

              const SizedBox(height: 4),

              child,
            ],
          ),
        ),
      ],
    );
  }

  // ======================================================================
  // COST ROW
  // ======================================================================
  Widget _buildCostRow(
    String title,
    String amount, {
    bool isDiscount = false,
    bool strikeThrough = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, color: Color(0xFF29282F)),
        ),

        Text(
          amount,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: isDiscount
                ? const Color(0xFF29282F)
                : const Color(0xFF96939A),
            decoration: strikeThrough ? TextDecoration.lineThrough : null,
          ),
        ),
      ],
    );
  }

  // ======================================================================
  // DASHED DIVIDER
  // ======================================================================
  Widget _buildDashedDivider() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          children: List.generate((constraints.maxWidth / 7).floor(), (index) {
            return Expanded(
              child: Container(
                height: 1,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                color: index.isEven
                    ? const Color(0xFFD8D0DE)
                    : Colors.transparent,
              ),
            );
          }),
        );
      },
    );
  }

  // ======================================================================
  // BOTTOM NAV ITEM
  // ======================================================================
  Widget _buildBottomItem({
    required IconData icon,
    required String label,
    bool selected = false,
  }) {
    return SizedBox(
      width: 76,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: selected ? 58 : 42,
            height: selected ? 42 : 34,
            decoration: BoxDecoration(
              color: selected ? const Color(0xFFE5D8FF) : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: selected ? 28 : 26,
              color: selected
                  ? const Color(0xFF66508E)
                  : const Color(0xFF55515B),
            ),
          ),

          const SizedBox(height: 2),

          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: selected
                  ? const Color(0xFF66508E)
                  : const Color(0xFF55515B),
              fontWeight: selected ? FontWeight.w500 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
