import 'package:equatable/equatable.dart';

import 'data.dart';

class RfidStatus extends Equatable {
	final String? status;
	final Data? data;

	const RfidStatus({this.status, this.data});

	factory RfidStatus.fromJson(Map<String, dynamic> json) => RfidStatus(
				status: json['STATUS'] as String?,
				data: json['data'] == null
						? null
						: Data.fromJson(json['data'] as Map<String, dynamic>),
			);

	Map<String, dynamic> toJson() => {
				'STATUS': status,
				'data': data?.toJson(),
			};

	@override
	List<Object?> get props => [status, data];
}
