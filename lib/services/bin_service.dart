import 'package:garbage_system/models/bin_model.dart';
import 'package:garbage_system/models/place_model.dart';
import 'package:garbage_system/services/firestore_service.dart';

class BinService {
  static Future<void> addBin(
      {String? id,
      required String placeName,
      required String address,
      required String city,
      required String pinCode,
      required List<Bin> bins,
      required List<String> binImages}) async {
    if (id != null) {
      await FirestoreService.postsRef.child(id).set({
        'placeId': 'placeId',
        'placeName': placeName,
        'address': '$address, $city',
        'filledPercent': 0,
        'pinCode': pinCode,
        'binImages': binImages,
        'binsCount': bins.length,
        'bins': bins.map((bin) => bin.toJson()).toList()
      });
      return;
    }

    await FirestoreService.postsRef.push().set({
      'placeId': 'placeId',
      'placeName': placeName,
      'address': '$address, $city',
      'filledPercent': 0,
      'pinCode': pinCode,
      'binImages': binImages,
      'binsCount': bins.length,
      'bins': bins.map((bin) => bin.toJson()).toList()
    });
  }

  static Future<void> deleteBin(String id) async {
    await FirestoreService.postsRef.child(id).remove();
  }

  static Future<int> get numberOfBins async {
    final docs = await FirestoreService.postsRef.get();
    int noOfBins = 0;
    for (var doc in docs.children) {
      final place = Place.fromJson(doc.value as Map<Object?, Object?>);
      noOfBins += place.binsCount;
    }
    return noOfBins;
  }

  static Future<int> get numberOfPlaces async {
    final docs = await FirestoreService.postsRef.get();
    return docs.children.length;
  }
}
