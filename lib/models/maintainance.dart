import 'package:equatable/equatable.dart';

class MaintainanceResponse extends Equatable {
	final String? response;

	const MaintainanceResponse({this.response});

	factory MaintainanceResponse.fromJson(Map<String, dynamic> json) => MaintainanceResponse(
				response: json['RESPONSE'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'RESPONSE': response,
			};

	@override
	List<Object?> get props => [response];
}
