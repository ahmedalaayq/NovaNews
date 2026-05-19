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
import 'package:provider/provider.dart';
import '../category_view.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (context, controller, child) {
        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  TrendingNews(),

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
                              child: CategoryView(),
                            ),
                          ),
                        );
                      },
                      color: const Color(0xFF141414),
                    ),
                  ),

                  const SizedBox(height: 12),

                  Selector<HomeController, String>(
                    selector: (_, c) => c.selectedCategory,

                    builder: (context, selectedCategory, child) {
                      return SizedBox(
                        height: 32,
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),

                          itemCount: HomeController.categories.length,

                          separatorBuilder: (_, __) => const SizedBox(width: 12),

                          itemBuilder: (context, index) {
                            final category = HomeController.categories[index];

                            final isSelected = category == selectedCategory;

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
                                    height: 2,
                                    width: 50,

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

            if (controller.topHeadlinesStatus == RequestStatusEnum.loading)
              SliverToBoxAdapter(child: ShimmerNewsList()),

            if (controller.topHeadlinesStatus == RequestStatusEnum.error ||
                controller.topHeadlineNewsList.isEmpty)
              SliverFillRemaining(hasScrollBody: false, child: CustomNewsErrorStateItem()),

            if (controller.topHeadlinesStatus == RequestStatusEnum.loaded)
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: controller.topHeadlineNewsList.length,

                  (context, index) {
                    final model = controller.topHeadlineNewsList[index];
                    return CustomNewsItem(model: model);
                  },
                ),
              ),
          ],
        );
      },
    );
  }
}
