import 'package:mobile_store/src/models/district.dart';
import 'package:mobile_store/src/models/province.dart';
import 'package:mobile_store/src/models/village.dart';
import 'package:mobile_store/src/repository/location_repo.dart';

class LocationController {
  LocationRepository locationRepository = LocationRepository();
  Future<List<Province>> getProvince() async {
    var repo = await locationRepository.getDataProvince();
    if (repo.statusCode == 200) {
      final data = repo.data;
      if (data != null) {
        return Province.fromJsonList(data);
      }
    } else {
      return [];
    }
    return [];
  }

  Future<List<District>> getDistrict(String id) async {
    var repo = await locationRepository.getDataDistrict(id);
    if (repo.statusCode == 200) {
      final data = repo.data;
      if (data != null) {
        return District.fromJsonList(data);
      }
    } else if (repo.statusCode == 404) {
      return [];
    }
    return [];
  }

  Future<List<Village>> getVillage(String id) async {
    var repo = await locationRepository.getDataVillage(id);
    if (repo.statusCode == 200) {
      final data = repo.data;
      if (data != null) {
        return Village.fromJsonList(data);
      }
    } else {
      return [];
    }
    return [];
  }
}


/*
 // Gọi API bắt Province
  Future<List<Province>> getDataProvince() async {
    var response = await Dio().get(
      "https://location-vn.herokuapp.com/api/province",
    );

    final data = response.data;
    if (data != null) {
      return Province.fromJsonList(data);
    }
    return [];
  }

  // gọi API bắt District
  Future<List<District>> getDataDicstrict(String id) async {
    var response = await Dio().get(
      "https://location-vn.herokuapp.com/api/province/$id/district",
    );

    final data = response.data;
    if (data != null) {
      return District.fromJsonList(data);
    }
    return [];
  }

  // gọi API bắt Village
  Future<List<Village>> getDataVillage(String id) async {
    var response = await Dio().get(
      "https://location-vn.herokuapp.com/api/district/$id/village",
    );
    var h = response.statusCode;
    //print(h);
    final data = response.data;
    if (data != null) {
      return Village.fromJsonList(data);
    }
    return [];
  }
 */