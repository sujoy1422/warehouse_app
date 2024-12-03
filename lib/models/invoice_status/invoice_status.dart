import 'package:equatable/equatable.dart';

class InvoiceStatus extends Equatable {
  final String? headerId;
  final String? lineId;
  final String? articleNo;
  final String? shadedRoll;
  final String? totalRolls;
  final String? totalYards;
  final String? attachedLength;
  final String? attachedRoll;

  const InvoiceStatus(
      {this.headerId,
      this.lineId,
      this.articleNo,
      this.shadedRoll,
      this.totalRolls,
      this.totalYards,
      this.attachedLength,
      this.attachedRoll});

  factory InvoiceStatus.fromJson(Map<String, dynamic> json) {
    return InvoiceStatus(
        headerId: json['HEADER_ID'] as String?,
        lineId: json['LINE_ID'] as String?,
        articleNo: json['ARTICLE_NO'] as String?,
        shadedRoll: json['SHADED_ROLL'] as String?,
        totalRolls: json['TOTAL_ROLLS'] as String?,
        totalYards: json['TOTAL_YARDS'] as String?,
        attachedLength: json['ATTACHED_LENGTH'] as String?,
        attachedRoll: json['ATTACHED_ROLL'] as String?);
  }

  Map<String, dynamic> toJson() => {
        'HEADER_ID': headerId,
        'LINE_ID': lineId,
        'ARTICLE_NO': articleNo,
        'TOTAL_ROLLS': totalRolls,
        'TOTAL_YARDS': totalYards,
        'ATTACHED_LENGTH': attachedLength,
        'ATTACHED_ROLL': attachedRoll,
        'SHADED_ROLL': shadedRoll,
      };

  @override
  List<Object?> get props {
    return [
      headerId,
      lineId,
      articleNo,
      totalRolls,
      totalYards,
      attachedLength,
      attachedRoll,
      shadedRoll
    ];
  }
}
