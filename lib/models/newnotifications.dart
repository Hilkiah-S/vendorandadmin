import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class VendorNotifications {
  final VendorNotificationData? data;
  final String? first_page_url;
  final String? next_page_url;
  VendorNotifications({
    this.data,
    this.first_page_url,
    this.next_page_url,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'data': data?.toMap(),
      'first_page_url': first_page_url,
      'next_page_url': next_page_url,
    };
  }

  factory VendorNotifications.fromMap(Map<String, dynamic> map) {
    return VendorNotifications(
      data: map['data'] != null
          ? VendorNotificationData.fromMap(map['data'] as Map<String, dynamic>)
          : null,
      first_page_url: map['first_page_url'] != null
          ? map['first_page_url'] as String
          : null,
      next_page_url:
          map['next_page_url'] != null ? map['next_page_url'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory VendorNotifications.fromJson(String source) =>
      VendorNotifications.fromMap(json.decode(source) as Map<String, dynamic>);
}

class VendorNotificationData {
  final int id;
  final String payload;
  final String type;
  VendorNotificationData({
    required this.id,
    required this.payload,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'payload': payload,
      'type': type,
    };
  }

  factory VendorNotificationData.fromMap(Map<String, dynamic> map) {
    return VendorNotificationData(
      id: map['id'] as int,
      payload: map['payload'] as String,
      type: map['type'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory VendorNotificationData.fromJson(String source) =>
      VendorNotificationData.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
