import 'package:flutter/foundation.dart';
import 'clinich.dart';
import 'department.dart';
import 'person.dart';

class Hospital {
  final String id;
  final String fbId;
  final String name;
  final String shortName;
  final String imageUrl;
  final String ownerId;
  // final List<Clinich> clinichs;
  // final List<Department> departments;

  static final columns = [
    'id',
    'fb_id',
    'name',
    'short_name',
    'image_url',
    'owner'
  ];

  const Hospital({
    this.id,
    @required this.fbId,
    @required this.name,
    @required this.shortName,
    @required this.imageUrl,
    @required this.ownerId,
    // @required this.clinichs,
    // @required this.departments,
  });

  Map toMap() {
    Map map = {
      'fb_id': fbId,
      'name': name,
      'short_name': shortName,
      'image_url': imageUrl,
      'owner_id': ownerId
    };

    if (id != null) {
      map['id'] = id;
    }

    return map;
  }

  static fromMap(Map map) {
    Hospital hosp = new Hospital(
      id: map['id'],
      fbId: map['fb_id'],
      name: map['name'],
      shortName: map['short_name'],
      imageUrl: map['image_url'],
      ownerId: map['owner_id'],
    );
  
    return hosp;
  }
}
