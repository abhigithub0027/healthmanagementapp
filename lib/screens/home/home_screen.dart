import 'package:flutter/material.dart';
import '../../app/routes.dart';
import '../../app/theme.dart';
import '../../models/doctor.dart';
import '../../repositories/doctor_repository.dart';
import '../../widgets/doctor_card.dart';
import '../../widgets/error_message.dart';
import '../../widgets/loading_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DoctorRepository _doctorRepository = DoctorRepository();
  final TextEditingController _searchController = TextEditingController();

  List<Doctor> _allDoctors = [];
  List<Doctor> _filteredDoctors = [];
  bool _isLoading = true;
  String? _errorMessage;

  bool _inNetworkOnly = false;
  bool _nearestOnly = false;
  int _selectedBottomTab = 2; // Default to Search tab

  @override
  void initState() {
    super.initState();
    _loadDoctorsData();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadDoctorsData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final doctors = await _doctorRepository.getDoctors();
      if (!mounted) return;
      setState(() {
        _allDoctors = doctors;
        _filteredDoctors = doctors;
        _isLoading = false;
      });
      _applyFilters();
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _errorMessage = 'Failed to load doctors catalog: ${e.toString()}';
      });
    }
  }

  void _onSearchChanged() {
    _applyFilters();
  }

  void _applyFilters() {
    final query = _searchController.text.trim().toLowerCase();
    setState(() {
      _filteredDoctors = _allDoctors.where((doc) {
        if (_inNetworkOnly && !doc.inNetwork) {
          return false;
        }
        if (query.isNotEmpty) {
          final matchesName = doc.name.toLowerCase().contains(query);
          final matchesSpecialty = doc.specialty.toLowerCase().contains(query);
          final matchesHospital = doc.hospital.toLowerCase().contains(query);
          if (!matchesName && !matchesSpecialty && !matchesHospital) {
            return false;
          }
        }
        return true;
      }).toList();

      if (_nearestOnly) {
        _filteredDoctors.sort((a, b) {
          double distA =
              double.tryParse(a.distance.replaceAll(RegExp(r'[^0-9.]'), '')) ??
              99.0;
          double distB =
              double.tryParse(b.distance.replaceAll(RegExp(r'[^0-9.]'), '')) ??
              99.0;
          return distA.compareTo(distB);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundImage: AssetImage('assets/images/userprofile.png'),
            ),
            SizedBox(width: 10),
            Text(
              'HealthBridge',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
                fontSize: 24,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.swap_horiz_rounded,
              size: 26,
              color: AppColors.primary,
            ),
            onPressed: () {
              _showLogoutDialog(context);
            },
          ),
          const SizedBox(width: 8),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(54.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                _buildFilterChip(
                  label: 'In-Network',
                  icon: Icons.verified_user_outlined,
                  isSelected: _inNetworkOnly,
                  onTap: () {
                    setState(() {
                      _inNetworkOnly = !_inNetworkOnly;
                      _applyFilters();
                    });
                  },
                ),
                const SizedBox(width: 10),
                _buildFilterChip(
                  label: 'Nearest to Me',
                  imagePath: 'assets/images/Icon.png',
                  isSelected: _nearestOnly,
                  onTap: () {
                    setState(() {
                      _nearestOnly = !_nearestOnly;
                      _applyFilters();
                    });
                  },
                ),
                const SizedBox(width: 10),
                _buildFilterChip(
                  label: 'Open this friday',
                  icon: Icons.filter_list_rounded,
                  isSelected: _nearestOnly,
                  onTap: () {
                    setState(() {
                      _nearestOnly = !_nearestOnly;
                      _applyFilters();
                    });
                  },
                ),
                const SizedBox(width: 10),
                _buildFilterChip(
                  label: '',
                  icon: Icons.filter_list,
                  isSelected: _nearestOnly,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
      body: _isLoading
          ? const LoadingWidget(message: 'Loading verified doctors...')
          : _errorMessage != null
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: ErrorMessage(
                message: _errorMessage!,
                onRetry: _loadDoctorsData,
              ),
            )
          : Column(
        children: [
          // Results Header
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
            child: Row(
              children: [
                Text(
                  '${_filteredDoctors.length} Results for\nSpecialists',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                    height: 1.2,
                  ),
                ),

                const Spacer(),

                const Text(
                  'SORTED BY\nRELEVANCE',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textLight,
                    letterSpacing: 0.6,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),

          // Doctor List
          Expanded(
            child: _filteredDoctors.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.search_off_rounded,
                    size: 48,
                    color: AppColors.textLight,
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'No doctors found matching filters',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),

                  const SizedBox(height: 8),

                  TextButton(
                    onPressed: () {
                      _searchController.clear();

                      setState(() {
                        _inNetworkOnly = false;
                        _nearestOnly = false;
                        _applyFilters();
                      });
                    },
                    child: const Text('Reset Filters'),
                  ),
                ],
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 4,
              ),
              itemCount: _filteredDoctors.length + 3,
              itemBuilder: (context, index) {
                // -------------------------------
                // Normal doctors before Quick Care
                // -------------------------------
                if (index < _filteredDoctors.length) {
                  final doctor = _filteredDoctors[index];

                  return DoctorCard(
                    doctor: doctor,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.aboutDoctor,
                        arguments: doctor,
                      );
                    },
                  );
                }

                // -------------------------------
                // Quick Care Notice
                // -------------------------------
                if (index == _filteredDoctors.length) {
                  return _buildQuickCareNotice();
                }

                // -------------------------------
                // 2 doctors AFTER Quick Care
                // -------------------------------
                final afterQuickCareIndex =
                    index - _filteredDoctors.length - 1;

                // Safety check
                if (afterQuickCareIndex < 2 &&
                    afterQuickCareIndex < _filteredDoctors.length) {
                  final doctor = _filteredDoctors[afterQuickCareIndex];

                  return DoctorCard(
                    doctor: doctor,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.aboutDoctor,
                        arguments: doctor,
                      );
                    },
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
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
      ),
    );
  }

  Widget _buildFilterChip({
    required String label,
    IconData? icon,
    String? imagePath,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? AppColors.primary : const Color(0xFFE5E7EB),
            width: 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.25),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isSelected) ...[
              Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  size: 10,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 6),
            ] else ...[
              if (imagePath != null)
                ClipOval(
                  child: Image.asset(
                    imagePath,
                    width: 16,
                    height: 16,
                    fit: BoxFit.cover,
                  ),
                )
              else if (icon != null)
                Icon(icon, size: 16, color: AppColors.textSecondary),

              const SizedBox(width: 6),
            ],

            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickCareNotice() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF432B7A),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF432B7A).withValues(alpha: 0.25),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'QUICK CARE',
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Urgent Care Wait Times',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Nearby facility at Westside Clinic has only a 15-minute wait currently.',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFFECE7FA),
              height: 1.3,
            ),
          ),
          const SizedBox(height: 14),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF432B7A),
              elevation: 0,
              minimumSize: const Size(130, 38),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              textStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            child: const Text('Get Directions',style: TextStyle(fontSize: 14),),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Account Profile'),
        content: const Text(
          'Logged in as test@example.com (HealthBridge Member).',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, AppRoutes.login);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.errorRed,
            ),
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }
}
