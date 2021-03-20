import 'package:flutter/foundation.dart';
import 'hospital.dart';
import 'person.dart';
import 'patienth.dart';
import 'ward.dart';

class Department {
  final String id;
  final String name;
  final String shortName;
  final Hospital hospital;
  final Person owner;
  final List<Person> persons;
  final List<Ward> wards;
  final List<Patienth> patientWard;
  final List<String> patients;

  const Department({
    @required this.id,
    @required this.name,
    @required this.shortName,
    @required this.hospital,
    @required this.owner,
    @required this.persons,
    @required this.wards,
    @required this.patientWard,
    @required this.patients,
  });
}