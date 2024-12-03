import 'package:equatable/equatable.dart';

class InvoiceStyles extends Equatable {
	final String? detailId;
	final String? lineId;
	final String? articleNo;
	final String? pocId;
	final String? orgId;
	final String? buyerId;
	final String? style;

	const InvoiceStyles({
		this.detailId, 
		this.lineId, 
		this.articleNo, 
		this.pocId, 
		this.orgId, 
		this.buyerId, 
		this.style, 
	});

	factory InvoiceStyles.fromJson(Map<String, dynamic> json) => InvoiceStyles(
				detailId: json['DETAIL_ID'] as String?,
				lineId: json['LINE_ID'] as String?,
				articleNo: json['ARTICLE_NO'] as String?,
				pocId: json['POC_ID'] as String?,
				orgId: json['ORG_ID'] as String?,
				buyerId: json['BUYER_ID'] as String?,
				style: json['STYLE'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'DETAIL_ID': detailId,
				'LINE_ID': lineId,
				'ARTICLE_NO': articleNo,
				'POC_ID': pocId,
				'ORG_ID': orgId,
				'BUYER_ID': buyerId,
				'STYLE': style,
			};

	@override
	List<Object?> get props {
		return [
				detailId,
				lineId,
				articleNo,
				pocId,
				orgId,
				buyerId,
				style,
		];
	}
}
