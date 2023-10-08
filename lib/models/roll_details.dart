import 'package:equatable/equatable.dart';

class RollDetails extends Equatable {
	final String? factoryRoll;
	final String? supplierRoll;
	final String? rollLength;
	final String? rfid;
	final String? buyer;
	final String? style;
	final String? season;
	final String? color;
	final String? wash;
	final String? shade;
	final String? shrinkPattern;
	final String? shrinks;
	final String? totalLength;
	final String? remainningLength;

	const RollDetails({
		this.factoryRoll, 
		this.supplierRoll, 
		this.rollLength, 
		this.rfid, 
		this.buyer, 
		this.style, 
		this.season, 
		this.color, 
		this.wash, 
		this.shade, 
		this.shrinkPattern, 
		this.shrinks, 
		this.totalLength, 
		this.remainningLength, 
	});

	factory RollDetails.fromJson(Map<String, dynamic> json) => RollDetails(
				factoryRoll: json['FACTORY_ROLL'] as String?,
				supplierRoll: json['SUPPLIER_ROLL'] as String?,
				rollLength: json['ROLL_LENGTH'] as String?,
				rfid: json['RFID'] as String?,
				buyer: json['BUYER'] as String?,
				style: json['STYLE'] as String?,
				season: json['SEASON'] as String?,
				color: json['COLOR'] as String?,
				wash: json['WASH'] as String?,
				shade: json['SHADE'] as String?,
				shrinkPattern: json['SHRINK_PATTERN'] as String?,
				shrinks: json['SHRINKS'] as String?,
				totalLength: json['TOTAL_LENGTH'] as String?,
				remainningLength: json['REMAINNING_LENGTH'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'FACTORY_ROLL': factoryRoll,
				'SUPPLIER_ROLL': supplierRoll,
				'ROLL_LENGTH': rollLength,
				'RFID': rfid,
				'BUYER': buyer,
				'STYLE': style,
				'SEASON': season,
				'COLOR': color,
				'WASH': wash,
				'SHADE': shade,
				'SHRINK_PATTERN': shrinkPattern,
				'SHRINKS': shrinks,
				'TOTAL_LENGTH': totalLength,
				'REMAINNING_LENGTH': remainningLength,
			};

	@override
	List<Object?> get props {
		return [
				factoryRoll,
				supplierRoll,
				rollLength,
				rfid,
				buyer,
				style,
				season,
				color,
				wash,
				shade,
				shrinkPattern,
				shrinks,
				totalLength,
				remainningLength,
		];
	}
}
