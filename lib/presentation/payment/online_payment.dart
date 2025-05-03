import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:noya_app/core/resuable_comp/myBotton.dart';
import 'package:noya_app/core/resuable_comp/toast_message.dart';
import 'package:noya_app/core/utils/colors_manager.dart';
import 'package:noya_app/core/utils/routes_manager.dart';
import 'package:noya_app/core/utils/string_manager.dart';

class CreditCardTab extends StatefulWidget {
  const CreditCardTab({super.key});

  @override
  State<CreditCardTab> createState() => _CreditCardTabState();
}

class _CreditCardTabState extends State<CreditCardTab> {
  final _mainFormKey = GlobalKey<FormState>();
  final _creditCardFormKey = GlobalKey<FormState>();

  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _mainFormKey,
          child: Column(
            children: [
              CreditCardWidget(
                enableFloatingCard: true,
                cardBgColor: ColorManager.oliveGreen,
                floatingConfig: const FloatingConfig(
                  isGlareEnabled: true,
                  isShadowEnabled: true,
                  shadowConfig: FloatingShadowConfig(),
                ),
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                isHolderNameVisible: true,
                labelCardHolder: 'CARD HOLDER',
                cvvCode: cvvCode,
                showBackView: isCvvFocused,
                onCreditCardWidgetChange: (CreditCardBrand brand) {},
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CreditCardForm(
                        formKey: _creditCardFormKey,
                        cardNumber: cardNumber,
                        expiryDate: expiryDate,
                        cardHolderName: cardHolderName,
                        cvvCode: cvvCode,
                        onCreditCardModelChange: (CreditCardModel data) {
                          setState(() {
                            cardNumber = data.cardNumber;
                            expiryDate = data.expiryDate;
                            cardHolderName = data.cardHolderName;
                            cvvCode = data.cvvCode;
                            isCvvFocused = data.isCvvFocused;
                          });
                        },
                        obscureCvv: true,
                        enableCvv: true,
                        isCardHolderNameUpperCase: true,
                        disableCardNumberAutoFillHints: false,
                      ),
                      const SizedBox(height: 20),

                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: MyButton(
                      label: AppStrings.payNow,
                      onPressed: () {
                        if (_creditCardFormKey.currentState!.validate()) {
                          print('Credit card payment submitted');
                          toastMessage(
                            message: AppStrings.yourOrderHasBeenSent,
                            tybeMessage: TybeMessage.positive,
                          );
                          Navigator.pushNamed(
                            context,
                            RouteManager.mainScreen,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
