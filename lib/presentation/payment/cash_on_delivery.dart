import 'package:flutter/material.dart';
import 'package:noya_app/core/provider.dart';
import 'package:noya_app/core/resuable_comp/myBotton.dart';
import 'package:noya_app/core/resuable_comp/toast_message.dart';
import 'package:noya_app/core/resuable_comp/validator.dart';
import 'package:noya_app/core/utils/colors_manager.dart';
import 'package:noya_app/core/utils/routes_manager.dart';
import 'package:noya_app/core/utils/string_manager.dart';
import 'package:noya_app/presentation/tabs/counsultant/counslatunt_text_filds.dart';
import 'package:provider/provider.dart';

class CashOnDeliveryTab extends StatefulWidget {
  const CashOnDeliveryTab({super.key});

  @override
  State<CashOnDeliveryTab> createState() => _CashOnDeliveryTabState();
}

class _CashOnDeliveryTabState extends State<CashOnDeliveryTab> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _receiverNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _specificLocationController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    final user = Provider.of<DataProvider>(context, listen: false).userModel;

    if (user != null) {
      _receiverNameController.text = "${user.firstName} ${user.lastName}";
      _emailController.text = user.email;
      _phoneNumberController.text = user.phoneNumber ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = Theme.of(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 10,
            children: [
              Card(
                elevation: 3,
                shadowColor: ColorManager.mutedSageGreen,
                color:
                    currentTheme.brightness == Brightness.dark
                        ? ColorManager.oliveGreen
                        : ColorManager.softBeige,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.cashOnDeliveryTitle,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color:
                              currentTheme.brightness == Brightness.dark
                                  ? ColorManager.oliveGreen
                                  : ColorManager.softBeige,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        AppStrings.cashOnDeliveryBody,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color:
                              currentTheme.brightness == Brightness.dark
                                  ? ColorManager.oliveGreen
                                  : ColorManager.softBeige,
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 20,
                    children: [
                      CustomTextField(
                        label: AppStrings.receiverName,
                        controller: _receiverNameController,
                        validator: Validator.userName,
                      ),
                      CustomTextField(
                        label: AppStrings.emailHint,
                        controller: _emailController,
                        validator: Validator.email,
                      ),
                      CustomTextField(
                        label: AppStrings.phoneNumberHint,
                        controller: _phoneNumberController,
                        validator: Validator.phoneNumber,
                      ),
                      CustomTextField(
                        label: AppStrings.address,
                        controller: _addressController,
                        validator: Validator.userName,
                      ),
                      TextFormField(
                        controller: _specificLocationController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          labelText: AppStrings.specificLocation,
                          labelStyle: TextStyle(color: Colors.grey[600]),
                          prefixIcon: const Icon(
                            Icons.edit_note,
                            color: Colors.black87,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: const BorderSide(
                              color: ColorManager.oliveGreen,
                              width: 2,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: const BorderSide(
                              color: ColorManager.oliveGreen,
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: const BorderSide(
                              color: ColorManager.oliveGreen,
                              width: 2.0,
                            ),
                          ),
                          filled: true,
                          fillColor: ColorManager.softBeige,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 16.0,
                            horizontal: 20.0,
                          ),
                        ),
                        style: const TextStyle(color: Colors.black87),
                      ),
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
                        if (_formKey.currentState!.validate()) {
                          toastMessage(
                            message: AppStrings.yourOrderHasBeenSent,
                            tybeMessage: TybeMessage.positive,
                          );
                          Navigator.pushNamed(context, RouteManager.mainScreen);
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
