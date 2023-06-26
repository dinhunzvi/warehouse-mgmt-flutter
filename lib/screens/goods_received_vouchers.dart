import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:varichem_warehouse/models/goods_received_voucher.dart';
import 'package:varichem_warehouse/providers/goods_received_voucher_provider.dart';

class GoodsReceivedVouchers extends StatefulWidget {
  const GoodsReceivedVouchers({super.key});


  @override
  State<GoodsReceivedVouchers> createState() => _GoodsReceivedVouchers();

}

class _GoodsReceivedVouchers extends State<GoodsReceivedVouchers> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GoodsReceivedVoucherProvider>( context, listen: true);

    List<GoodsReceivedVoucher> goodsReceivedVouchers =
    provider.allGoodsReceivedVouchers();

    return Scaffold(
      appBar: AppBar(
        title: const Text( 'Goods received vouchers' ),
      ),
      body: ListView.builder(
        itemCount: goodsReceivedVouchers.length,
          itemBuilder: ( context, index ) {

          GoodsReceivedVoucher goodsReceivedVoucher = goodsReceivedVouchers[index];

            return ListTile(
              title: Text( goodsReceivedVoucher.reference),
              subtitle: Text(goodsReceivedVoucher.dateReceived),
              trailing: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text( goodsReceivedVoucher.processedBy)
                ],
              ),
            );
          }),
    );
  }

}




