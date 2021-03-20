import 'package:flutter/foundation.dart';
import 'clinich.dart';
import 'clinic.dart';
import 'department.dart';
import 'hospital.dart';

class Person {
  final String id;
  final String name;
  final String shortName;
  final String title;
  final String imageUrl;
  final List<Hospital> hospitals;
  final List<Department> departments;
  final List<Clinich> clinichs;
  final List<Clinic> clinics;

  const Person({
    @required this.id,
    @required this.name,
    @required this.shortName,
    @required this.title,
    @required this.imageUrl,
    @required this.hospitals,
    @required this.clinichs,
    @required this.departments,
    @required this.clinics,
  });
}