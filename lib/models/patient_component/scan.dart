import 'package:flutter/foundation.dart';
import '../patienth.dart';

class Scan {
  final String id;
  final Patienth patientWard;
  final List<String> firestoreLinks;  
  final DateTime timeCreated;
  final DateTime timeUpdated;

  const Scan({
    @required this.id,
    @required this.patientWard,
    @required this.firestoreLinks,
    @required this.timeCreated,
    @required this.timeUpdated,
  });
}
