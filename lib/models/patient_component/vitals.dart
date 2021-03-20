import 'package:flutter/foundation.dart';
import '../patienth.dart';

class Vitals {
  final String id;
  final Patienth patientWard;
  final int temperature;
  final int heartRate;
  final int bpSys;
  final int bpDias;
  final int respiRate;
  final int spo2;
  final String bpMed;
  final double bpMedDose;
  final String o2Supported;
  final DateTime timeCreated;
  final DateTime timeUpdated;

  const Vitals({
    @required this.id,
    @required this.patientWard,
    @required this.temperature,
    @required this.heartRate,
    @required this.bpSys,
    @required this.bpDias,
    @required this.respiRate,
    @required this.spo2,
    @required this.bpMed,
    @required this.bpMedDose,
    @required this.o2Supported,
    @required this.timeCreated,
    @required this.timeUpdated,
  });
}
