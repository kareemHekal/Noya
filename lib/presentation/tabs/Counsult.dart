import 'package:flutter/material.dart';
import 'package:noya_app/core/resuable_comp/counslatunt_text_filds.dart';
import 'package:noya_app/core/resuable_comp/drop_down.dart';
import 'package:noya_app/core/resuable_comp/myBotton.dart';
import 'package:noya_app/core/utils/colors_manager.dart';
import 'package:noya_app/core/utils/string_manager.dart';
import 'package:noya_app/core/utils/text_style_manager.dart';

class Counsult extends StatefulWidget {
  const Counsult({super.key});

  @override
  State<Counsult> createState() => _CounsultState();
}

class _CounsultState extends State<Counsult> {
  // Create controllers for all text fields
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _cityLocationController = TextEditingController();
  final TextEditingController _additionalNotesController =
      TextEditingController();

  @override
  void dispose() {
    // Always dispose controllers to avoid memory leaks
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _cityLocationController.dispose();
    _additionalNotesController.dispose();
    super.dispose();
  }

  String? _selectedApartmentSize;
  String? _selectedBudget;

  final List<String> apartmentSizes = [
    'Studio',
    '1 Bedroom',
    '2 Bedroom',
    '3 Bedroom',
    '4+ Bedroom',
  ];

  final List<String> budgetOptions = [
    'Under 15,000',
    '15,000 - 30,000',
    '30,000 - 50,000',
    '50,000+',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: Colors.white,
        title: Text(AppStrings.interiorConsultation),
      ),
      body: SingleChildScrollView(
        // Important to avoid overflow if the keyboard appears
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            spacing: 16,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: ColorManager.white50,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.freeDesignConsultation,
                        style: AppTextStyle.medium20,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        AppStrings.freeAdviceText,
                        style: AppTextStyle.regular12,
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
              CustomTextField(
                label: AppStrings.fullNameHint,
                controller: _fullNameController,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      label: AppStrings.emailHint,
                      controller: _emailController,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomTextField(
                      label: AppStrings.phoneNumberHint,
                      controller: _phoneNumberController,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomDropdownField(
                      label: 'Apartment Size',
                      value: _selectedApartmentSize,
                      items: apartmentSizes,
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
                      label: 'Budget',
                      value: _selectedBudget,
                      items: budgetOptions,
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
                      color: Colors.black87,
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(
                      color: Colors.black87,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 20.0,
                  ),
                ),
                style: const TextStyle(color: Colors.black87),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MyButton(
                    label: AppStrings.sendButton,
                    onPressed: () {},
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
