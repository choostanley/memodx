import 'package:flutter/foundation.dart';
import '../patienth.dart';
import '../person.dart';
import 'diagnosis.dart';
import 'plan.dart';

class Note {
  final String id;
  final Patienth patientWard;
  final String seenBy;
  final List<String> notes;
  final Diagnosis listOfDiag;
  final Plan listOfPlan;
  final Person createdBy;
  final DateTime timeCreated;
  final DateTime timeUpdated;


  const Note({
    @required this.id,
    @required this.patientWard,
    @required this.seenBy,
    @required this.notes,
    @required this.listOfDiag,
    @required this.listOfPlan,
    @required this.createdBy,
    @required this.timeCreated,
    @required this.timeUpdated,
  });
}
