import 'package:equatable/equatable.dart';

class InvoiceDetails extends Equatable {
  final String? headerId;
  final String? articleNo;
  final String? articlesNo;
  final String? totalRolls;
  final String? totalYards;
  final String? attachedLength;
  final String? attachedRoll;

  const InvoiceDetails(
      {this.headerId,
      this.articleNo,
      this.articlesNo,
      this.totalRolls,
      this.totalYards,
      this.attachedLength,
      this.attachedRoll});

  factory InvoiceDetails.fromJson(Map<String, dynamic> json) {
    return InvoiceDetails(
        headerId: json['HEADER_ID'] as String?,
        articleNo: json['ARTICLE_NO'] as String?,
        articlesNo: json['ARTICLES_NO'] as String?,
        totalRolls: json['TOTAL_ROLLS'] as String?,
        totalYards: json['TOTAL_YARDS'] as String?,
        attachedLength: json['ATTACHED_LENGTH'] as String?,
        attachedRoll: json['ATTACHED_ROLL'] as String?);
  }

  Map<String, dynamic> toJson() => {
        'HEADER_ID': headerId,
        'ARTICLE_NO': articleNo,
        'ARTICLES_NO': articlesNo,
        'TOTAL_ROLLS': totalRolls,
        'TOTAL_YARDS': totalYards,
        'ATTACHED_LENGTH': attachedLength,
        'ATTACHED_ROLL': attachedRoll
      };

  @override
  List<Object?> get props {
    return [
      headerId,
      articleNo,
      articlesNo,
      totalRolls,
      totalYards,
      attachedLength,
      attachedRoll,
    ];
  }
}
