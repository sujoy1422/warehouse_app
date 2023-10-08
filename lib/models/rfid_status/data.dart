import 'package:equatable/equatable.dart';

class Data extends Equatable {
	final String? buyer;
	final String? style;
	final String? season;
	final String? color;
	final String? factoryRoll;
	final String? rollLength;
	final String? rollWidth;
	final String? supplierRoll;
	final String? uom;
	final String? rfid;

	const Data({
		this.buyer, 
		this.style, 
		this.season, 
		this.color, 
		this.factoryRoll, 
		this.rollLength, 
		this.rollWidth, 
		this.supplierRoll, 
		this.uom, 
		this.rfid, 
	});

	factory Data.fromJson(Map<String, dynamic> json) => Data(
				buyer: json['BUYER'] as String?,
				style: json['STYLE'] as String?,
				season: json['SEASON'] as String?,
				color: json['COLOR'] as String?,
				factoryRoll: json['FACTORY_ROLL'] as String?,
				rollLength: json['ROLL_LENGTH'] as String?,
				rollWidth: json['ROLL_WIDTH'] as String?,
				supplierRoll: json['SUPPLIER_ROLL'] as String?,
				uom: json['UOM'] as String?,
				rfid: json['RFID'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'BUYER': buyer,
				'STYLE': style,
				'SEASON': season,
				'COLOR': color,
				'FACTORY_ROLL': factoryRoll,
				'ROLL_LENGTH': rollLength,
				'ROLL_WIDTH': rollWidth,
				'SUPPLIER_ROLL': supplierRoll,
				'UOM': uom,
				'RFID': rfid,
			};

	@override
	List<Object?> get props {
		return [
				buyer,
				style,
				season,
				color,
				factoryRoll,
				rollLength,
				rollWidth,
				supplierRoll,
				uom,
				rfid,
		];
	}
}
