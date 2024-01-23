import 'package:equatable/equatable.dart';

class RollList extends Equatable {
  final String rollNo;
  final String factoryRoll;
  final String rollLength;
  final String bin;

  const RollList({
    required this.rollNo,
    required this.factoryRoll,
    required this.rollLength,
    required this.bin,
  });

  factory RollList.fromJson(Map<String, dynamic> json) => RollList(
        rollNo: json['ROLL_NO'] as String,
        factoryRoll: json['FACTORY_ROLL'] as String,
        rollLength: json['ROLL_LENGTH'] as String,
        bin: json['BIN_ID'] as String,
      );

  Map<String, dynamic> toJson() => {
        'ROLL_NO': rollNo,
        'FACTORY_ROLL': factoryRoll,
        'ROLL_LENGTH': rollLength,
        'BIN_ID': bin,
      };

  @override
  List<Object?> get props => [rollNo, factoryRoll, bin];
}
