import 'package:equatable/equatable.dart';

class StyleWiseRoll extends Equatable {
	final String? rollNo;
	final String? palletId;
	final String? bin;
	final String? rackNo;
	final dynamic binSlNo;

	const StyleWiseRoll({
		this.rollNo, 
		this.palletId, 
		this.bin, 
		this.rackNo, 
		this.binSlNo, 
	});

	factory StyleWiseRoll.fromJson(Map<String, dynamic> json) => StyleWiseRoll(
				rollNo: json['ROLL_NO'] as String?,
				palletId: json['PALLET_ID'] as String?,
				bin: json['BIN'] as String?,
				rackNo: json['RACK_NO'] as String?,
				binSlNo: json['BIN_SL_NO'] as dynamic,
			);

	Map<String, dynamic> toJson() => {
				'ROLL_NO': rollNo,
				'PALLET_ID': palletId,
				'BIN': bin,
				'RACK_NO': rackNo,
				'BIN_SL_NO': binSlNo,
			};

	@override
	List<Object?> get props => [rollNo, palletId, bin, rackNo, binSlNo];
}
