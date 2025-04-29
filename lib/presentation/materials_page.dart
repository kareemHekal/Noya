import 'package:animation_list/animation_list.dart';
import 'package:flutter/material.dart';
import 'package:noya_app/core/resuable_comp/mertials_card.dart';
import 'package:noya_app/core/utils/string_manager.dart';

class MaterialsPage extends StatefulWidget {
  const MaterialsPage({Key? key}) : super(key: key);

  @override
  _MaterialsPageState createState() => _MaterialsPageState();
}

class _MaterialsPageState extends State<MaterialsPage> {
  final TextEditingController _searchController = TextEditingController();
  bool _showClearButton = false;

  // List of all material cards
  final List<MaterialCard> allMaterials = [
    const MaterialCard(
      title: 'خشب زان',
      brand: 'خشب',
      price: 'EGP 5000/متر',
      tagline: 'Available',
      imageUrl:
          'https://static.wixstatic.com/media/38d960_b400897ac4944effb53816ae219533fd~mv2.jpg/v1/fill/w_540,h_426,al_c,q_80,usm_0.66_1.00_0.01,enc_avif,quality_auto/38d960_b400897ac4944effb53816ae219533fd~mv2.jpg',
    ),
    const MaterialCard(
      title: 'أسلاك كهرباء',
      brand: 'كهرباء',
      price: 'EGP 200/لفة',
      tagline: 'Available',
      imageUrl:
          'https://static.wixstatic.com/media/38d960_b400897ac4944effb53816ae219533fd~mv2.jpg/v1/fill/w_540,h_426,al_c,q_80,usm_0.66_1.00_0.01,enc_avif,quality_auto/38d960_b400897ac4944effb53816ae219533fd~mv2.jpg',
    ),
    const MaterialCard(
      title: 'أنابيب مياه',
      brand: 'سباكة',
      price: 'EGP 150/متر',
      tagline: 'Out of Stock',
      imageUrl:
          'https://static.wixstatic.com/media/38d960_b400897ac4944effb53816ae219533fd~mv2.jpg/v1/fill/w_540,h_426,al_c,q_80,usm_0.66_1.00_0.01,enc_avif,quality_auto/38d960_b400897ac4944effb53816ae219533fd~mv2.jpg',
    ),
    const MaterialCard(
      title: 'دهانات جدران',
      brand: 'دهانات',
      price: 'EGP 300/علبة',
      tagline: 'Available',
      imageUrl:
          'https://static.wixstatic.com/media/38d960_b400897ac4944effb53816ae219533fd~mv2.jpg/v1/fill/w_540,h_426,al_c,q_80,usm_0.66_1.00_0.01,enc_avif,quality_auto/38d960_b400897ac4944effb53816ae219533fd~mv2.jpg',
    ),
  ];

  // List to store filtered materials based on search
  List<MaterialCard> filteredMaterials = [];

  @override
  void initState() {
    super.initState();
    filteredMaterials = List.from(allMaterials);
    _searchController.addListener(() {
      setState(() {
        _showClearButton = _searchController.text.isNotEmpty;
        filteredMaterials =
            allMaterials.where((material) {
              return material.title.toLowerCase().contains(
                    _searchController.text.toLowerCase(),
                  ) ||
                  material.brand.toLowerCase().contains(
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
        title:  Text(AppStrings.materialsLabel),
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
              style: const TextStyle(color: Colors.black87),
              onChanged: (value) {
                setState(() {
                  filteredMaterials =
                      allMaterials.where((material) {
                        return material.title.toLowerCase().contains(
                              value.toLowerCase(),
                            ) ||
                            material.brand.toLowerCase().contains(
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
                  filteredMaterials.length,
                      (index) => filteredMaterials[index],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
