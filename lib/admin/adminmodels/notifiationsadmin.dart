import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class NotificationsAdmin {
  final Notificationdata data;
  final String first_page_url;
  final String from;
  final String next_page_url;
  final String path;
  final String per_page;
  final String prev_page_url;
  final int to;
  NotificationsAdmin({
    required this.data,
    required this.first_page_url,
    required this.from,
    required this.next_page_url,
    required this.path,
    required this.per_page,
    required this.prev_page_url,
    required this.to,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'data': data.toMap(),
      'first_page_url': first_page_url,
      'from': from,
      'next_page_url': next_page_url,
      'path': path,
      'per_page': per_page,
      'prev_page_url': prev_page_url,
      'to': to,
    };
  }

  factory NotificationsAdmin.fromMap(Map<String, dynamic> map) {
    return NotificationsAdmin(
      data:
          Notificationdata.fromMap(map['data'] as Map<String, dynamic>? ?? {}),
      first_page_url: (map['first_page_url'] as String?) ?? '',
      from: (map['from'] as String?) ?? '',
      next_page_url: (map['next_page_url'] as String?) ?? '',
      path: (map['path'] as String?) ?? '',
      per_page: (map['per_page'] as String?) ?? '',
      prev_page_url: (map['prev_page_url'] as String?) ?? '',
      to: (map['to'] as int?) ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationsAdmin.fromJson(String source) =>
      NotificationsAdmin.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Notificationdata {
  final int id;
  final String payload;
  final int is_seen;
  Notificationdata({
    required this.id,
    required this.payload,
    required this.is_seen,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'payload': payload,
      'is_seen': is_seen,
    };
  }

  factory Notificationdata.fromMap(Map<String, dynamic> map) {
    return Notificationdata(
      id: (map['id'] as int?) ?? 0,
      payload: (map['payload'] as String?) ?? '',
      is_seen: (map['is_seen'] as int?) ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Notificationdata.fromJson(String source) =>
      Notificationdata.fromMap(json.decode(source) as Map<String, dynamic>);
}
