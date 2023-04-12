
/// Tiploc model

class Train {
  List<Train>? list;
  final String tiploc;
  // final String crs;
  // final String description;

  Train({required this.tiploc,
    // required this.crs,
    // required this.description
  });

  factory Train.fromJson(Map<String, dynamic> json) {
    return Train(
      tiploc: json['tiploc'],
      // crs: json['crs'],
      // description: json['description'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'tiploc': tiploc,
      // 'crs': crs,
      // 'description': description,
    };
  }
}




/// Service Model

class ServiceList {
  List<ServiceList>? service;
  final String origin_time;
  final String destination_time;
  final String origin_location;
  final String destination_location;
  final String headcode;
  final String platform;
  final String arrival_time;
  final String departure_time;
  final String no_cars;
  final String joining;
  final String alighting;
  final String otd;
  final String late;
  final String train_uid;
  final String toc;
  final String date_from;
  final String date_to;
  final String stp_indicator;


  ServiceList({required this.origin_time,
    required this.origin_location,
    required this.destination_time,
    required this.destination_location,
    required this.headcode,
    required this.platform,
    required this.arrival_time,
    required this.departure_time,
    required this.no_cars,
    required this.joining,
    required this.alighting,
    required this.otd,
    required this.late,
    required this.train_uid,
    required this.toc,
    required this.date_from,
    required this.date_to,
    required this.stp_indicator,

  });

  factory ServiceList.fromJson(Map<String, dynamic> json) {
    return ServiceList(
      origin_time: json['origin_time'],
      destination_time: json['destination_time'],
      origin_location: json['origin_location'],
      destination_location: json['destination_location'],
      headcode: json['headcode'],
      platform: json['platform'],
      arrival_time: json['arrival_time'],
      departure_time: json['departure_time'],
      no_cars: json['no_cars'],
      joining: json['joining'],
      alighting: json['alighting'],
      otd: json['otd'],
      late: json['late'],
      train_uid: json['train_uid'],
      toc: json['toc'],
      date_from: json['date_from'],
      date_to: json['date_to'],
      stp_indicator: json['stp_indicator'],

    );
  }

  Map<String, dynamic> toMap() {
    return {
      'origin_time': origin_time,
      'destination_time': destination_time,
      'origin_location': origin_location,
      'destination_location': destination_location,
      'headcode': headcode,
      'platform': platform,
      'arrival_time': arrival_time,
      'departure_time': departure_time,
      'no_cars': no_cars,
      'joining': joining,
      'alighting': alighting,
      'otd': otd,
      'late': late,
      'train_uid': train_uid,
      'toc': toc,
      'date_from': date_from,
      'date_to': date_to,
      'stp_indicator': stp_indicator,

    };
  }
}

