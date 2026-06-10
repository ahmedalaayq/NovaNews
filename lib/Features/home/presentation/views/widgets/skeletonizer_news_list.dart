import 'package:flutter/material.dart';
import 'package:nova_news/core/utils/app_sizes.dart';

class SkeletonizerNewsList extends StatelessWidget {
  const SkeletonizerNewsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding:  EdgeInsets.symmetric(horizontal: AppSizes.w(16)),
      scrollDirection: Axis.horizontal,
      itemCount: 6,
      separatorBuilder: (_, _) =>  SizedBox(width: AppSizes.w(12)),

      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(AppSizes.r(8)),

          child: Stack(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(color: Color(0xFFE0E0E0)),
                child: SizedBox(width: AppSizes.w(300), height: AppSizes.h(180)),
              ),


              Positioned(
                left: AppSizes.w(12),
                right: AppSizes.w(12),
                bottom: AppSizes.h(12),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  mainAxisSize: MainAxisSize.min,

                  children: [
                    Container(
                      height: AppSizes.h(14),
                      width: AppSizes.w(180),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(AppSizes.r(4)),
                      ),
                    ),

                    SizedBox(height: AppSizes.h(10)),

                    Row(
                      children: [
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: SizedBox(width: AppSizes.w(30), height: AppSizes.h(30)),
                        ),

                         SizedBox(width: AppSizes.w(8)),

                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(AppSizes.r(4)),
                          ),
                          child: SizedBox(height: AppSizes.h(10), width: AppSizes.w(80)),
                        ),

                        const Spacer(),

                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(AppSizes.r(4)),
                          ),
                          child: SizedBox(height: AppSizes.h(10), width: AppSizes.w(60)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
