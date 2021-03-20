import 'package:flutter/foundation.dart';
import 'patienth.dart';
import 'department.dart';
import 'ward.dart';

class Bed {
  final String id;
  final String number;
  final int seq;
  final Patienth patientWard;
  final Department department;
  final Ward ward;

  const Bed({
    @required this.id,
    @required this.number,
    @required this.seq,
    @required this.patientWard,
    @required this.department,
    @required this.ward,
  });
}