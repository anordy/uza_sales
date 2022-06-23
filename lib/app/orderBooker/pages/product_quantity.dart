import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:uza_sales/app/retailer/widget/colors.dart';
import 'package:uza_sales/app/retailer/widget/utils.dart';
import 'package:uza_sales/app/sales/card/product_quantity_card.dart';
import 'package:uza_sales/app/sales/pages/sales_home.dart';
import 'package:uza_sales/app/sales/provider/stock_availability_provider.dart';
import 'package:uza_sales/app/sales/widget/custom_dialog.dart';

class ProductQuantity extends StatelessWidget {
  const ProductQuantity({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<StockAvailabilityProvider>(context);
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
                                "Fill the Quantity".toUpperCase(),
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
                          Text("Stock Availability",
                              style: TextStyle(
                                  color: AppColor.text, fontSize: 12)),
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            color: Colors.white,
                            height: Utils.displayHeight(context) * 0.43,
                            child: ListView.builder(
                                itemCount:
                                    productProvider.availableProducts.length,
                                shrinkWrap: true,
                                // physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return ProductQuantityCard(
                                    product: productProvider
                                        .availableProducts[index],
                                  );
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
                                  productProvider.saveStock(
                                      productId: productProvider
                                          .availableProducts[0].id,
                                      categoryId: productProvider
                                          .availableCategory[
                                              productProvider.selectedCategory]
                                          .id,
                                      unit: "Pc",
                                      quantity: "3",
                                      storeId: "",
                                      salesPersonId: "");
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return CustomToast(
                                            desc:
                                                "Data was saved successfully to the dashboard",
                                            cancel: "Okay",
                                            ok: "Back Home",
                                            cancelChange: () {
                                              Navigator.pop(context);
                                            },
                                            okChange: () {
                                              pushNewScreen(
                                                context,
                                                screen: SalesHome(),
                                                withNavBar:
                                                    false, // OPTIONAL VALUE. True by default.
                                                pageTransitionAnimation:
                                                    PageTransitionAnimation
                                                        .cupertino,
                                              );
                                            });
                                      });
                                  // Navigator.of(context).pop();
                                },
                                child: Text(
                                  "Save Data",
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
