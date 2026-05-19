import 'package:flutter/material.dart';

class SkeletonizerNewsList extends StatelessWidget {
  const SkeletonizerNewsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      scrollDirection: Axis.horizontal,
      itemCount: 6,
      separatorBuilder: (_, _) => const SizedBox(width: 12),

      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),

          child: Stack(
            children: [
              const DecoratedBox(
                decoration: BoxDecoration(color: Color(0xFFE0E0E0)),
                child: SizedBox(width: 300, height: 180),
              ),


              Positioned(
                left: 12,
                right: 12,
                bottom: 12,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  mainAxisSize: MainAxisSize.min,

                  children: [
                    Container(
                      height: 14,
                      width: 180,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Row(
                      children: [
                        const DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: SizedBox(width: 30, height: 30),
                        ),

                        const SizedBox(width: 8),

                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: SizedBox(height: 10, width: 80),
                        ),

                        const Spacer(),

                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: SizedBox(height: 10, width: 60),
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
