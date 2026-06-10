import 'package:flutter/material.dart';
import 'package:nova_news/Features/home/controller/home_controller.dart';
import 'package:nova_news/Features/home/presentation/views/widgets/custom_news_error_state_item.dart';
import 'package:nova_news/Features/home/presentation/views/widgets/custom_news_item.dart';
import 'package:nova_news/Features/home/presentation/views/widgets/shimmer_news_list.dart';
import 'package:nova_news/Features/home/presentation/views/widgets/trending_news.dart';
import 'package:nova_news/Features/home/presentation/views/widgets/view_all_componenet.dart';
import 'package:nova_news/core/enums/request_status_enum.dart';
import 'package:nova_news/core/extension/shared_extension.dart';
import 'package:nova_news/core/theme/light_app_colors.dart';
import 'package:nova_news/core/utils/app_sizes.dart';
import 'package:provider/provider.dart';
import '../category_view.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (context, controller, child) {
        return RefreshIndicator(
          color: LightAppColors.primaryColor,
          onRefresh: () async {
            await controller.getTopHeadlines();
            await controller.getEverything();
          },
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const TrendingNews(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ViewAllComponenet(
                        title: 'Categories',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChangeNotifierProvider.value(
                                value: controller,
                                child: const CategoryView(),
                              ),
                            ),
                          );
                        },
                        color: const Color(0xFF141414),
                      ),
                    ),
                    SizedBox(height: AppSizes.h(12)),
                    Selector<HomeController, String>(
                      selector: (_, ctrl) => ctrl.selectedCategory,
                      builder: (context, selectedCategory, child) {
                        return SizedBox(
                          height: AppSizes.h(32),
                          child: ListView.separated(
                            padding: EdgeInsets.symmetric(horizontal: AppSizes.w(12)),
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemCount: HomeController.categories.length,
                            separatorBuilder: (_, _) => SizedBox(width: AppSizes.w(12)),
                            itemBuilder: (context, index) {
                              final category = HomeController.categories[index];
                              final isSelected = category == selectedCategory;
                              return GestureDetector(
                                onTap: () => controller.onSelectedCategory(category),
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
                                    SizedBox(height: AppSizes.h(5)),
                                    AnimatedContainer(
                                      duration: const Duration(milliseconds: 300),
                                      height: AppSizes.h(2),
                                      width: AppSizes.w(50),
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? LightAppColors.primaryColor
                                            : Colors.transparent,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Consumer<HomeController>(
                builder: (context, value, _) {
                  switch (value.topHeadlinesStatus) {
                    case RequestStatusEnum.loading:
                      return const SliverToBoxAdapter(child: ShimmerNewsList());
                    case RequestStatusEnum.error:
                      return const SliverFillRemaining(child: CustomNewsErrorStateItem());
                    case RequestStatusEnum.loaded:
                      if (value.topHeadlineNewsList.isEmpty) {
                        return const SliverFillRemaining(
                          hasScrollBody: false,
                          child: CustomNewsErrorStateItem(),
                        );
                      }
                      return SliverList.builder(
                        itemCount: value.topHeadlineNewsList.length,
                        itemBuilder: (context, index) {
                          final model = value.topHeadlineNewsList[index];
                          return CustomNewsItem(model: model, index: index);
                        },
                      );
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
