class Trip {
  String id;
  Origin origin;
  Destination destination;
  List<Stop> stops;
  String tripType;
  DateTime date;
  String time;
  ReturnTrip returnTrip;
  bool isStarted;
  bool isCompleted;
  bool isCancelled;
  int fair;
  DateTime createdAt;
  DateTime updatedAt;
  List<Rider> riders;

  Trip({
    required this.id,
    required this.origin,
    required this.destination,
    required this.stops,
    required this.tripType,
    required this.date,
    required this.time,
    required this.returnTrip,
    required this.isStarted,
    required this.isCompleted,
    required this.isCancelled,
    required this.fair,
    required this.createdAt,
    required this.updatedAt,
    required this.riders,
  });

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      id: json['_id'],
      origin: Origin.fromJson(json['origin']),
      destination: Destination.fromJson(json['destination']),
      stops: List<Stop>.from(json['stops'].map((stop) => Stop.fromJson(stop))),
      tripType: json['tripType'],
      date: DateTime.parse(json['date']),
      time: json['time'],
      returnTrip: ReturnTrip.fromJson(json['returnTrip']),
      isStarted: json['isStarted'],
      isCompleted: json['isCompleted'],
      isCancelled: json['isCancelled'],
      fair: json['fair'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      riders: List<Rider>.from(
          json['riders'].map((rider) => Rider.fromJson(rider))),
    );
  }
}

class Origin {
  String name;
  String type;
  List<double> coordinates;

  Origin({
    required this.name,
    required this.type,
    required this.coordinates,
  });

  factory Origin.fromJson(Map<String, dynamic> json) {
    return Origin(
      name: json['name'],
      type: json['type'],
      coordinates: List<double>.from(
          json['coordinates'].map((coord) => coord.toDouble())),
    );
  }
}

class Destination {
  String name;
  String type;
  List<double> coordinates;

  Destination({
    required this.name,
    required this.type,
    required this.coordinates,
  });

  factory Destination.fromJson(Map<String, dynamic> json) {
    return Destination(
      name: json['name'],
      type: json['type'],
      coordinates: List<double>.from(
          json['coordinates'].map((coord) => coord.toDouble())),
    );
  }
}

class Stop {
  String name;
  String type;
  List<double> coordinates;
  String id;

  Stop({
    required this.name,
    required this.type,
    required this.coordinates,
    required this.id,
  });

  factory Stop.fromJson(Map<String, dynamic> json) {
    return Stop(
      name: json['name'],
      type: json['type'],
      coordinates: List<double>.from(
          json['coordinates'].map((coord) => coord.toDouble())),
      id: json['_id'],
    );
  }
}

class ReturnTrip {
  bool isReturnTrip;
  DateTime? returnDate;
  String returnTime;

  ReturnTrip({
    required this.isReturnTrip,
    required this.returnDate,
    required this.returnTime,
  });

  factory ReturnTrip.fromJson(Map<String, dynamic> json) {
    return ReturnTrip(
      isReturnTrip: json['isReturnTrip'],
      returnDate: json['returnDate'] != null
          ? DateTime.parse(json['returnDate'])
          : null,
      returnTime: json['returnTime'],
    );
  }
}

abstract class Rider {
  String id;

  Rider({required this.id});

  factory Rider.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('driverId')) {
      return Driver.fromJson(json);
    } else if (json.containsKey('riderId')) {
      return Passenger.fromJson(json);
    } else {
      throw Exception('Invalid JSON for Rider');
    }
  }
}

class Driver extends Rider {
  String driverId;

  Driver({
    required this.driverId,
    required String id,
  }) : super(id: id);

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      driverId: json['driverId'],
      id: json.containsKey('_id') ? json['_id'] : '',
    );
  }
}

class Passenger extends Rider {
  String riderId;

  Passenger({
    required this.riderId,
    required String id,
  }) : super(id: id);

  factory Passenger.fromJson(Map<String, dynamic> json) {
    return Passenger(
      riderId: json['riderId'],
      id: json.containsKey('_id') ? json['_id'] : '',
    );
  }
}
