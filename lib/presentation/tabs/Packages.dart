import 'package:flutter/material.dart';
import 'package:noya_app/core/resuable_comp/package_card.dart';
import 'package:noya_app/core/utils/string_manager.dart';

class Packages extends StatelessWidget {
  const Packages({super.key});

  // Sample list of products
  final List<Map<String, dynamic>> products = const [
    {
      'title': 'Essential Home',
      'subtitle': 'Everything you need to get started',
      'price': '\$12,500',
      'installmentOption': 'or \$750/mo for 24 mo',
      'description': 'Quality essentials at an affordable price.',
      'includes': [
        '3 Seater Sofa',
        'Smart TV (42")',
        'Queen Size Bed',
        'Queen Size',
      ],
      'imagePath': 'assets/images/2.jpg',
    },
    {
      'title': 'Luxury Package',
      'subtitle': 'Premium items for your dream home',
      'price': '\$24,999',
      'installmentOption': 'or \$1,200/mo for 24 mo',
      'description': 'High-end furniture and appliances.',
      'includes': [
        'Leather Sectional Sofa',
        'Smart TV (65")',
        'King Size Bed',
        '+5 more',
      ],
      'imagePath': 'assets/images/1.jpg',
    },
    {
      'title': 'Starter Pack',
      'subtitle': 'Basic essentials for your first home',
      'price': '\$8,999',
      'installmentOption': 'or \$450/mo for 24 mo',
      'description': 'Affordable starter set for new homeowners.',
      'includes': [
        '2 Seater Sofa',
        'Smart TV (32")',
        'Full Size Bed',
        '+1 more',
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