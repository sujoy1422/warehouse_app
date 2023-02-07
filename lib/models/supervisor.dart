import 'package:equatable/equatable.dart';

class Supervisor extends Equatable {
  final String? supervisorName;
  final String? supervisorEmailAddress;
  final String? phoneNumber;

  const Supervisor({
    this.supervisorName,
    this.supervisorEmailAddress,
    this.phoneNumber,
  });

  factory Supervisor.fromJson(Map<String, dynamic> json) => Supervisor(
        supervisorName: json['SUPERVISOR_NAME'] as String?,
        supervisorEmailAddress: json['SUPERVISOR_EMAIL_ADDRESS'] as String?,
        phoneNumber: json['PHONE_NUMBER'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'SUPERVISOR_NAME': supervisorName,
        'SUPERVISOR_EMAIL_ADDRESS': supervisorEmailAddress,
        'PHONE_NUMBER': phoneNumber,
      };

  @override
  List<Object?> get props {
    return [
      supervisorName,
      supervisorEmailAddress,
      phoneNumber,
    ];
  }
}
