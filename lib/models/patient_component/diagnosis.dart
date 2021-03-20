import 'package:flutter/foundation.dart';
import '../patienth.dart';

class Diagnosis {
  final String id;
  final Patienth patientWard;
  final Map<int, String> diagnoses;
  final DateTime timeCreated;
  final DateTime timeUpdated;

  const Diagnosis({
    @required this.id,
    @required this.patientWard,
    @required this.diagnoses,
    @required this.timeCreated,
    @required this.timeUpdated,
  });
}
