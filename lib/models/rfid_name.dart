import 'package:equatable/equatable.dart';

class RfidName extends Equatable {
  final String rfid;
  final String rfidName;

  const RfidName({required this.rfid, required this.rfidName});

  factory RfidName.fromJson(Map<String, dynamic> json) => RfidName(
        rfid: json['RFID'] as String,
        rfidName: json['RFID_NAME'] as String,
      );

  Map<String, dynamic> toJson() => {
        'RFID': rfid,
        'RFID_NAME': rfidName,
      };

  @override
  List<Object?> get props => [rfid, rfidName];
}
