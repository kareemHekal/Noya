import 'package:flutter/material.dart';
import 'package:noya_app/core/provider.dart';
import 'package:noya_app/core/resuable_comp/custom_text_field.dart';
import 'package:noya_app/core/resuable_comp/myBotton.dart';
import 'package:noya_app/core/resuable_comp/toast_message.dart';
import 'package:noya_app/core/resuable_comp/validator.dart';
import 'package:noya_app/core/utils/string_manager.dart';
import 'package:noya_app/data/models/user%20model.dart';
import 'package:noya_app/firebase/firebasefunctions.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _userAddressController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  late Usermodel? user;

  @override
  void initState() {
    super.initState();
    user = Provider.of<DataProvider>(context, listen: false).userModel;

    if (user != null) {
      _firstNameController.text = user?.firstName ?? "";
      _lastNameController.text = user?.lastName ?? "";
      _userAddressController.text = user?.userAddress ?? "";
      _phoneNumberController.text = user?.phoneNumber ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.editProfile)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              spacing: 16,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        label: AppStrings.firstNameHint,
                        controller: _firstNameController,
                        validator: Validator.firstName,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: CustomTextField(
                        label: AppStrings.lastNameHint,
                        controller: _lastNameController,
                        validator: Validator.firstName,
                      ),
                    ),
                  ],
                ),
                CustomTextField(
                  label: AppStrings.phoneNumberHint,
                  controller: _phoneNumberController,
                  validator: Validator.phoneNumber,
                  isPhoneNumber: true,
                ),
                CustomTextField(
                  label: AppStrings.userAddressHint,
                  controller: _userAddressController,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: MyButton(
                        label: AppStrings.save,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            FirebaseFunctions.updateUserData(
                              email: user?.email ?? "",
                              firstName: _firstNameController.text.trim(),
                              lastName: _lastNameController.text.trim(),
                              phoneNumber: _phoneNumberController.text.trim(),
                              userAddress: _userAddressController.text.trim(),
                              onSuccess: () {
                                Provider.of<DataProvider>(
                                  context,
                                  listen: false,
                                ).updateUserModel(
                                  firstName: _firstNameController.text.trim(),
                                  lastName: _lastNameController.text.trim(),
                                  phoneNumber:
                                      _phoneNumberController.text.trim(),
                                  address: _userAddressController.text.trim(),
                                );

                                toastMessage(
                                  message:
                                      AppStrings.yourDataUpdatedSuccessfully,
                                  tybeMessage: TybeMessage.positive,
                                );
                                Navigator.pop(context);
                              },
                              onError: (error) {
                                toastMessage(
                                  message: AppStrings.yourDataNotUpdated,
                                  tybeMessage: TybeMessage.positive,
                                );
                              },
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
      ),
    );
  }
}
