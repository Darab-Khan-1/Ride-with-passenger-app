class OnGoingTripModel {
  int? statusCode;
  String? message;
  String? error;
  OnGoingTripData? data;

  OnGoingTripModel({this.statusCode, this.message, this.error, this.data});

  OnGoingTripModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    error = json['error'];
    data = json['data'] != "" ? new OnGoingTripData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    data['error'] = this.error;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class OnGoingTripData {
  int? id;
  String? uniqueId;
  String? pickupLocation;
  String? pickupDate;
  String? deliveryDate;
  String? deliveryLocation;
  String? estimatedDistance;
  String? estimatedTime;
  String? customerName;
  String? customerPhone;
  String? lat;
  String? long;
  String? dropLat;
  String? dropLong;
  String? status;
  int? currentStop;
  List<OnGoingTripStops>? stops;
  OnGoingTripNextStop? nextStop;

  OnGoingTripData(
      {this.id,
        this.uniqueId,
        this.pickupLocation,
        this.pickupDate,
        this.deliveryDate,
        this.deliveryLocation,
        this.estimatedDistance,
        this.estimatedTime,
        this.customerName,
        this.customerPhone,
        this.lat,
        this.long,
        this.dropLat,
        this.dropLong,
        this.status,
        this.currentStop,
        this.stops,
        this.nextStop});

  OnGoingTripData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uniqueId = json['unique_id'];
    pickupLocation = json['pickup_location'];
    pickupDate = json['pickup_date'];
    deliveryDate = json['delivery_date'];
    deliveryLocation = json['delivery_location'];
    estimatedDistance = json['estimated_distance'];
    estimatedTime = json['estimated_time'];
    customerName = json['customer_name'];
    customerPhone = json['customer_phone'];
    lat = json['lat'];
    long = json['long'];
    dropLat = json['drop_lat'];
    dropLong = json['drop_long'];
    status = json['status'];
    currentStop = json['current_stop'];
    if (json['stops'] != null) {
      stops = <OnGoingTripStops>[];
      json['stops'].forEach((v) {
        stops!.add(new OnGoingTripStops.fromJson(v));
      });
    }
    nextStop = json['next_stop'] != null
        ? new OnGoingTripNextStop.fromJson(json['next_stop'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['unique_id'] = this.uniqueId;
    data['pickup_location'] = this.pickupLocation;
    data['pickup_date'] = this.pickupDate;
    data['delivery_date'] = this.deliveryDate;
    data['delivery_location'] = this.deliveryLocation;
    data['estimated_distance'] = this.estimatedDistance;
    data['estimated_time'] = this.estimatedTime;
    data['customer_name'] = this.customerName;
    data['customer_phone'] = this.customerPhone;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['drop_lat'] = this.dropLat;
    data['drop_long'] = this.dropLong;
    if (this.stops != null) {
      data['stops'] = this.stops!.map((v) => v.toJson()).toList();
    }
    if (this.nextStop != null) {
      data['next_stop'] = this.nextStop!.toJson();
    }
    return data;
  }
}

class OnGoingTripStops {
  int? id;
  String? tripId;
  String? location;
  String? lat;
  String? long;
  String? datetime;
  String? createdAt;
  String? updatedAt;
  String? type;
  String? exitTime;
  String? description;

  OnGoingTripStops(
      {this.id,
        this.tripId,
        this.location,
        this.lat,
        this.long,
        this.datetime,
        this.createdAt,
        this.updatedAt,
        this.type,
        this.exitTime,
        this.description});

  OnGoingTripStops.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tripId = json['trip_id'];
    location = json['location'];
    lat = json['lat'];
    long = json['long'];
    datetime = json['datetime'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    type = json['type'];
    exitTime = json['exit_time'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['trip_id'] = this.tripId;
    data['location'] = this.location;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['datetime'] = this.datetime;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['type'] = this.type;
    data['exit_time'] = this.exitTime;
    data['description'] = this.description;
    return data;
  }
}

class OnGoingTripNextStop {
  int? stop;
  int? stopId;
  String? type;
  String? lat;
  String? long;
  String? address;
  String? description;

  OnGoingTripNextStop(
      {this.stop, this.stopId, this.type, this.lat, this.long, this.address, this.description});

  OnGoingTripNextStop.fromJson(Map<String, dynamic> json) {
    stop = json['stop'];
    stopId = json['stop_id'];
    type = json['type'];
    lat = json['lat'];
    long = json['long'];
    address = json['address'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stop'] = this.stop;
    data['stop_id'] = this.stopId;
    data['type'] = this.type;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['address'] = this.address;
    data['description'] = this.description;
    return data;
  }
}
