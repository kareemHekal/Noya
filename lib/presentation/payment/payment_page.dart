import 'package:flutter/material.dart';
import 'package:noya_app/core/utils/colors_manager.dart';
import 'package:noya_app/core/utils/string_manager.dart';
import 'cash_on_delivery.dart';
import 'online_payment.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Payment'),
          bottom: TabBar(
            labelColor: ColorManager.oliveGreen,
            indicatorColor: ColorManager.oliveGreen,
            tabs: [
              Tab(text:AppStrings.cardPayment),
              Tab(text:AppStrings.cashOnDelivery),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            CreditCardTab(),
            CashOnDeliveryTab(),
          ],
        ),
      ),
    );
  }
}
