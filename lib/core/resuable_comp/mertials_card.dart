import 'package:flutter/material.dart';
import 'package:noya_app/core/resuable_comp/myBotton.dart';
import 'package:noya_app/core/resuable_comp/toast_message.dart';
import 'package:noya_app/core/utils/colors_manager.dart';
import 'package:noya_app/core/utils/string_manager.dart';

class MaterialCard extends StatelessWidget {
  final String title;
  final String brand;
  final String price;
  final String tagline;
  final String imageUrl;

  const MaterialCard({
    Key? key,
    required this.title,
    required this.brand,
    required this.price,
    required this.tagline,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 4,
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          child: Row(

            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                spacing: 8,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Brand
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    brand,
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  Text(
                    price,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: ColorManager.black,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: ColorManager.white40,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: ColorManager.black),
                    ),
                    child: Text(
                      tagline,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: ColorManager.black,
                      ),
                    ),
                  ),
                  Text(
                    AppStrings.fastDelivery,
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  child: Column(
                    spacing: 20,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          imageUrl,
                          height: 90,
                          width: 90,
                          fit: BoxFit.cover,
                        ),
                      ),
                      MyButton(label:AppStrings.orderNow , onPressed: () {
                        toastMessage(
                          message: AppStrings.orededSuccessfully,
                          tybeMessage: TybeMessage.positive,
                        );
                      },)
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
