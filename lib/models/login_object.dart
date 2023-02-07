import 'package:equatable/equatable.dart';

import 'profile.dart';

class LoginObject extends Equatable {
  final String? auth;
  final Profile? profile;

  const LoginObject({
    this.auth,
    this.profile,
  });

  factory LoginObject.fromJson(Map<String, dynamic> json) => LoginObject(
        auth: json['AUTH'] as String?,
        profile: json['PROFILE'] == null
            ? null
            : Profile.fromJson(json['PROFILE'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'AUTH': auth,
        'PROFILE': profile?.toJson(),
      };

  @override
  List<Object?> get props {
    return [
      auth,
      profile,
    ];
  }
}
