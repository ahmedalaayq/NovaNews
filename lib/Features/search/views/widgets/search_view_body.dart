import 'package:flutter/material.dart' hide SearchController;
import 'package:nova_news/core/theme/light_app_colors.dart';
import 'package:nova_news/core/utils/app_sizes.dart';
import 'package:provider/provider.dart';
import '../../controller/search_controller.dart';

class SearchViewBody extends StatelessWidget {
  const SearchViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.w(16)),
      child: Column(
        children: [
          AppBar(
            scrolledUnderElevation: 0.0,
            elevation: 0.0,
            title: Text('Search'),
            centerTitle: true,
            titleTextStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: .bold),
          ),
          SizedBox(height: AppSizes.h(20)),
          Selector<SearchController, String>(
            selector: (_, controller) => controller.searchController.text,
            builder: (context, text, child) {
              return SearchBar(
                controller: context.read<SearchController>().searchController,
                onSubmitted: (_) {
                  context.read<SearchController>().searchNews();
                },
                hintText: 'Search',

                hintStyle: WidgetStateProperty.all(
                  Theme.of(context).textTheme.bodyMedium?.copyWith(color: const Color(0xFFA0A0A0)),
                ),

                padding: WidgetStateProperty.all(
                  EdgeInsets.symmetric(horizontal: AppSizes.w(16), vertical: AppSizes.h(4)),
                ),

                trailing: [
                  text.trim().isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            context.read<SearchController>().clearFields();
                          },
                          icon: const Icon(Icons.clear,color: LightAppColors.primaryColor,),
                        )
                      : const Icon(Icons.search, color: Color(0xFFA0A0A0)),
                ],

                shadowColor: WidgetStateProperty.all(Colors.grey.shade300),

                backgroundColor: WidgetStateProperty.all(Colors.grey.shade100),

                onTapOutside: (_) {
                  FocusScope.of(context).unfocus();
                },
              );
            },
          ),
          SizedBox(height: AppSizes.h(20)),

          Consumer<SearchController>(
            builder: (BuildContext context, controller, Widget? child) {
              return controller.searchController.text.trim().isEmpty
                  ? SizedBox.shrink()
                  : Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        padding: .zero,
                        itemBuilder: (ctx, index) {
                          final model = controller.everythingNews[index];
                          return ListTile(
                            contentPadding: .zero,
                            leading: Icon(Icons.search, color: Color(0xFF6D6D6D)),
                            title: Text(
                              model.title ?? "",
                              maxLines: 1,
                              style: Theme.of(
                                context,
                              ).textTheme.bodyLarge?.copyWith(color: Color(0xFF6D6D6D)),
                            ),
                          );
                        },
                        separatorBuilder: (ctx, index) {
                          return Divider(color: Color(0xFFD1DAD6), thickness: 1);
                        },
                        itemCount: controller.everythingNews.length,
                      ),
                    );
            },
          ),
        ],
      ),
    );
  }
}
