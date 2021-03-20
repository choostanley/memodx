import 'package:flutter/foundation.dart';
import '../patienth.dart';
import '../person.dart';

enum Route { PO, Supp, IM, IV, Neb }

class Prescription {
  final String id;
  final Patienth patientWard;
  final Person prescriber;
  final Person off;
  final String drug;
  final Route route;
  final double dose;
  final String freq;
  final List<DateTime> administers;
  // final String unit; - need?
  final DateTime timeCreated;
  final DateTime timeUpdated;
  final DateTime timeOff;

  const Prescription({
    @required this.id,
    @required this.patientWard,
    @required this.prescriber,
    @required this.off,
    @required this.drug,
    @required this.route,
    @required this.dose,
    @required this.freq,
    @required this.administers,
    @required this.timeCreated,
    @required this.timeUpdated,
    @required this.timeOff,
  });
}
