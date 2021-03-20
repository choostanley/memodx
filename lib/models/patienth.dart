import 'package:flutter/foundation.dart';
// import 'clinich.dart';
// import 'clinic.dart';
import 'department.dart';
import 'hospital.dart';
import 'patient_component/note.dart';
import 'patient_component/diagnosis.dart';
import 'patient_component/vitals.dart';
import 'patient_component/flow_chart.dart';
import 'patient_component/drain_chart.dart';
import 'patient_component/prescription.dart';
import 'patient_component/input_output.dart';
import 'patient_component/scan.dart';
import 'patient_component/report.dart';

class Patienth {
  final String id;
  final String shortName;
  final String name;
  final String ic;
  final String dob;
  final String age;
  final List<String> rn;
  final List<String> admissionDates;
  final List<String> dischargeDates;
  final String address;
  final String phoneNumber;
  final Hospital hospital;
  final List<Department> department;
  final Diagnosis diagnosis;
  final List<Note> notes;
  final List<Note> referrals;
  final List<Vitals> vitals;
  final List<FlowChart> flowCharts;
  final List<Scan> scans;
  final List<InputOutput> ioCharts;
  final List<DrainChart> drainCharts;
  final List<Prescription> prescriptions;
  final List<Report> reports;

  // final List<Clinich> clinichs;
  // final List<Clinic> clinics;

  const Patienth({
    @required this.id,
    @required this.shortName,
    @required this.name,
    @required this.ic,
    @required this.dob,
    @required this.age,
    @required this.rn,
    @required this.admissionDates,
    @required this.dischargeDates,
    @required this.address,
    @required this.phoneNumber,
    @required this.hospital,
    @required this.department,
    @required this.diagnosis,
    @required this.notes,
    @required this.referrals,
    @required this.vitals,
    @required this.flowCharts,
    @required this.scans,
    @required this.ioCharts,
    @required this.drainCharts,
    @required this.prescriptions,
    @required this.reports,
  });
}
