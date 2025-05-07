import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:noya_app/core/resuable_comp/myBotton.dart';
import 'package:noya_app/core/resuable_comp/toast_message.dart';
import 'package:noya_app/core/utils/colors_manager.dart';
import 'package:noya_app/core/utils/string_manager.dart';
import 'package:noya_app/data/models/material_model.dart';
import 'package:shimmer/shimmer.dart';

class MaterialCard extends StatelessWidget {
  final MaterialModel material;

  const MaterialCard({Key? key, required this.material}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorManager.softBeige,
      elevation: 4,
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SingleChildScrollView(
                child: Column(
                  spacing: 8,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and Brand
                    FittedBox(
                      fit: BoxFit.scaleDown, // Adjusts text size to fit
                      child: Text(
                        material.name ?? "",
                        style: const TextStyle(
                          color: ColorManager.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      width: 150,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          material.description ?? "",
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600],
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "${AppStrings.price} ${material.unitPrice.toString()}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: ColorManager.black,
                        ),
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown, // Adjusts text size to fit
                      child: Text(
                        AppStrings.fastDelivery,
                        style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Container(
                  child: Column(
                    spacing: 20,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            imageUrl: material.imageUrl ?? "",
                            width: double.infinity,
                            fit: BoxFit.cover,
                            height: 100,
                            placeholder:
                                (context, url) => Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(color: Colors.white),
                                ),
                            errorWidget:
                                (context, url, error) => const Center(
                                  child: Icon(Icons.error, color: Colors.red),
                                ),
                          ),
                        ),
                      ),
                      MyButton(
                        label: AppStrings.orderNow,
                        onPressed: () {
                          toastMessage(
                            message: AppStrings.orededSuccessfully,
                            tybeMessage: TybeMessage.positive,
                          );
                        },
                      ),
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
