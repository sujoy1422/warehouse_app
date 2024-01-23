import 'package:equatable/equatable.dart';

import 'unmacthed_list.dart';

class InvoiceStatus extends Equatable {
	final String? invoiceNo;
	final String? totRoll;
	final String? inserted;
	final String? remained;
	final List<UnmacthedList>? unmacthedList;

	const InvoiceStatus({
		this.invoiceNo, 
		this.totRoll, 
		this.inserted, 
		this.remained, 
		this.unmacthedList, 
	});

	factory InvoiceStatus.fromJson(Map<String, dynamic> json) => InvoiceStatus(
				invoiceNo: json['INVOICE_NO'] as String?,
				totRoll: json['TOT_ROLL'] as String?,
				inserted: json['INSERTED'] as String?,
				remained: json['REMAINED'] as String?,
				unmacthedList: (json['UNMACTHED_LIST'] as List<dynamic>?)
						?.map((e) => UnmacthedList.fromJson(e as Map<String, dynamic>))
						.toList(),
			);

	Map<String, dynamic> toJson() => {
				'INVOICE_NO': invoiceNo,
				'TOT_ROLL': totRoll,
				'INSERTED': inserted,
				'REMAINED': remained,
				'UNMACTHED_LIST': unmacthedList?.map((e) => e.toJson()).toList(),
			};

	@override
	List<Object?> get props {
		return [
				invoiceNo,
				totRoll,
				inserted,
				remained,
				unmacthedList,
		];
	}
}
