import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:noya_app/core/provider.dart';
import 'package:noya_app/core/resuable_comp/custom_text_field.dart';
import 'package:noya_app/core/resuable_comp/myBotton.dart';
import 'package:noya_app/core/resuable_comp/toast_message.dart';
import 'package:noya_app/core/resuable_comp/validator.dart';
import 'package:noya_app/core/utils/routes_manager.dart';
import 'package:noya_app/core/utils/string_manager.dart';
import 'package:noya_app/data/models/user%20model.dart';
import 'package:noya_app/firebase/firebasefunctions.dart';
import 'package:provider/provider.dart';

class ChangeEmailTab extends StatefulWidget {
  const ChangeEmailTab({super.key});

  @override
  State<ChangeEmailTab> createState() => _ChangeEmailTabState();
}

class _ChangeEmailTabState extends State<ChangeEmailTab> {
  final _formKey = GlobalKey<FormState>();
  final _newEmailController = TextEditingController();
  late Usermodel? user;

  @override
  void initState() {
    super.initState();
    user = Provider.of<DataProvider>(context, listen: false).userModel;
    _newEmailController.text = user?.email ?? "";
  }

  @override
  Widget build(BuildContext context) {
    var dataProvider = Provider.of<DataProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            CustomTextField(
              label: AppStrings.newEmail,
              controller: _newEmailController,
              validator: Validator.email,
            ),

            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: MyButton(
                    label: AppStrings.updateEmail,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        FirebaseFunctions.changeEmailWithoutVerification(
                          newEmail: _newEmailController.text.trim(),
                          onSuccess: () {
                            // update the data in firebase not in authentication but in the database
                            FirebaseAuth.instance.signOut();
                            dataProvider.setLogged(false);
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              RouteManager.loginScreen,
                              (route) => false,
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  AppStrings
                                      .onceYouVerifyYourEmailItWillBeUpdated,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                backgroundColor: Colors.green,
                                duration: const Duration(seconds: 15),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );

                            FirebaseFunctions.updateUserData(
                              userAddress: user?.userAddress,
                              firstName: user?.firstName,
                              lastName: user?.lastName,
                              phoneNumber: user?.phoneNumber,
                              email: _newEmailController.text.trim(),
                              onSuccess: () {},
                              onError: (error) {
                                toastMessage(
                                  message: AppStrings.yourDataNotUpdated,
                                  tybeMessage: TybeMessage.positive,
                                );
                              },
                            );
                            // update the data locally
                            Provider.of<DataProvider>(
                              context,
                              listen: false,
                            ).updateUserModel(
                              email: _newEmailController.text.trim(),
                            );
                          },
                          onError: (error) {
                            toastMessage(
                              message: error ?? AppStrings.somethingWentWrong,
                              tybeMessage: TybeMessage.negative,
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
    );
  }
}
