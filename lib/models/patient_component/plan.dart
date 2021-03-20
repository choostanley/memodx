import 'package:flutter/foundation.dart';
import '../patienth.dart';

class Plan {
  final String id;
  final Patienth patientWard;
  final Map<int, String> plans;
  final DateTime timeCreated;
  final DateTime timeUpdated;

  const Plan({
    @required this.id,
    @required this.patientWard,
    @required this.plans,
    @required this.timeCreated,
    @required this.timeUpdated,
  });
}
