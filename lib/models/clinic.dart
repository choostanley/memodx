import 'package:flutter/foundation.dart';
import 'person.dart';

class Clinic {
  final String id;
  final String name;
  final String shortName;
  final Person owner;
  final List<Person> persons;
  final List<String> patients;

  const Clinic({
    @required this.id,
    @required this.name,
    @required this.shortName,
    @required this.owner,
    @required this.persons,
    @required this.patients,
  });
}
