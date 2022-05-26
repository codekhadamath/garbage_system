class Place {
  String? key;
  final String placeId;
  final String placeName;
  final String address;
  final String pinCode;
  final int filledPercent;
  final int binsCount;
  final List<dynamic> binImages;

  Place(
      {required this.placeId,
      required this.placeName,
      required this.address,
      required this.pinCode,
      required this.filledPercent,
      required this.binsCount,
      required this.binImages});

  Place.fromJson(Map<Object?, Object?> json)
      : this(
          placeId: json['placeId']! as String,
          placeName: json['placeName']! as String,
          address: json['address']! as String,
          pinCode: json['pinCode']! as String,
          filledPercent: json['filledPercent']! as int,
          binsCount: json['binsCount']! as int,
          binImages: json['binImages']! as List<dynamic>,
        );

  Map<Object?, Object?> toJson() => {
        'placeId': placeId,
        'placeName': placeName,
        'address': address,
        'pinCode': pinCode,
        'filledPercent': filledPercent,
        'binsCount': binsCount,
        'binImages': binImages,
      };
}
