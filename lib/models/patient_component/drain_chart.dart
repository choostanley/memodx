import 'package:flutter/foundation.dart';
import '../patienth.dart';

class DrainChart {
  final String id;
  final Patienth patientWard;
  final String name;
  final int am;
  final int pm;
  final int oni;
  final DateTime timeCreated;
  final DateTime timeUpdated;

  const DrainChart({
    @required this.id,
    @required this.patientWard,
    @required this.name,
    @required this.am,
    @required this.pm,
    @required this.oni,
    @required this.timeCreated,
    @required this.timeUpdated,
  });
}
