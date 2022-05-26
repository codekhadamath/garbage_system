class Bin {
  final String name;
  final String id;
  final int filledPercent;

  Bin({required this.name, required this.id, required this.filledPercent});

  Bin.fromJson(Map<Object?, Object?> json) : this(
    name: json['name']! as String,
    id: json['id']! as String,
    filledPercent: json['filledPercent']! as int
  );

  Map<Object?, Object?> toJson() =>
      {'name': name, 'id': id, 'filledPercent': filledPercent};
}
