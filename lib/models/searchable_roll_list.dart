import 'package:equatable/equatable.dart';

class SearchableRollList extends Equatable {
  final String rollNo;
  final String factoryRoll;
  final String? pallet;
  final String? bin;
  final String? rackNo;
  final String? binSlNo;

  const SearchableRollList({
    required this.rollNo,
    required this.factoryRoll,
    this.pallet,
    this.bin,
    this.rackNo,
    this.binSlNo,
  });

  factory SearchableRollList.fromJson(Map<String, dynamic> json) {
    return SearchableRollList(
      rollNo: json['ROLL_NO'] as String,
      factoryRoll: json['FACTORY_ROLL'] as String,
      pallet: json['PALLET'] as String?,
      bin: json['BIN'] as String?,
      rackNo: json['RACK_NO'] as String?,
      binSlNo: json['BIN_SL_NO'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'ROLL_NO': rollNo,
        'FACTORY_ROLL': factoryRoll,
        'PALLET': pallet,
        'BIN': bin,
        'RACK_NO': rackNo,
        'BIN_SL_NO': binSlNo,
      };

  @override
  List<Object?> get props =>
      [rollNo, factoryRoll, pallet, bin, rackNo, binSlNo];
}
