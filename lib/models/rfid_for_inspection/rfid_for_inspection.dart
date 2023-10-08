import 'package:equatable/equatable.dart';

import 'datum.dart';

class RfidForInspection extends Equatable {
	final String? response;
	final List<Datum>? data;

	const RfidForInspection({this.response, this.data});

	factory RfidForInspection.fromJson(Map<String, dynamic> json) {
		return RfidForInspection(
			response: json['response'] as String?,
			data: (json['data'] as List<dynamic>?)
						?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
						.toList(),
		);
	}



	Map<String, dynamic> toJson() => {
				'response': response,
				'data': data?.map((e) => e.toJson()).toList(),
			};

	@override
	List<Object?> get props => [response, data];
}
