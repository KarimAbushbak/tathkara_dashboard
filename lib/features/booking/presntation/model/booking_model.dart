class Booking {
  final String id;
  final String tripId;
  final String companyId;
  final String userName;
  final String userPhone;
  final int seats;
  final String status;
  final String gender;
  final String? tripNumber;
  final List<Map<String, dynamic>> selectedSeats;

  Booking({
    required this.id,
    required this.tripId,
    required this.companyId,
    required this.userName,
    required this.userPhone,
    required this.seats,
    required this.status,
    required this.gender,
    this.tripNumber,
    this.selectedSeats = const [],
  });

  factory Booking.fromMap(String id, Map<String, dynamic> data) {
    final seatsRaw = data['seats'] ?? data['totalSeats'] ?? 0;
    final seats = seatsRaw is int
        ? seatsRaw
        : int.tryParse(seatsRaw.toString()) ?? 0;
    final selectedSeatsRaw = data['selectedSeats'] as List<dynamic>?;
    final selectedSeats = selectedSeatsRaw != null
        ? selectedSeatsRaw.map((e) => Map<String, dynamic>.from(e as Map)).toList()
        : <Map<String, dynamic>>[];
    return Booking(
      id: id,
      tripId: data['tripId'],
      companyId: data['companyId'],
      userName: data['userName'],
      userPhone: data['userPhone'],
      seats: seats,
      status: data['status'] ?? 'pending',
      gender: data['gender'] ?? 'ذكر',
      tripNumber: data['tripNumber'],
      selectedSeats: selectedSeats,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tripId': tripId,
      'companyId': companyId,
      'userName': userName,
      'userPhone': userPhone,
      'seats': seats,
      'status': status,
      'gender': gender,
      'tripNumber': tripNumber,
      'selectedSeats': selectedSeats,
    };
  }
}
