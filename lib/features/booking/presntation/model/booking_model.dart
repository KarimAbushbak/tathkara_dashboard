class Booking {
  final String id;
  final String tripId;
  final String companyId;
  final String userName;
  final String userPhone;
  final int seats;
  final String status;
  final String gender;

  Booking({
    required this.id,
    required this.tripId,
    required this.companyId,
    required this.userName,
    required this.userPhone,
    required this.seats,
    required this.status,
    required this.gender,
  });

  factory Booking.fromMap(String id, Map<String, dynamic> data) {
    final seatsRaw = data['seats'] ?? data['totalSeats'] ?? 0;
    final seats = seatsRaw is int
        ? seatsRaw
        : int.tryParse(seatsRaw.toString()) ?? 0;

    return Booking(
      id: id,
      tripId: data['tripId'],
      companyId: data['companyId'],
      userName: data['userName'],
      userPhone: data['userPhone'],
      seats: seats,
      status: data['status'] ?? 'pending',
      gender: data['gender'] ?? 'ذكر',
    );
  }
}
