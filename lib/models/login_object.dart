import 'package:equatable/equatable.dart';

class LoginObject extends Equatable {
	final String? auth;
	final String? employeeNumber;
	final String? employeeName;

	const LoginObject({this.auth, this.employeeNumber, this.employeeName});

	factory LoginObject.fromJson(Map<String, dynamic> json) => LoginObject(
				auth: json['AUTH'] as String?,
				employeeNumber: json['EMPLOYEE_NUMBER'] as String?,
				employeeName: json['EMPLOYEE_NAME'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'AUTH': auth,
				'EMPLOYEE_NUMBER': employeeNumber,
				'EMPLOYEE_NAME': employeeName,
			};

	@override
	List<Object?> get props => [auth, employeeNumber, employeeName];
}
