import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:noya_app/core/resuable_comp/myBotton.dart';
import 'package:noya_app/core/resuable_comp/toast_message.dart';
import 'package:noya_app/core/utils/string_manager.dart';
import 'package:noya_app/data/models/WorkerModel.dart';
import 'package:shimmer/shimmer.dart';

class WorkerCard extends StatelessWidget {
  final WorkerModel workerModel;

  const WorkerCard({Key? key, required this.workerModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 4,
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row (Image + Name & Profession)
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey[200],
                  child: CachedNetworkImage(
                    imageUrl: workerModel.imageUrl ?? "",
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
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
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        workerModel.name ?? "",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        workerModel.specialization ?? "",
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Location
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(Icons.location_on, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  workerModel.location ?? "",
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Phone and Email
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(Icons.phone, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  workerModel.phone ?? "",
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                const SizedBox(width: 16),
                const Icon(Icons.email, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Expanded(
                  child: FittedBox(
                    child: Text(
                      workerModel.email ?? "",
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Experience
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(Icons.work, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  '${workerModel.experienceYears ?? 0} years of experience',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),

            const SizedBox(height: 16),
            const Divider(height: 1, color: Colors.grey),
            const SizedBox(height: 16),

            // Hire button
            SizedBox(
              width: double.infinity,

              child: MyButton(
                label: AppStrings.hireButtonText,
                onPressed: () {
                  toastMessage(
                    message:
                        "${AppStrings.toastMessageTemplate} ${workerModel.name}",
                    tybeMessage: TybeMessage.positive,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
