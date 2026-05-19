import 'package:flutter/material.dart';
import 'package:nova_news/Features/home/presentation/views/widgets/custom_news_error_state_item.dart';
import 'package:nova_news/Features/home/presentation/views/widgets/custom_news_item.dart';
import 'package:nova_news/core/enums/request_status_enum.dart';
import 'package:nova_news/core/extension/shared_extension.dart';
import 'package:nova_news/core/theme/light_app_colors.dart';
import 'package:provider/provider.dart';

import '../../controller/home_controller.dart';
import 'widgets/shimmer_news_list.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
        titleTextStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: .bold),
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),

      body: Consumer<HomeController>(
        builder: (context, controller, child) {
          return CustomScrollView(
            physics: const BouncingScrollPhysics(),

            slivers: [
              const SliverToBoxAdapter(child: SizedBox(height: 12)),

              SliverToBoxAdapter(
                child: SizedBox(
                  height: 32,

                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 12),

                    itemCount: HomeController.categories.length,

                    separatorBuilder: (_, __) => const SizedBox(width: 12),

                    itemBuilder: (context, index) {
                      final category = HomeController.categories[index];

                      final isSelected = category == controller.selectedCategory;

                      return GestureDetector(
                        onTap: () {
                          controller.onSelectedCategory(category);
                        },

                        child: Column(
                          children: [
                            Text(
                              category.capitalizeEachWord(),

                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,

                                color: isSelected
                                    ? LightAppColors.primaryColor
                                    : LightAppColors.secondaryColor,
                              ),
                            ),

                            const SizedBox(height: 5),

                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),

                              width: 50,
                              height: 2,

                              color: isSelected ? LightAppColors.primaryColor : Colors.transparent,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 20)),

              if (controller.topHeadlinesStatus == RequestStatusEnum.loading)
                const SliverToBoxAdapter(child: ShimmerNewsList()),

              if (controller.topHeadlinesStatus == RequestStatusEnum.error ||
                  controller.topHeadlineNewsList.isEmpty)
                const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(child: CustomNewsErrorStateItem()),
                ),

              if (controller.topHeadlinesStatus == RequestStatusEnum.loaded)
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return CustomNewsItem(model: controller.topHeadlineNewsList[index]);
                  }, childCount: controller.topHeadlineNewsList.length),
                ),
            ],
          );
        },
      ),
    );
  }
}
