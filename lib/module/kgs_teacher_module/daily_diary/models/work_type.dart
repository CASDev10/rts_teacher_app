class WorkType {
  String type;
  int id;

  WorkType({
    required this.type,
    required this.id,
  });

  WorkType copyWith({
    String? type,
    int? id,
  }) =>
      WorkType(
        type: type ?? this.type,
        id: id ?? this.id,
      );

  factory WorkType.fromJson(Map<String, dynamic> json) => WorkType(
        type: json["type"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "id": id,
      };
}
