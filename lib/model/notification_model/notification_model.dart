class NotificationModel {
  int? statusCode;
  String? message;
  String? error;
  List<NotificationData>? data;

  NotificationModel({this.statusCode, this.message, this.error, this.data});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <NotificationData>[];
      json['data'].forEach((v) {
        data!.add(new NotificationData.fromJson(v));
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

class NotificationData {
  int? id;
  String? title;
  String? notification;
  String? type;
  String? userId;
  String? seen;
  String? createdAt;
  String? updatedAt;

  NotificationData(
      {this.id,
        this.title,
        this.notification,
        this.type,
        this.userId,
        this.seen,
        this.createdAt,
        this.updatedAt});

  NotificationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    notification = json['notification'];
    type = json['type'];
    userId = json['user_id'];
    seen = json['seen'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['notification'] = this.notification;
    data['type'] = this.type;
    data['user_id'] = this.userId;
    data['seen'] = this.seen;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
