import 'package:flutter/foundation.dart';
import 'package:medicmob/models/bed.dart';
import 'patienth.dart';
import 'department.dart';

class Ward {
  final String id;
  final int seq;
  final String name;
  final String shortName;
  final Department department;
  final List<Bed> beds;
  final List<Patienth> patientWard; //maybe no need

  const Ward({
    @required this.id,
    @required this.seq,
    @required this.name,
    @required this.shortName,
    @required this.department,
    @required this.beds,
    @required this.patientWard,
  });
}