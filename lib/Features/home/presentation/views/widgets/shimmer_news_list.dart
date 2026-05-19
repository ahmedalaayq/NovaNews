import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerNewsList extends StatelessWidget {
  const ShimmerNewsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: .zero,
      itemCount: 6,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, index) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,

            child: Row(
              children: [
                Container(
                  width: 122,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(width: double.infinity, height: 16, color: Colors.white),

                      const SizedBox(height: 8),

                      Container(width: 150, height: 16, color: Colors.white),

                      const SizedBox(height: 12),

                      Container(width: 80, height: 12, color: Colors.white),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
