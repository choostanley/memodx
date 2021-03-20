import 'package:flutter/foundation.dart';
import '../patienth.dart';

class FlowChart {
  final String id;
  final Patienth patientWard;
  final DateTime date;
  final double hb;
  final double wbc;
  final double hct;
  final double plt;
  final double na;
  final double k;
  final double cl;
  final double urea;
  final double creat;
  final double tp;
  final double alb;
  final double glob;
  final double tbil;
  final double alt;
  final double alp;
  final double ck;
  final double ast;
  final double ldh;
  final double ca;
  final double mg;
  final double po4;
  final double pt;
  final double inr;
  final double aptt;
  final DateTime timeCreated;
  final DateTime timeUpdated;

  const FlowChart({
    @required this.id,
    @required this.patientWard,
    @required this.date,
    @required this.hb,
    @required this.wbc,
    @required this.hct,
    @required this.plt,
    @required this.na,
    @required this.k,
    @required this.cl,
    @required this.urea,
    @required this.creat,
    @required this.tp,
    @required this.alb,
    @required this.glob,
    @required this.tbil,
    @required this.alt,
    @required this.alp,
    @required this.ck,
    @required this.ast,
    @required this.ldh,
    @required this.ca,
    @required this.mg,
    @required this.po4,
    @required this.pt,
    @required this.inr,
    @required this.aptt,
    @required this.timeCreated,
    @required this.timeUpdated,
  });
}
