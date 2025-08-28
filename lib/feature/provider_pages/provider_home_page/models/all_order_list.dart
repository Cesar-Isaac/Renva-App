

class AllOrderList {
  int id;
  String status;
  String? cancelReason;
  dynamic mainCategory;
  Category category;
  String description;
  Address address;
  dynamic date;
  dynamic startAt;
  dynamic endAt;
  String type;
  List<GalleryItem> gallery;
  Customer customer;
  DateTime createdAt;

  AllOrderList({
    required this.id,
    required this.status,
    this.cancelReason,
    required this.mainCategory,
    required this.category,
    required this.description,
    required this.address,
    required this.date,
    required this.startAt,
    required this.endAt,
    required this.type,
    required this.gallery,
    required this.customer,
    required this.createdAt,
  });

  factory AllOrderList.fromJson(Map<String, dynamic> json) => AllOrderList(
        id: json["id"],
        status: json["status"] ?? '',
        cancelReason: json["cancel_reason"],
        mainCategory: json["mainCategory"],
        category: Category.fromJson(json["category"]),
        description: json["description"] ?? '',
        address: Address.fromJson(json["address"]),
        date: json["date"],
        startAt: json["start_at"],
        endAt: json["end_at"],
        type: json["type"] ?? '',
        gallery: (json["gallery"] as List?)
                ?.map((e) => GalleryItem.fromJson(e))
                .toList() ??
            [],
        customer: Customer.fromJson(json["customer"]),
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "cancel_reason": cancelReason,
        "mainCategory": mainCategory,
        "category": category.toJson(),
        "description": description,
        "address": address.toJson(),
        "date": date,
        "start_at": startAt,
        "end_at": endAt,
        "type": type,
        "gallery": gallery.map((x) => x.toJson()).toList(),
        "customer": customer.toJson(),
        "created_at": createdAt.toIso8601String(),
      };
}
class GalleryItem {
  String uuid;
  String originalUrl;
  String mediumUrl;
  String smallUrl;
  String thumbUrl;

  GalleryItem({
    required this.uuid,
    required this.originalUrl,
    required this.mediumUrl,
    required this.smallUrl,
    required this.thumbUrl,
  });

  factory GalleryItem.fromJson(Map<String, dynamic> json) => GalleryItem(
        uuid: json['uuid'],
        originalUrl: json['original_url'] ?? '',
        mediumUrl: json['medium_url'] ?? '',
        smallUrl: json['small_url'] ?? '',
        thumbUrl: json['thumb_url'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'uuid': uuid,
        'original_url': originalUrl,
        'medium_url': mediumUrl,
        'small_url': smallUrl,
        'thumb_url': thumbUrl,
      };
}
class Address {
  int id;
  String? title;
  String latitude;
  String longitude;

  Address({
    required this.id,
    this.title,
    required this.latitude,
    required this.longitude,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        title: json["title"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "latitude": latitude,
        "longitude": longitude,
      };
}
class Category {
  int id;
  String title;
  String svg;
  int minPrice;
  int maxPrice;
  List<String> description;
  int prvCnt;
  List<dynamic> keywords;

  Category({
    required this.id,
    required this.title,
    required this.svg,
    required this.minPrice,
    required this.maxPrice,
    required this.description,
    required this.prvCnt,
    required this.keywords,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        title: json["title"] ?? '',
        svg: json["svg"] ?? '',
        minPrice: json["min_price"] ?? 0,
        maxPrice: json["max_price"] ?? 0,
        description:
            (json["description"] as List?)?.map((e) => e.toString()).toList() ??
                [],
        prvCnt: json["prv_cnt"] ?? 0,
        keywords: json["keywords"] ?? [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "svg": svg,
        "min_price": minPrice,
        "max_price": maxPrice,
        "description": description,
        "prv_cnt": prvCnt,
        "keywords": keywords,
      };
}
class Customer {
  int id;
  String firstName;
  String lastName;
  String email;
  String nationalId;
  String dialCountryCode;
  String phone;
  DateTime phoneVerifiedAt;
  int isCompleted;
  dynamic gender;
  Avatar avatar;
  Avatar iDcard;
  List<dynamic> addresses;
  int customerId;
  int rate;
  int ordersCnt;
  int points;
  int pointsInSp;

  Customer({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.nationalId,
    required this.dialCountryCode,
    required this.phone,
    required this.phoneVerifiedAt,
    required this.isCompleted,
    required this.gender,
    required this.avatar,
    required this.iDcard,
    required this.addresses,
    required this.customerId,
    required this.rate,
    required this.ordersCnt,
    required this.points,
    required this.pointsInSp,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        nationalId: json["nationalID"],
        dialCountryCode: json["dial_country_code"],
        phone: json["phone"],
        phoneVerifiedAt: DateTime.parse(json["phone_verified_at"]),
        isCompleted: json["is_completed"],
        gender: json["gender"],
        avatar: Avatar.fromJson(json["avatar"]),
        iDcard: Avatar.fromJson(json["IDcard"]),
        addresses: List<dynamic>.from(json["addresses"].map((x) => x)),
        customerId: json["customer_id"],
        rate: json["rate"],
        ordersCnt: json["orders_cnt"],
        points: json["points"],
        pointsInSp: json["points_in_sp"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "nationalID": nationalId,
        "dial_country_code": dialCountryCode,
        "phone": phone,
        "phone_verified_at": phoneVerifiedAt.toIso8601String(),
        "is_completed": isCompleted,
        "gender": gender,
        "avatar": avatar.toJson(),
        "IDcard": iDcard.toJson(),
        "addresses": List<dynamic>.from(addresses.map((x) => x)),
        "customer_id": customerId,
        "rate": rate,
        "orders_cnt": ordersCnt,
        "points": points,
        "points_in_sp": pointsInSp,
      };
}
class Avatar {
  String originalUrl;
  String mediumUrl;
  String smallUrl;
  String thumbUrl;

  Avatar({
    required this.originalUrl,
    required this.mediumUrl,
    required this.smallUrl,
    required this.thumbUrl,
  });

  factory Avatar.fromJson(Map<String, dynamic> json) => Avatar(
        originalUrl: json["original_url"] ?? '',
        mediumUrl: json["medium_url"] ?? '',
        smallUrl: json["small_url"] ?? '',
        thumbUrl: json["thumb_url"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "original_url": originalUrl,
        "medium_url": mediumUrl,
        "small_url": smallUrl,
        "thumb_url": thumbUrl,
      };
}
