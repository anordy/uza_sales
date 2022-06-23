import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:uza_sales/app/retailer/widget/colors.dart';
import 'package:uza_sales/app/retailer/widget/toast_widget.dart';
import 'package:uza_sales/app/retailer/widget/utils.dart';
import 'package:uza_sales/app/sales/card/stock_product_card.dart';
import 'package:uza_sales/app/sales/pages/product_quantity.dart';
import 'package:uza_sales/app/sales/provider/stock_availability_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StockAvailability extends StatelessWidget {
  const StockAvailability({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final category = Provider.of<StockAvailabilityProvider>(context);
    return Scaffold(
        backgroundColor: AppColor.bgScreen2,
        body: SafeArea(
          child: Container(
            child: Column(
              children: [
                Container(
                  color: AppColor.bgScreen2,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              IconButton(
                                  icon: Icon(Icons.arrow_back_ios),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  }),
                              // SizedBox(width: 2,),
                              Text(
                                AppLocalizations.of(context)
                                    .check_availability
                                    .toUpperCase(),
                                style: TextStyle(
                                    fontSize: 16,
                                    color: AppColor.title,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        ],
                      )),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Container(
                    height: Utils.displayHeight(context) * 0.7,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28),
                        color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppLocalizations.of(context).stock_availability,
                              style: TextStyle(
                                  color: AppColor.text, fontSize: 12)),
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            color: Colors.white,
                            height: Utils.displayHeight(context) * 0.43,
                            child: ListView.builder(
                                itemCount: category.availableCategory.length,
                                shrinkWrap: true,
                                // physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return InkWell(
                                      onTap: () {
                                        category.onClickCategory(
                                            category
                                                .availableCategory[
                                                    category.selectedCategory]
                                                .id,
                                            index);
                                        pushNewScreen(
                                          context,
                                          screen: ProductQuantity(),
                                          withNavBar:
                                              true, // OPTIONAL VALUE. True by default.
                                          pageTransitionAnimation:
                                              PageTransitionAnimation.cupertino,
                                        );
                                      },
                                      child: ProductStockCard(
                                        category:
                                            category.availableCategory[index],
                                      ));
                                }),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Row(
                              children: [
                                // Icon(
                                //   Icons.add,
                                //   color: AppColor.preBase,
                                //   size: 18,
                                // ),
                                // SizedBox(
                                //   width: 5,
                                // ),
                                // Text(
                                //   "Add Custom Group",
                                //   style: TextStyle(
                                //       color: AppColor.preBase,
                                //       fontSize: 12,
                                //       fontWeight: FontWeight.bold),
                                // )
                              ],
                            ),
                          ),
                          Spacer(),
                          Center(
                            child: MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(60.0)),
                                color: AppColor.preBase,
                                height: 50,
                                minWidth: Utils.displayWidth(context) * 0.6,
                                onPressed: () {
                                  showToastWidget(
                                    ToastWidget(
                                        icon: Icon(
                                          Icons.done,
                                          color: Colors.white,
                                          size: 15,
                                        ),
                                        height: 50,
                                        width: 250,
                                        color: AppColor.success,
                                        description: "Success"),
                                    duration: Duration(seconds: 2),
                                    position: ToastPosition.bottom,
                                  );
                                  // Navigator.of(context).pop();
                                },
                                child: Text(
                                  "Submit",
                                  style: TextStyle(color: Colors.white),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
