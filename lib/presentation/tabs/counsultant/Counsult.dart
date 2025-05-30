import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noya_app/core/resuable_comp/custom_text_field.dart';
import 'package:noya_app/core/resuable_comp/drop_down.dart';
import 'package:noya_app/core/resuable_comp/myBotton.dart';
import 'package:noya_app/core/resuable_comp/validator.dart';
import 'package:noya_app/core/utils/colors_manager.dart';
import 'package:noya_app/core/utils/string_manager.dart';
import 'package:noya_app/presentation/timer/timer_page.dart';
import 'package:noya_app/presentation/timer/view_model/cubit.dart';

class Counsult extends StatefulWidget {
  const Counsult({super.key});

  @override
  State<Counsult> createState() => _CounsultState();
}

class _CounsultState extends State<Counsult> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _cityLocationController = TextEditingController();
  final TextEditingController _additionalNotesController =
      TextEditingController();

  String? _selectedApartmentSize;
  String? _selectedBudget;

  final List<String> apartmentSizes = [
    AppStrings.studio,
    AppStrings.oneBedroom,
    AppStrings.twoBedroom,
    AppStrings.threeBedroom,
    AppStrings.fourPlusBedroom,
  ];

  final List<String> budgetOptions = [
    AppStrings.under15000,
    AppStrings.from15000to30000,
    AppStrings.from30000to50000,
    AppStrings.above50000,
  ];

  @override
  Widget build(BuildContext context) {
    final currentTheme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(AppStrings.interiorConsultation),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              spacing: 16,
              children: [
                Card(
                  elevation: 3,
                  shadowColor: ColorManager.mutedSageGreen,
                  color: currentTheme.brightness == Brightness.dark
                      ? ColorManager.oliveGreen
                      : ColorManager.softBeige,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.freeDesignConsultation,
                          style: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(color: currentTheme.brightness ==
                              Brightness.dark
                              ? ColorManager.softBeige
                              : ColorManager.oliveGreen,),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          AppStrings.freeAdviceText,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: currentTheme.brightness ==
                              Brightness.dark
                              ? ColorManager.softBeige
                              : ColorManager.oliveGreen,),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
                CustomTextField(
                  label: AppStrings.fullNameHint,
                  controller: _fullNameController,
                  validator: Validator.userName,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        label: AppStrings.emailHint,
                        controller: _emailController,
                        validator: Validator.email,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: CustomTextField(
                        isPhoneNumber: true,
                        label: AppStrings.phoneNumberHint,
                        controller: _phoneNumberController,
                        validator: Validator.phoneNumber,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomDropdownField(
                        label: AppStrings.apartmentSize,
                        value: _selectedApartmentSize,
                        items: apartmentSizes,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppStrings.pleaseSelectApartmentSize;
                          }
                        },
                        onChanged: (newValue) {
                          setState(() {
                            _selectedApartmentSize = newValue;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: CustomDropdownField(
                        label: AppStrings.budget,
                        value: _selectedBudget,
                        items: budgetOptions,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppStrings.pleaseSelectBudget;
                          }
                        },
                        onChanged: (newValue) {
                          setState(() {
                            _selectedBudget = newValue;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                CustomTextField(
                  label: AppStrings.cityLocation,
                  controller: _cityLocationController,
                  validator: Validator.userName, // use same as full name
                ),
                TextFormField(
                  controller: _additionalNotesController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: AppStrings.additionalNotes,
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
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MyButton(
                      label: AppStrings.sendButton,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (_) => BlocProvider(
                                    create: (_) => TimerCubit(),
                                    child: const TimerPage(),
                                  ),
                            ),
                          );

                          print('Submit form logic here');
                        }
                      },
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
