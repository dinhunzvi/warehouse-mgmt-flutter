import 'package:flutter/material.dart';
import 'package:varichem_warehouse/providers/auth_provider.dart';

import '../models/goods_received_voucher.dart';
import '../services/api_service.dart';

class GoodsReceivedVoucherProvider extends ChangeNotifier {
  List<GoodsReceivedVoucher> goodsReceivedVouchers = [];

  late AuthProvider authProvider;

  late ApiService apiService;

  GoodsReceivedVoucherProvider( this.authProvider) {
    apiService = ApiService( authProvider.token);

    init();
  }

  Future<void> init() async {
    goodsReceivedVouchers = await apiService.getGoodsReceivedVouchers();

    notifyListeners();

  }

  get allGoodsReceivedVouchers {
    return goodsReceivedVouchers;
  }


}