import 'package:equatable/equatable.dart';

class StyleWiseCount extends Equatable {
	final String? buyer;
	final String? style;
	final String? season;
	final String? color;
	final String? wash;
	final String systemId;
	final String? totalRoll;

	const StyleWiseCount({
		this.buyer, 
		this.style, 
		this.season, 
		this.color, 
		this.wash, 
		required this.systemId, 
		this.totalRoll, 
	});

	factory StyleWiseCount.fromJson(Map<String, dynamic> json) {
		return StyleWiseCount(
			buyer: json['BUYER'] as String?,
			style: json['STYLE'] as String?,
			season: json['SEASON'] as String?,
			color: json['COLOR'] as String?,
			wash: json['WASH'] as String?,
			systemId: json['SYSTEM_ID'] as String,
			totalRoll: json['TOTAL_ROLL'] as String?,
		);
	}



	Map<String, dynamic> toJson() => {
				'BUYER': buyer,
				'STYLE': style,
				'SEASON': season,
				'COLOR': color,
				'WASH': wash,
				'SYSTEM_ID': systemId,
				'TOTAL_ROLL': totalRoll,
			};

	@override
	List<Object?> get props {
		return [
				buyer,
				style,
				season,
				color,
				wash,
				systemId,
				totalRoll,
		];
	}
}
