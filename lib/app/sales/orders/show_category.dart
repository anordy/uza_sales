import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uza_sales/app/retailer/card/category_items.dart';
import 'package:uza_sales/app/retailer/card/subCategory_items.dart';
import 'package:uza_sales/app/retailer/provider/category_provider.dart';
import 'package:uza_sales/app/retailer/shimmers/sub_cat_shimmers.dart';
import 'package:uza_sales/app/retailer/widget/colors.dart';
import 'package:uza_sales/app/retailer/widget/loading.dart';
import 'package:uza_sales/app/retailer/widget/utils.dart';
import 'package:uza_sales/app/sales/orders/sale_category_items.dart';
import 'package:uza_sales/app/sales/orders/sale_subCategories_items.dart';

class ShowCategoryHeader extends StatelessWidget {
  final Color backgroundColor;
  final String headerTitle;
  final Widget filter;

  ShowCategoryHeader(this.backgroundColor, this.headerTitle, this.filter);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      floating: false,
      delegate: Delegate(backgroundColor, headerTitle, filter),
    );
  }
}

class Delegate extends SliverPersistentHeaderDelegate {
  final Color backgroundColor;
  final String headerTitle;
  final Widget filter;

  Delegate(this.backgroundColor, this.headerTitle, this.filter);

  int _selectedSubCategory = 0;
  var rot = 45;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final category = Provider.of<CategoryProvider>(context);
    return Container(
      decoration: BoxDecoration(
        color: AppColor.bgScreen2,
      ),
      // margin: EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          Expanded(
            child: Container(
              color: Color(0xFFFFFCFC),
              child: category.availableCategory.length <= 0 ||
                      category.availableCategory.length == null
                  ? Text(
                      "No Categories",
                      style: TextStyle(fontSize: 13, color: Color(0xff1F212C)),
                      textAlign: TextAlign.center,
                    )
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: category.availableCategory.length,
                      itemBuilder: (context, c) {
                        return InkWell(
                          child: category.isCatLoad
                              ? SubCatShimmer()
                              : SaleCategoryItems(
                                  category: category.availableCategory[c],
                                  index: c,
                                ),
                          onTap: () {
                            print("** click category ***");
                            print(c);
                            category.onClickCategory(
                                category
                                    .availableCategory[
                                        category.selectedCategory]
                                    .id,
                                c);
                            // _productProvider.onClickCategory(
                            //     storeId: this.widget.storeId, index: index)
                          },
                        );
                      },
                    ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: AppColor.bgScreen2,
                  border: Border(bottom: BorderSide(color: Colors.white))),
              child: category.isSubCatLoad
                  ? SubCatShimmer()
                  : category.availableCategory[category.selectedCategory]
                                  .subCategories.length <=
                              0 ||
                          category.availableCategory[category.selectedCategory]
                                  .subCategories ==
                              null
                      ? Text(
                          "No Subcategories",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff1F212C),
                              fontSize: 11),
                          textAlign: TextAlign.center,
                        )
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: category
                              .availableCategory[category.selectedCategory]
                              .subCategories
                              .length,
                          itemBuilder: (context, s) {
                            return InkWell(
                              child: SaleSubCategoryItems(
                                subCategory: category
                                    .availableCategory[
                                        category.selectedCategory]
                                    .subCategories[s],
                                index: s,
                              ),
                              onTap: () {
                                _selectedSubCategory = s;
                                print("** click subCategory ***");
                                print(_selectedSubCategory);
                                category.onClicksubCategory(
                                    category
                                        .availableCategory[
                                            category.selectedCategory]
                                        .id,
                                    category
                                        .availableCategory[
                                            category.selectedCategory]
                                        .subCategories[s]
                                        .id,
                                    s);
                              },
                            );
                          },
                        ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                    color: Color(0xFFFFFFF),
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: AppColor.border)),
                width: Utils.displayWidth(context),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.search,
                                color: Color(0xFF000000),
                              ),
                              hintText: "search",
                              border: InputBorder.none,
                            ),
                            onChanged: (text) {
                              category.fetchProducts("", "", text, "");
                            },
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                isScrollControlled: true,
                                context: context,
                                builder: (context) => this.filter);
                          },
                          child: Container(
                            height: 44,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(50),
                                    bottomRight: Radius.circular(50)),
                                border: Border.all(color: AppColor.border)),
                            width: Utils.displayWidth(context) * 0.2,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(Icons.filter_alt_outlined,
                                      color: AppColor.text),
                                  Text(
                                    "Filter",
                                    style: TextStyle(
                                        color: AppColor.text, fontSize: 12),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 160;

  @override
  double get minExtent => 160;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
