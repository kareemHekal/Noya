import 'package:flutter/material.dart';
import 'package:noya_app/core/resuable_comp/custom_text_field.dart';
import 'package:noya_app/core/resuable_comp/myBotton.dart';
import 'package:noya_app/core/resuable_comp/toast_message.dart';
import 'package:noya_app/core/resuable_comp/validator.dart';
import 'package:noya_app/core/utils/string_manager.dart';
import 'package:noya_app/firebase/firebasefunctions.dart';

class ChangePasswordTab extends StatefulWidget {
  const ChangePasswordTab({super.key});

  @override
  State<ChangePasswordTab> createState() => _ChangePasswordTabState();
}

class _ChangePasswordTabState extends State<ChangePasswordTab> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            CustomTextField(
              label: AppStrings.currentPassword,
              controller: _currentPasswordController,
              isSecure: true,
              validator: Validator.password,
            ),
            const SizedBox(height: 12),
            CustomTextField(
              label: AppStrings.newPassword,
              controller: _newPasswordController,
              isSecure: true,
              validator:
                  (value) =>
                      value == null || value.length < 6
                          ? AppStrings.min6Characters
                          : null,
            ),
            const SizedBox(height: 12),
            CustomTextField(
              label: AppStrings.confirmPassword,
              controller: _confirmPasswordController,
              isSecure: true,
              validator: (value) {
                if (value != _newPasswordController.text) {
                  return AppStrings.passwordsDoNotMatch;
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: MyButton(
                    label: AppStrings.updatePassword,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        FirebaseFunctions.changePassword(
                          currentPassword:
                              _currentPasswordController.text.trim(),
                          newPassword: _newPasswordController.text.trim(),
                          onSuccess: () {
                            toastMessage(
                              message: AppStrings.passwordUpdatedSuccessfully,
                              tybeMessage: TybeMessage.positive,
                            );
                            Navigator.pop(context);
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
