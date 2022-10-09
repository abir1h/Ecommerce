import 'dart:convert';
import 'package:active_ecommerce_flutter/app_config.dart';
import 'package:active_ecommerce_flutter/data_model/offline_wallet_recharge_response.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OfflineWalletRechargeRepository{
 Future<OfflineWalletRechargeResponse> getOfflineWalletRechargeResponse({@required String amount,
  @required String name,
  @required String trx_id,
  @required int photo})async{


    var post_body = jsonEncode({
      "amount": "$amount",
      "payment_option": "Offline Payment",
      "trx_id": "$trx_id",
      "photo": "$photo",
    });
    Uri url = Uri.parse("${AppConfig.BASE_URL}/wallet/offline-recharge");
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${access_token.$}",
          "App-Language": app_language.$
        },
        body: post_body);
     print("hello Offline wallet recharge" + response.body.toString());
     return offlineWalletRechargeResponseFromJson(response.body);
  }
}