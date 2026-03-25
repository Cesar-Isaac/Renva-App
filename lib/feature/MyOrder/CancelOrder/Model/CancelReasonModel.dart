import 'dart:convert';

class CancelReasonModel {
  int id;
  String reasonText;

  CancelReasonModel({
    required this.id,
    required this.reasonText,
  });

  factory CancelReasonModel.fromRawJson(String str) =>
      CancelReasonModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CancelReasonModel.fromJson(Map<String, dynamic> json) =>
      CancelReasonModel(
        id: json["id"],
        reasonText: json["reason_text"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "reason_text": reasonText,
      };
}
