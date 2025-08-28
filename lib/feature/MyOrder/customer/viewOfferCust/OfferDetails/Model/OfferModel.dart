import 'dart:convert';

class OfferModel {
  int id;
  String description;
  int price;
  String time;
  String status;
  dynamic declineReason;
  Provider provider;
  Order order;
  List<Gallery> gallery;

  OfferModel({
    required this.id,
    required this.description,
    required this.price,
    required this.time,
    required this.status,
    required this.declineReason,
    required this.provider,
    required this.order,
    required this.gallery,
  });

  factory OfferModel.fromRawJson(String str) =>
      OfferModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OfferModel.fromJson(Map<String, dynamic> json) => OfferModel(
        id: json["id"],
        description: json["description"],
        price: json["price"],
        time: json["time"],
        status: json["status"],
        declineReason: json["decline_reason"],
        provider: Provider.fromJson(json["provider"]),
        order: Order.fromJson(json["order"]),
        gallery:
            List<Gallery>.from(json["gallery"].map((x) => Gallery.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "price": price,
        "time": time,
        "status": status,
        "decline_reason": declineReason,
        "provider": provider.toJson(),
        "order": order.toJson(),
        "gallery": List<dynamic>.from(gallery.map((x) => x.toJson())),
      };
}

class Gallery {
  String originalUrl;

  Gallery({
    required this.originalUrl,
  });

  factory Gallery.fromRawJson(String str) => Gallery.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Gallery.fromJson(Map<String, dynamic> json) => Gallery(
        originalUrl: json["original_url"],
      );

  Map<String, dynamic> toJson() => {
        "original_url": originalUrl,
      };
}

class Order {
  int id;
  String status;
  dynamic cancelReason;
  Category category;
  String description;
  Address address;
  DateTime date;
  String startAt;
  String endAt;
  String type;
  int viewerCnt;
  int offerCnt;
  DateTime createdAt;
  List<dynamic> tags;
  dynamic provider;
  dynamic transaction;
  List<dynamic> mentions;
  List<Gallery> gallery;
  List<Provider> offeredProviders;
  Customer customer;

  Order({
    required this.id,
    required this.status,
    required this.cancelReason,
    required this.category,
    required this.description,
    required this.address,
    required this.date,
    required this.startAt,
    required this.endAt,
    required this.type,
    required this.viewerCnt,
    required this.offerCnt,
    required this.createdAt,
    required this.tags,
    required this.provider,
    required this.transaction,
    required this.mentions,
    required this.gallery,
    required this.offeredProviders,
    required this.customer,
  });

  factory Order.fromRawJson(String str) => Order.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        status: json["status"],
        cancelReason: json["cancel_reason"],
        category: Category.fromJson(json["category"]),
        description: json["description"],
        address: Address.fromJson(json["address"]),
        date: DateTime.parse(json["date"]),
        startAt: json["start_at"],
        endAt: json["end_at"],
        type: json["type"],
        viewerCnt: json["viewer_cnt"],
        offerCnt: json["offer_cnt"],
        createdAt: DateTime.parse(json["created_at"]),
        tags: List<dynamic>.from(json["tags"].map((x) => x)),
        provider: json["provider"],
        transaction: json["transaction"],
        mentions: List<dynamic>.from(json["mentions"].map((x) => x)),
        gallery:
            List<Gallery>.from(json["gallery"].map((x) => Gallery.fromJson(x))),
        offeredProviders: List<Provider>.from(
            json["offeredProviders"].map((x) => Provider.fromJson(x))),
        customer: Customer.fromJson(json["customer"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "cancel_reason": cancelReason,
        "category": category.toJson(),
        "description": description,
        "address": address.toJson(),
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "start_at": startAt,
        "end_at": endAt,
        "type": type,
        "viewer_cnt": viewerCnt,
        "offer_cnt": offerCnt,
        "created_at": createdAt.toIso8601String(),
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "provider": provider,
        "transaction": transaction,
        "mentions": List<dynamic>.from(mentions.map((x) => x)),
        "gallery": List<dynamic>.from(gallery.map((x) => x.toJson())),
        "offeredProviders":
            List<dynamic>.from(offeredProviders.map((x) => x.toJson())),
        "customer": customer.toJson(),
      };
}

class Address {
  int id;
  String title;
  String lat;
  String long;

  Address({
    required this.id,
    required this.title,
    required this.lat,
    required this.long,
  });

  factory Address.fromRawJson(String str) => Address.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        title: json["title"],
        lat: json["lat"],
        long: json["long"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "lat": lat,
        "long": long,
      };
}

class Category {
  int id;
  String title;
  int prvCnt;
  List<Keyword> keywords;
  Gallery banner;

  Category({
    required this.id,
    required this.title,
    required this.prvCnt,
    required this.keywords,
    required this.banner,
  });

  factory Category.fromRawJson(String str) =>
      Category.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        title: json["title"],
        prvCnt: json["prv_cnt"],
        keywords: List<Keyword>.from(
            json["keywords"].map((x) => Keyword.fromJson(x))),
        banner: Gallery.fromJson(json["banner"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "prv_cnt": prvCnt,
        "keywords": List<dynamic>.from(keywords.map((x) => x.toJson())),
        "banner": banner.toJson(),
      };
}

class Keyword {
  String title;

  Keyword({
    required this.title,
  });

  factory Keyword.fromRawJson(String str) => Keyword.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Keyword.fromJson(Map<String, dynamic> json) => Keyword(
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
      };
}

class Customer {
  int id;
  String firstName;
  String lastName;
  dynamic email;
  String dialCountryCode;
  String phone;
  String gender;
  DateTime birthday;
  String region;
  Gallery avatar;
  List<Address> addresses;
  int customerId;
  int rate;
  int points;

  Customer({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.dialCountryCode,
    required this.phone,
    required this.gender,
    required this.birthday,
    required this.region,
    required this.avatar,
    required this.addresses,
    required this.customerId,
    required this.rate,
    required this.points,
  });

  factory Customer.fromRawJson(String str) =>
      Customer.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        dialCountryCode: json["dial_country_code"],
        phone: json["phone"],
        gender: json["gender"],
        birthday: DateTime.parse(json["birthday"]),
        region: json["region"],
        avatar: Gallery.fromJson(json["avatar"]),
        addresses: List<Address>.from(
            json["addresses"].map((x) => Address.fromJson(x))),
        customerId: json["customer_id"],
        rate: json["rate"],
        points: json["points"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "dial_country_code": dialCountryCode,
        "phone": phone,
        "gender": gender,
        "birthday": birthday.toIso8601String(),
        "region": region,
        "avatar": avatar.toJson(),
        "addresses": List<dynamic>.from(addresses.map((x) => x.toJson())),
        "customer_id": customerId,
        "rate": rate,
        "points": points,
      };
}

class Provider {
  int id;
  String name;
  String description;
  String dialCountryCode;
  String phone;
  int userId;
  Gallery avatar;
  List<Gallery> gallery;
  int rate;
  List<dynamic> reviews;
  int balance;
  dynamic address;

  Provider({
    required this.id,
    required this.name,
    required this.description,
    required this.dialCountryCode,
    required this.phone,
    required this.userId,
    required this.avatar,
    required this.gallery,
    required this.rate,
    required this.reviews,
    required this.balance,
    required this.address,
  });

  factory Provider.fromRawJson(String str) =>
      Provider.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Provider.fromJson(Map<String, dynamic> json) => Provider(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        dialCountryCode: json["dial_country_code"],
        phone: json["phone"],
        userId: json["user_id"],
        avatar: Gallery.fromJson(json["avatar"]),
        gallery:
            List<Gallery>.from(json["gallery"].map((x) => Gallery.fromJson(x))),
        rate: json["rate"],
        reviews: List<dynamic>.from(json["reviews"].map((x) => x)),
        balance: json["balance"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "dial_country_code": dialCountryCode,
        "phone": phone,
        "user_id": userId,
        "avatar": avatar.toJson(),
        "gallery": List<dynamic>.from(gallery.map((x) => x.toJson())),
        "rate": rate,
        "reviews": List<dynamic>.from(reviews.map((x) => x)),
        "balance": balance,
        "address": address,
      };
}
