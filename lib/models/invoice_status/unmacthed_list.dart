import 'package:equatable/equatable.dart';

class UnmacthedList extends Equatable {
	final String? invoiceNo;
	final String? supplierRoll;
	final String? factoryRoll;
	final String? rfid;

	const UnmacthedList({
		this.invoiceNo, 
		this.supplierRoll, 
		this.factoryRoll, 
		this.rfid, 
	});

	factory UnmacthedList.fromJson(Map<String, dynamic> json) => UnmacthedList(
				invoiceNo: json['INVOICE_NO'] as String?,
				supplierRoll: json['SUPPLIER_ROLL'] as String?,
				factoryRoll: json['FACTORY_ROLL'] as String?,
				rfid: json['RFID'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'INVOICE_NO': invoiceNo,
				'SUPPLIER_ROLL': supplierRoll,
				'FACTORY_ROLL': factoryRoll,
				'RFID': rfid,
			};

	@override
	List<Object?> get props => [invoiceNo, supplierRoll, factoryRoll, rfid];
}
