import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget shimmerLoadingWidget() {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      children: [
        // Row of button + column of 2 shimmer boxes
        Row(
          children: [
            Column(
              children:[
                shimmerBox(height: 100, width: 150),
                shimmerBox(height: 100, width: 150),
              ]
            ),
            const Spacer(),
            shimmerBox(height: 100, width: 150), // as a button
          ],
        ),
        const SizedBox(height: 24),

        // Horizontal shimmer list
        SizedBox(
          height: 100,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (_, __) => shimmerBox(height: 100, width: 100),
          ),
        ),
        const SizedBox(height: 24),

        // Grid shimmer view
        Expanded(
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 6,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1,
            ),
            itemBuilder: (_, __) => shimmerBox(height: double.infinity, width: double.infinity),
          ),
        ),
      ],
    ),
  );
}

Widget shimmerBox({required double height, required double width}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16.0),
    child: Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
  );
}
