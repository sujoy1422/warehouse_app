import 'package:equatable/equatable.dart';

class CurrentAttendance extends Equatable {
  final String? inTime;
  final String? outTime;
  final String? inTime24;
  final String? outTime24;

  const CurrentAttendance({
    this.inTime,
    this.outTime,
    this.inTime24,
    this.outTime24,
  });

  factory CurrentAttendance.fromJson(Map<String, dynamic> json) {
    return CurrentAttendance(
      inTime: json['IN_TIME'] as String?,
      outTime: json['OUT_TIME'] as String?,
      inTime24: json['IN_TIME_24'] as String?,
      outTime24: json['OUT_TIME_24'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'IN_TIME': inTime,
        'OUT_TIME': outTime,
        'IN_TIME_24': inTime24,
        'OUT_TIME_24': outTime24,
      };

  @override
  List<Object?> get props => [inTime, outTime, inTime24, outTime24];
}
