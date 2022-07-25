import 'package:flutter/cupertino.dart';

class TargetPilot {
  final String distrubuterName;
  final String targetAmount;
  final String archivedTarget;

  TargetPilot(
      {@required this.distrubuterName,
      @required this.targetAmount,
      @required this.archivedTarget});


}



List<TargetPilot> targetPilots = [
  TargetPilot(
      distrubuterName: "Azam Cola",
      targetAmount: "50000",
      archivedTarget: '25000'),
  TargetPilot(
      distrubuterName: "Aerial",
      targetAmount: "90000",
      archivedTarget: '35000'),
  TargetPilot(
      distrubuterName: "Chai Bora",
      targetAmount: "20000",
      archivedTarget: '15000'),
  TargetPilot(
      distrubuterName: "Cocacola",
      targetAmount: "40000",
      archivedTarget: '3000'),
  TargetPilot(
      distrubuterName: "Azania",
      targetAmount: "80000",
      archivedTarget: '50000'),
  TargetPilot(
      distrubuterName: "Mwanga",
      targetAmount: "90000",
      archivedTarget: '40000'),
];
