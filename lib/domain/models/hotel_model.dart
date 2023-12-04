class Hotel {
  final int id;
  final String name;
  final Schedule schedule;
  final String destination;
  final String departureLocation;
  final String destinationLocation;
  final int capacity;
  final int availableSeats;
  final int passengers;
  final double price;
  final String description;
  final String equipmentDetails;
  final bool isPublic;
  final bool isActive;
  final String primaryImageUrl;

  Hotel(
      {required this.id,
      required this.name,
      required this.schedule,
      required this.destination,
      required this.departureLocation,
      required this.destinationLocation,
      required this.capacity,
      required this.availableSeats,
      required this.passengers,
      required this.price,
      required this.description,
      required this.equipmentDetails,
      required this.isPublic,
      required this.isActive,
      required this.primaryImageUrl});

  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
      id: json['id'] as int,
      name: json['name'] ?? "",
      schedule: Schedule.fromJson(json['schedule'] ?? {}),
      destination: json['destination'] ?? "",
      departureLocation: json['departureLocation'] ?? "",
      destinationLocation: json['destinationLocation'] ?? "",
      capacity: json['capacity'] as int,
      availableSeats: json['availableSeats'] as int,
      passengers: json['passengers'] as int,
      price: (json['price'] as num).toDouble(),
      description: json['description'] ?? "",
      equipmentDetails: json['equipmentDetails'] ?? "",
      isPublic: json['isPublic'] ?? false,
      isActive: json['isActive'] ?? false,
      primaryImageUrl: json['primaryImageUrl'] ?? "",
    );
  }
}

class Schedule {
  final DateTime? meeting;
  final DateTime? departure;
  final DateTime? returnDate;

  Schedule({
    required this.meeting,
    required this.departure,
    required this.returnDate,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      meeting: json['meeting'] != null
          ? DateTime.parse(json['meeting'])
          : DateTime.now(),
      departure: json['departure'] != null
          ? DateTime.parse(json['departure'])
          : DateTime.now(),
      returnDate: json['return'] != null
          ? DateTime.parse(json['return'])
          : DateTime.now(),
    );
  }
}

class HotelIImage {
  final String url;

  HotelIImage({
    required this.url,
  });

  factory HotelIImage.fromJson(Map<String, dynamic> json) {
    return HotelIImage(url: json["url"] ?? "");
  }
}
