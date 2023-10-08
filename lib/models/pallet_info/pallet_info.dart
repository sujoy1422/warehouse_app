import 'package:equatable/equatable.dart';

import 'roll_list.dart';
import 'total.dart';

class PalletInfo extends Equatable {
  final List<RollList> rollList;
  final Total? total;

  const PalletInfo({required this.rollList, this.total});

  factory PalletInfo.fromJson(Map<String, dynamic> json) => PalletInfo(
        rollList: (json['ROLL_LIST'] as List<dynamic>)
            .map((e) => RollList.fromJson(e as Map<String, dynamic>))
            .toList(),
        total: json['TOTAL'] == null
            ? null
            : Total.fromJson(json['TOTAL'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'ROLL_LIST': rollList.map((e) => e.toJson()).toList(),
        'TOTAL': total?.toJson(),
      };

  @override
  List<Object?> get props => [rollList, total];
}
