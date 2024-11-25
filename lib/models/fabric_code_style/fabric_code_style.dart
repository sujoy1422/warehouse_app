import 'package:equatable/equatable.dart';

class FabricCodeStyle extends Equatable {
	final String? headerId;
	final String? lineId;
	final String? articleNo;
	final String? styleNo;
	final String? totalRolls;
	final String? totalYards;
	final String? attachedLength;
	final String? attachedRoll;

	const FabricCodeStyle({
		this.headerId, 
		this.lineId, 
		this.articleNo, 
		this.styleNo, 
		this.totalRolls, 
		this.totalYards, 
		this.attachedLength, 
		this.attachedRoll, 
	});

	factory FabricCodeStyle.fromJson(Map<String, dynamic> json) {
		return FabricCodeStyle(
			headerId: json['HEADER_ID'] as String?,
			lineId: json['LINE_ID'] as String?,
			articleNo: json['ARTICLE_NO'] as String?,
			styleNo: json['STYLE_NO'] as String?,
			totalRolls: json['TOTAL_ROLLS'] as String?,
			totalYards: json['TOTAL_YARDS'] as String?,
			attachedLength: json['ATTACHED_LENGTH'] as String?,
			attachedRoll: json['ATTACHED_ROLL'] as String?,
		);
	}



	Map<String, dynamic> toJson() => {
				'HEADER_ID': headerId,
				'LINE_ID': lineId,
				'ARTICLE_NO': articleNo,
				'STYLE_NO': styleNo,
				'TOTAL_ROLLS': totalRolls,
				'TOTAL_YARDS': totalYards,
				'ATTACHED_LENGTH': attachedLength,
				'ATTACHED_ROLL': attachedRoll,
			};

	@override
	List<Object?> get props {
		return [
				headerId,
				lineId,
				articleNo,
				styleNo,
				totalRolls,
				totalYards,
				attachedLength,
				attachedRoll,
		];
	}
}
