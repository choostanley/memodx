import 'package:flutter/foundation.dart';
import 'hospital.dart';
import 'person.dart';

class Clinich {
  final String id;
  final String name;
  final String shortName;
  final Hospital hospital;
  final Person owner;
  final List<Person> persons;
  final List<String> patients;

  const Clinich({
    @required this.id,
    @required this.name,
    @required this.shortName,
    @required this.hospital,
    @required this.owner,
    @required this.persons,
    @required this.patients,
  });
}