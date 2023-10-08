import 'package:equatable/equatable.dart';

class RollList extends Equatable {
	final String rollNo;
	final String factoryRoll;
	final String rollLength;
	final String bin;
	final String rackNo;
	final String binSlNo;

	const RollList({
		required this.rollNo, 
		required this.factoryRoll,
    required this.rollLength, 
		required this.bin, 
		required this.rackNo, 
		required this.binSlNo, 
	});

	factory RollList.fromJson(Map<String, dynamic> json) => RollList(
				rollNo: json['ROLL_NO'] as String,
				factoryRoll: json['FACTORY_ROLL'] as String,
				rollLength: json['ROLL_LENGTH'] as String,
				bin: json['BIN'] as String,
				rackNo: json['RACK_NO'] as String,
				binSlNo: json['BIN_SL_NO'] as String,
			);

	Map<String, dynamic> toJson() => {
				'ROLL_NO': rollNo,
				'FACTORY_ROLL': factoryRoll,
        'ROLL_LENGTH' : rollLength,
				'BIN': bin,
				'RACK_NO': rackNo,
				'BIN_SL_NO': binSlNo,
			};

	@override
	List<Object?> get props => [rollNo, factoryRoll, bin, rackNo, binSlNo];
}
