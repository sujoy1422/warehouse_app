import 'package:equatable/equatable.dart';

class ResponseObject extends Equatable {
	final String? response;

	const ResponseObject({this.response});

	factory ResponseObject.fromJson(Map<String, dynamic> json) {
		return ResponseObject(
			response: json['RESPONSE'] as String?,
		);
	}



	Map<String, dynamic> toJson() => {
				'RESPONSE': response,
			};

	@override
	List<Object?> get props => [response];
}
