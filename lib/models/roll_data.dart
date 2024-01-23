import 'package:equatable/equatable.dart';

class RollData extends Equatable {
  final String detailId;
  final String supplierRoll;
  final String factoryRoll;
  final String? rollLength;
  final dynamic rfid;
  final String? rfidFlag;
  final String? shade;
  final String? shrinkLength;

  const RollData({
    required this.detailId,
    required this.supplierRoll,
    required this.factoryRoll,
    this.rollLength,
    this.rfid,
    this.rfidFlag,
     this.shade,
     this.shrinkLength,
  });

  factory RollData.fromJson(Map<String, dynamic> json) => RollData(
        detailId: json['DETAIL_ID'] as String,
        supplierRoll: json['SUPPLIER_ROLL'] as String,
        factoryRoll: json['FACTORY_ROLL'] as String,
        rollLength: json['ROLL_LENGTH'] as String?,
        rfid: json['RFID'] as dynamic,
        rfidFlag: json['RFID_FLAG'] as dynamic,
        shade: json['SHADE'] as String?,
        shrinkLength: json['SHRINK_LENGTH'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'DETAIL_ID': detailId,
        'SUPPLIER_ROLL': supplierRoll,
        'FACTORY_ROLL': factoryRoll,
        'ROLL_LENGTH': rollLength,
        'RFID': rfid,
        'RFID_FLAG': rfidFlag,
        'SHADE': shade,
        'SHRINK_LENGTH': shrinkLength,
      };

  @override
  List<Object?> get props {
    return [
      detailId,
      supplierRoll,
      factoryRoll,
      rollLength,
      rfid,
      rfidFlag,
      shade,
      shrinkLength
    ];
  }
}
