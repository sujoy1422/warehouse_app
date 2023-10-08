import 'package:equatable/equatable.dart';

class Total extends Equatable {
	final String? totalRoll;
	final String? totalLength;

	const Total({this.totalRoll, this.totalLength});

	factory Total.fromJson(Map<String, dynamic> json) => Total(
				totalRoll: json['TOTAL_ROLL'] as String?,
				totalLength: json['TOTAL_LENGTH'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'TOTAL_ROLL': totalRoll,
				'TOTAL_LENGTH': totalLength,
			};

	@override
	List<Object?> get props => [totalRoll, totalLength];
}
