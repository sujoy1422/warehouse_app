import 'package:equatable/equatable.dart';

class InspectionList extends Equatable {
  final String? rfid;
  final String? rfidEpc;
  final String? factoryRoll;

  const InspectionList({this.rfid, this.rfidEpc, this.factoryRoll});

  factory InspectionList.fromJson(Map<String, dynamic> json) {
    return InspectionList(
      rfid: json['RFID'] as String?,
      rfidEpc: json['RFID_EPC'] as String?,
      factoryRoll: json['FACTORY_ROLL'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'RFID': rfid,
        'RFID_EPC': rfidEpc,
        'FACTORY_ROLL': factoryRoll,
      };

  @override
  List<Object?> get props => [rfid, rfidEpc, factoryRoll];
}
