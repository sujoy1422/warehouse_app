import 'package:equatable/equatable.dart';

class Inventory extends Equatable {
	final String? headerId;
	final String? invoiceNo;

	const Inventory({this.headerId, this.invoiceNo});

	factory Inventory.fromJson(Map<String, dynamic> json) => Inventory(
				headerId: json['HEADER_ID'] as String?,
				invoiceNo: json['INVOICE_NO'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'HEADER_ID': headerId,
				'INVOICE_NO': invoiceNo,
			};

	@override
	List<Object?> get props => [headerId, invoiceNo];
}
