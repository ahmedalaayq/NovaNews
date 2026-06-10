import 'package:flutter/material.dart';
import 'package:nova_news/core/utils/app_sizes.dart';
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
          padding: EdgeInsets.all(AppSizes.w(16)),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,

            child: Row(
              children: [
                Container(
                  width: AppSizes.w(122),
                  height: AppSizes.h(70),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(AppSizes.r(8)),
                  ),
                ),

                 SizedBox(width: AppSizes.w(10)),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(width: double.infinity, height: AppSizes.h(16), color: Colors.white),

                      SizedBox(height: AppSizes.h(8)),

                      Container(width: AppSizes.w(150), height: AppSizes.h(16), color: Colors.white),

                       SizedBox(height: AppSizes.h(12)),

                      Container(width: AppSizes.w(80), height: AppSizes.h(12), color: Colors.white),
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
