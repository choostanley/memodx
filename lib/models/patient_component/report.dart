import 'package:flutter/foundation.dart';
import '../patienth.dart';

class Report {
  final String id;
  final Patienth patientWard;
  final String name;
  final List<String> findings;  
  final String firestorePDFlink;    
  final DateTime timeCreated;
  final DateTime timeUpdated;

  const Report({
    @required this.id,
    @required this.patientWard,
    @required this.name,    
    @required this.findings,    
    @required this.firestorePDFlink,
    @required this.timeCreated,
    @required this.timeUpdated,
  });
}
