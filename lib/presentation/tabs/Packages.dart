import 'package:flutter/material.dart';
import 'package:noya_app/core/resuable_comp/package_card.dart';
import 'package:noya_app/core/utils/string_manager.dart';

class Packages extends StatelessWidget {
  const Packages({super.key});

  // Sample list of products
  final List<Map<String, dynamic>> products = const [
    {
      'title': 'المنزل الأساسي',
      'subtitle': 'كل ما تحتاجه للبدء',
      'price': '١٢,٥٠٠ ج.م',
      'installmentOption': 'أو ٧٥٠ ج.م / شهريًا لمدة ٢٤ شهر',
      'description': 'أساسيات عالية الجودة بسعر مناسب.',
      'includes': [
        'كنبة ٣ مقاعد',
        'تلفزيون ذكي (٤٢")',
        'سرير حجم كوين',
        'مرتبة حجم كوين',
      ],
      'imagePath': 'assets/images/2.jpg',
    },
    {
      'title': 'الباقة الفاخرة',
      'subtitle': 'عناصر فاخرة لمنزل أحلامك',
      'price': '٢٤,٩٩٩ ج.م',
      'installmentOption': 'أو ١٢٠٠ ج.م / شهريًا لمدة ٢٤ شهر',
      'description': 'أثاث وأجهزة منزلية فاخرة.',
      'includes': [
        'كنبة ركن جلد',
        'تلفزيون ذكي (٦٥")',
        'سرير حجم كينج',
        '+٥ عناصر إضافية',
      ],
      'imagePath': 'assets/images/1.jpg',
    },
    {
      'title': 'باقة البداية',
      'subtitle': 'الأساسيات لمنزلك الأول',
      'price': '٨,٩٩٩ ج.م',
      'installmentOption': 'أو ٤٥٠ ج.م / شهريًا لمدة ٢٤ شهر',
      'description': 'مجموعة بداية ميسورة التكلفة لأصحاب المنازل الجدد.',
      'includes': [
        'كنبة ٢ مقاعد',
        'تلفزيون ذكي (٣٢")',
        'سرير حجم كامل',
        '+١ عنصر إضافي',
      ],
      'imagePath': 'assets/images/3.jpg',
    },
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(AppStrings.homePackages),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: ProductCard(
                title: product['title'],
                subtitle: product['subtitle'],
                price: product['price'],
                installmentOption: product['installmentOption'],
                description: product['description'],
                includes: List<String>.from(product['includes']),
                imagePath: product['imagePath'],
              ),
            );
          },
        ),
      ),
    );
  }
}