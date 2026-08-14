class Doctor {
  final String id;
  final String name;
  final String specialty;
  final String experience;
  final double rating;
  final int reviewCount;
  final String image;
  final String location;
  final String distance;
  final String hospital;
  final String about;
  final String education;
  final double consultationFee;
  final double insuranceCoverage;
  final bool inNetwork;
  final String nextSlot;
  final String phone;
  final List<String> insuranceProviders;
  final Map<String, List<String>> availableSlots;

  const Doctor({
    required this.id,
    required this.name,
    required this.specialty,
    required this.experience,
    required this.rating,
    required this.reviewCount,
    required this.image,
    required this.location,
    required this.distance,
    required this.hospital,
    required this.about,
    required this.education,
    required this.consultationFee,
    required this.insuranceCoverage,
    required this.inNetwork,
    required this.nextSlot,
    required this.phone,
    required this.insuranceProviders,
    required this.availableSlots,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    // Parse available slots map safely
    Map<String, List<String>> slotsMap = {};
    if (json['availableSlots'] != null && json['availableSlots'] is Map) {
      final map = json['availableSlots'] as Map<String, dynamic>;
      map.forEach((key, value) {
        if (value is List) {
          slotsMap[key] = value.map((e) => e.toString()).toList();
        }
      });
    }

    return Doctor(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      specialty: json['specialty'] as String? ?? '',
      experience: json['experience'] as String? ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviewCount: json['reviewCount'] as int? ?? 0,
      image: json['image'] as String? ?? '',
      location: json['location'] as String? ?? '',
      distance: json['distance'] as String? ?? '',
      hospital: json['hospital'] as String? ?? '',
      about: json['about'] as String? ?? '',
      education: json['education'] as String? ?? '',
      consultationFee: (json['consultationFee'] as num?)?.toDouble() ?? 0.0,
      insuranceCoverage: (json['insuranceCoverage'] as num?)?.toDouble() ?? 0.0,
      inNetwork: json['inNetwork'] as bool? ?? true,
      nextSlot: json['nextSlot'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      insuranceProviders: (json['insuranceProviders'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      availableSlots: slotsMap,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'specialty': specialty,
      'experience': experience,
      'rating': rating,
      'reviewCount': reviewCount,
      'image': image,
      'location': location,
      'distance': distance,
      'hospital': hospital,
      'about': about,
      'education': education,
      'consultationFee': consultationFee,
      'insuranceCoverage': insuranceCoverage,
      'inNetwork': inNetwork,
      'nextSlot': nextSlot,
      'phone': phone,
      'insuranceProviders': insuranceProviders,
      'availableSlots': availableSlots,
    };
  }
}
