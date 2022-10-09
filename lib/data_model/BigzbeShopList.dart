// To parse this JSON data, do
//
//     final bigzbeShopList = bigzbeShopListFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<BigzbeShopList> bigzbeShopListFromMap(String str) => List<BigzbeShopList>.from(json.decode(str).map((x) => BigzbeShopList.fromMap(x)));

String bigzbeShopListToMap(List<BigzbeShopList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class BigzbeShopList {
  BigzbeShopList({
    @required this.id,
    @required this.userId,
    @required this.name,
    @required this.logo,
    @required this.sliders,
    @required this.phone,
    @required this.address,
    @required this.rating,
    @required this.numOfReviews,
    @required this.numOfSale,
    @required this.sellerPackageId,
    @required this.productUploadLimit,
    @required this.packageInvalidAt,
    @required this.verificationStatus,
    @required this.verificationInfo,
    @required this.cashOnDeliveryStatus,
    @required this.adminToPay,
    @required this.facebook,
    @required this.instagram,
    @required this.google,
    @required this.twitter,
    @required this.youtube,
    @required this.slug,
    @required this.metaTitle,
    @required this.metaDescription,
    @required this.pickUpPointId,
    @required this.shippingCost,
    @required this.deliveryPickupLatitude,
    @required this.deliveryPickupLongitude,
    @required this.bankName,
    @required this.bankAccName,
    @required this.bankAccNo,
    @required this.bankRoutingNo,
    @required this.bankPaymentStatus,
    @required this.isDiscounted,
    @required this.flatDiscount,
    @required this.shopCategory,
    @required this.city,
    @required this.createdAt,
    @required this.updatedAt,
    @required this.user,
  });

  final int id;
  final String userId;
  final String name;
  final String logo;
  final dynamic sliders;
  final String phone;
  final String address;
  final String rating;
  final String numOfReviews;
  final String numOfSale;
  final dynamic sellerPackageId;
  final String productUploadLimit;
  final dynamic packageInvalidAt;
  final String verificationStatus;
  final dynamic verificationInfo;
  final String cashOnDeliveryStatus;
  final String adminToPay;
  final dynamic facebook;
  final dynamic instagram;
  final dynamic google;
  final dynamic twitter;
  final dynamic youtube;
  final String slug;
  final String metaTitle;
  final String metaDescription;
  final dynamic pickUpPointId;
  final String shippingCost;
  final dynamic deliveryPickupLatitude;
  final dynamic deliveryPickupLongitude;
  final dynamic bankName;
  final dynamic bankAccName;
  final dynamic bankAccNo;
  final dynamic bankRoutingNo;
  final String bankPaymentStatus;
  final String isDiscounted;
  final String flatDiscount;
  final String shopCategory;
  final String city;
  final DateTime createdAt;
  final DateTime updatedAt;
  final User user;

  factory BigzbeShopList.fromMap(Map<String, dynamic> json) => BigzbeShopList(
    id: json["id"],
    userId: json["user_id"],
    name: json["name"],
    logo: json["logo"] == null ? null : json["logo"],
    sliders: json["sliders"],
    phone: json["phone"],
    address: json["address"],
    rating: json["rating"],
    numOfReviews: json["num_of_reviews"],
    numOfSale: json["num_of_sale"],
    sellerPackageId: json["seller_package_id"],
    productUploadLimit: json["product_upload_limit"],
    packageInvalidAt: json["package_invalid_at"],
    verificationStatus: json["verification_status"],
    verificationInfo: json["verification_info"],
    cashOnDeliveryStatus: json["cash_on_delivery_status"],
    adminToPay: json["admin_to_pay"],
    facebook: json["facebook"],
    instagram: json["instagram"],
    google: json["google"],
    twitter: json["twitter"],
    youtube: json["youtube"],
    slug: json["slug"],
    metaTitle: json["meta_title"],
    metaDescription: json["meta_description"],
    pickUpPointId: json["pick_up_point_id"],
    shippingCost: json["shipping_cost"],
    deliveryPickupLatitude: json["delivery_pickup_latitude"],
    deliveryPickupLongitude: json["delivery_pickup_longitude"],
    bankName: json["bank_name"],
    bankAccName: json["bank_acc_name"],
    bankAccNo: json["bank_acc_no"],
    bankRoutingNo: json["bank_routing_no"],
    bankPaymentStatus: json["bank_payment_status"],
    isDiscounted: json["is_discounted"],
    flatDiscount: json["flat_discount"],
    shopCategory: json["shop_category"],
    city: json["city"] == null ? null : json["city"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    user: User.fromMap(json["user"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "user_id": userId,
    "name": name,
    "logo": logo == null ? null : logo,
    "sliders": sliders,
    "phone": phone,
    "address": address,
    "rating": rating,
    "num_of_reviews": numOfReviews,
    "num_of_sale": numOfSale,
    "seller_package_id": sellerPackageId,
    "product_upload_limit": productUploadLimit,
    "package_invalid_at": packageInvalidAt,
    "verification_status": verificationStatus,
    "verification_info": verificationInfo,
    "cash_on_delivery_status": cashOnDeliveryStatus,
    "admin_to_pay": adminToPay,
    "facebook": facebook,
    "instagram": instagram,
    "google": google,
    "twitter": twitter,
    "youtube": youtube,
    "slug": slug,
    "meta_title": metaTitle,
    "meta_description": metaDescription,
    "pick_up_point_id": pickUpPointId,
    "shipping_cost": shippingCost,
    "delivery_pickup_latitude": deliveryPickupLatitude,
    "delivery_pickup_longitude": deliveryPickupLongitude,
    "bank_name": bankName,
    "bank_acc_name": bankAccName,
    "bank_acc_no": bankAccNo,
    "bank_routing_no": bankRoutingNo,
    "bank_payment_status": bankPaymentStatus,
    "is_discounted": isDiscounted,
    "flat_discount": flatDiscount,
    "shop_category": shopCategory,
    "city": city == null ? null : city,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "user": user.toMap(),
  };
}

class User {
  User({
    @required this.id,
    @required this.referredBy,
    @required this.providerId,
    @required this.userType,
    @required this.name,
    @required this.email,
    @required this.emailVerifiedAt,
    @required this.verificationCode,
    @required this.newEmailVerificiationCode,
    @required this.deviceToken,
    @required this.avatar,
    @required this.avatarOriginal,
    @required this.address,
    @required this.country,
    @required this.state,
    @required this.city,
    @required this.postalCode,
    @required this.phone,
    @required this.balance,
    @required this.banned,
    @required this.referralCode,
    @required this.customerPackageId,
    @required this.remainingUploads,
    @required this.createdAt,
    @required this.updatedAt,
  });

  final int id;
  final dynamic referredBy;
  final dynamic providerId;
  final String userType;
  final String name;
  final String email;
  final DateTime emailVerifiedAt;
  final dynamic verificationCode;
  final dynamic newEmailVerificiationCode;
  final String deviceToken;
  final dynamic avatar;
  final dynamic avatarOriginal;
  final dynamic address;
  final dynamic country;
  final dynamic state;
  final dynamic city;
  final dynamic postalCode;
  final dynamic phone;
  final String balance;
  final String banned;
  final dynamic referralCode;
  final dynamic customerPackageId;
  final String remainingUploads;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory User.fromMap(Map<String, dynamic> json) => User(
    id: json["id"],
    referredBy: json["referred_by"],
    providerId: json["provider_id"],
    userType: json["user_type"],
    name: json["name"],
    email: json["email"],
    emailVerifiedAt: DateTime.parse(json["email_verified_at"]),
    verificationCode: json["verification_code"],
    newEmailVerificiationCode: json["new_email_verificiation_code"],
    deviceToken: json["device_token"] == null ? null : json["device_token"],
    avatar: json["avatar"],
    avatarOriginal: json["avatar_original"],
    address: json["address"],
    country: json["country"],
    state: json["state"],
    city: json["city"],
    postalCode: json["postal_code"],
    phone: json["phone"],
    balance: json["balance"],
    banned: json["banned"],
    referralCode: json["referral_code"],
    customerPackageId: json["customer_package_id"],
    remainingUploads: json["remaining_uploads"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "referred_by": referredBy,
    "provider_id": providerId,
    "user_type": userType,
    "name": name,
    "email": email,
    "email_verified_at": emailVerifiedAt.toIso8601String(),
    "verification_code": verificationCode,
    "new_email_verificiation_code": newEmailVerificiationCode,
    "device_token": deviceToken == null ? null : deviceToken,
    "avatar": avatar,
    "avatar_original": avatarOriginal,
    "address": address,
    "country": country,
    "state": state,
    "city": city,
    "postal_code": postalCode,
    "phone": phone,
    "balance": balance,
    "banned": banned,
    "referral_code": referralCode,
    "customer_package_id": customerPackageId,
    "remaining_uploads": remainingUploads,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
