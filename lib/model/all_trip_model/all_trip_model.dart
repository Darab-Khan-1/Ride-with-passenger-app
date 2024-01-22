class AllTripModel {
  int? statusCode;
  String? message;
  String? error;
  List<AllTripData>? data;

  AllTripModel({this.statusCode, this.message, this.error, this.data});

  AllTripModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <AllTripData>[];
      json['data'].forEach((v) {
        data!.add(new AllTripData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    data['error'] = this.error;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllTripData {
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
  List<AllTripStops>? stops;

  AllTripData(
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
        this.stops});

  AllTripData.fromJson(Map<String, dynamic> json) {
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
    if (json['stops'] != null) {
      stops = <AllTripStops>[];
      json['stops'].forEach((v) {
        stops!.add(new AllTripStops.fromJson(v));
      });
    }
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
    return data;
  }
}

class AllTripStops {
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

  AllTripStops(
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

  AllTripStops.fromJson(Map<String, dynamic> json) {
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
