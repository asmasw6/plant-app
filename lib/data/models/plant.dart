// ignore_for_file: public_member_api_docs, sort_constructors_first
class Plant {

  late int Id ;
  late String name;
  late List<String> scientificName;
  late String cycle;
  late String watering;
  late List<String> sunlight;
  late DefaultImage? defaultImage;

  Plant({
    required this.Id,
    required this.name,
    required this.scientificName,
    required this.cycle,
    required this.watering,
    required this.sunlight,
    required this.defaultImage
  });

  Plant.fromJson(Map<String, dynamic> json) {
    Id = json['id'];
    name = json['common_name'];
    scientificName = json['scientific_name'].cast<String>();
    cycle = json['cycle'];
    watering = json['watering'];
    sunlight = json['sunlight'].cast<String>();
    defaultImage = json['default_image'] != null ? DefaultImage.fromJson(json['default_image']) : null ;
  }
}

class DefaultImage {
  late String? originalUrl;
  late String? smallUrl;

  DefaultImage({
    required this.originalUrl,
    required this.smallUrl,
  });

  DefaultImage.fromJson(Map<String, dynamic> json) {
    originalUrl = json['original_url'];
    smallUrl = json['small_url'];
  }

 
}















  /*late int charId ;
  late String name;
  late String nickName;
  late String image;
  late List<dynamic> jobs;
  late String status;
  late List<dynamic> apperanceOfSeasons;
  late String actorName;
  late String categoryForTwoSeries;
  late List<dynamic> betterCallSaulAppearance;
  
  Charachter({
    required this.charId,
    required this.name,
    required this.nickName,
    required this.image,
    required this.jobs,
    required this.status,
    required this.apperanceOfSeasons,
    required this.actorName,
    required this.categoryForTwoSeries,
    required this.betterCallSaulAppearance,
  });

  Charachter.fromJson(Map<String, dynamic> json){
    charId= json['char_id'];
    name = json["name"];
    nickName = json['nickname'];
    image = json['img'];
    jobs = json['occupation'];
    status = json['status'];
    apperanceOfSeasons = json['appearance'];
    actorName = json['portrayed'];
    categoryForTwoSeries = json['category'];
    betterCallSaulAppearance = json['better_call_saul_appearance'];
    

  }
*/