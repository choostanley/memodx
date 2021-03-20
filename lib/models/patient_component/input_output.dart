import 'package:flutter/foundation.dart';
import '../patienth.dart';

class InputOutput {
  final String id;
  final Patienth patientWard;
  final Map<int, Map<String, int>> io;  
  final DateTime timeCreated;
  final DateTime timeUpdated;

  const InputOutput({
    @required this.id,
    @required this.patientWard,
    @required this.io,
    @required this.timeCreated,
    @required this.timeUpdated,
  });
}
