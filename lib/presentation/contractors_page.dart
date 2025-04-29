import 'package:animation_list/animation_list.dart';
import 'package:flutter/material.dart';
import 'package:noya_app/core/resuable_comp/worker_card.dart';

import '../core/utils/string_manager.dart';

class ContractorsPage extends StatefulWidget {
  const ContractorsPage({super.key});

  @override
  State<ContractorsPage> createState() => _ContractorsPageState();
}

class _ContractorsPageState extends State<ContractorsPage> {
  final TextEditingController _searchController = TextEditingController();
  bool _showClearButton = false;

  // List of all freelancer cards
  final List<FreelancerCard> allFreelancerCards = [
    const FreelancerCard(
      name: 'أحمد النجار',
      profession: 'نجار',
      location: 'القاهرة',
      rate: 'EGP 250/ساعة',
      date: '1 مايو 2025',
      duration: '5 أيام',
      imageUrl:
          'https://watanimg.elwatannews.com/image_archive/original_lower_quality/4459643931590105651.jpg',
    ),
    const FreelancerCard(
      name: 'محمود الكهربائي',
      profession: 'كهربائي',
      location: 'الإسكندرية',
      rate: 'EGP 300/ساعة',
      date: '10 يونيو 2025',
      duration: '3 أيام',
      imageUrl:
          'https://watanimg.elwatannews.com/image_archive/original_lower_quality/4459643931590105651.jpg',
    ),
    const FreelancerCard(
      name: 'سعيد السباك',
      profession: 'سباك',
      location: 'الجيزة',
      rate: 'EGP 280/ساعة',
      date: '20 يوليو 2025',
      duration: '4 أيام',
      imageUrl:
          'https://watanimg.elwatannews.com/image_archive/original_lower_quality/4459643931590105651.jpg',
    ),
    const FreelancerCard(
      name: 'فاطمة الدهانة',
      profession: 'دهانة',
      location: 'دمياط',
      rate: 'EGP 270/ساعة',
      date: '15 أغسطس 2025',
      duration: '6 أيام',
      imageUrl:
          'https://watanimg.elwatannews.com/image_archive/original_lower_quality/4459643931590105651.jpg',
    ),
  ];

  // List to store filtered freelancers based on search
  List<FreelancerCard> filteredFreelancerCards = [];

  @override
  void initState() {
    super.initState();
    // Initially show all freelancers
    filteredFreelancerCards = List.from(allFreelancerCards);
    _searchController.addListener(() {
      setState(() {
        _showClearButton = _searchController.text.isNotEmpty;
        // Filter freelancers based on the search query
        filteredFreelancerCards =
            allFreelancerCards.where((freelancer) {
              return freelancer.name.toLowerCase().contains(
                    _searchController.text.toLowerCase(),
                  ) ||
                  freelancer.profession.toLowerCase().contains(
                    _searchController.text.toLowerCase(),
                  ) ||
                  freelancer.location.toLowerCase().contains(
                    _searchController.text.toLowerCase(),
                  );
            }).toList();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: Colors.white,
        title: Text(AppStrings.contractorsLabel),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextFormField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: AppStrings.searchHintText,
                hintStyle: TextStyle(color: Colors.grey[600]),
                prefixIcon: const Icon(Icons.search, color: Colors.black87),
                suffixIcon:
                    _showClearButton
                        ? IconButton(
                          icon: const Icon(Icons.clear, color: Colors.black87),
                          onPressed: () {
                            _searchController.clear();
                          },
                        )
                        : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  // Less rounded for rectangle look
                  borderSide: const BorderSide(
                    color: Colors.black87,
                    width: 1, // Thicker border
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(color: Colors.black87, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 2.0, // Even thicker when focused
                  ),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 20.0,
                ),
              ),
              style: const TextStyle(color: Colors.black87), // Text color
              onChanged: (value) {
                // Trigger search logic when the input changes
                setState(() {
                  filteredFreelancerCards =
                      allFreelancerCards.where((freelancer) {
                        return freelancer.name.toLowerCase().contains(
                              value.toLowerCase(),
                            ) ||
                            freelancer.profession.toLowerCase().contains(
                              value.toLowerCase(),
                            ) ||
                            freelancer.location.toLowerCase().contains(
                              value.toLowerCase(),
                            );
                      }).toList();
                });
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: AnimationList(
                duration: 2000,
                reBounceDepth: 10.0,
                children: List.generate(
                  filteredFreelancerCards.length,
                  (index) => filteredFreelancerCards[index],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
