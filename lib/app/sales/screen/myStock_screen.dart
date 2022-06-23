import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:uza_sales/app/retailer/widget/colors.dart';
import 'package:uza_sales/app/retailer/widget/loading.dart';
import 'package:uza_sales/app/retailer/widget/toast_widget.dart';
import 'package:uza_sales/app/retailer/widget/utils.dart';
import 'package:uza_sales/app/sales/items/myStock_items.dart';
import 'package:uza_sales/app/sales/provider/stock_availability_provider.dart';

class MyStock extends StatefulWidget {
  const MyStock({Key key}) : super(key: key);

  @override
  _MyStockState createState() => _MyStockState();
}

class _MyStockState extends State<MyStock> {
  DateTime selectedDate = DateTime.now();
  TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _dateController.text = DateFormat.yMMMd().format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    final stockProvider = Provider.of<StockAvailabilityProvider>(context);
    return Scaffold(
        backgroundColor: AppColor.bgScreen2,
        body: SafeArea(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverStickyHeader(
                    header: Container(
                        color: AppColor.bgScreen2,
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
                                  AppLocalizations.of(context).my_stock,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: AppColor.title,
                                      fontWeight: FontWeight.w600),
                                ),
                                // SizedBox(
                                //   width: 100,
                                // ),
                                Spacer(),
                                InkWell(
                                  onTap: () {
                                    _selectDate(context);
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 120,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5),
                                        border:
                                            Border.all(color: AppColor.border)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(
                                            Icons.calendar_today,
                                            size: 14,
                                            color: AppColor.preBase,
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Text(
                                            "${_dateController.text}",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: AppColor.preBase,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        )),
                    sliver: SliverList(
                        delegate: SliverChildListDelegate([
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 30.0, right: 30.0, top: 20, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  AppLocalizations.of(context).product,
                                  style: TextStyle(
                                      color: AppColor.text,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  AppLocalizations.of(context).unit,
                                  style: TextStyle(
                                      color: AppColor.text,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  AppLocalizations.of(context).qty,
                                  style: TextStyle(
                                      color: AppColor.text,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),

                          Container(
                              height: Utils.displayHeight(context) * 0.6,
                              color: Colors.transparent,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  // physics: NeverScrollableScrollPhysics(),
                                  itemCount: stockProvider
                                          ?.myStocks?.stocksContent?.length ??
                                      0,
                                  itemBuilder: (context, index) {
                                    return MyStockItems(
                                      stocksContent: stockProvider
                                          .myStocks.stocksContent[index],
                                    );
                                  })),
                          SizedBox(
                            height: 30,
                          ),
                          MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(60.0)),
                              color: AppColor.preBase,
                              height: 50,
                              minWidth: Utils.displayWidth(context) * 0.6,
                              onPressed: () {
                                stockProvider.warehouseReturn();
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
                                      description:
                                          "Stocks Returned as success"),
                                  duration: Duration(seconds: 3),
                                  position: ToastPosition.bottom,
                                );
                              },
                              child: stockProvider.isWarehouse
                                  ? Loading()
                                  : Text(
                                      AppLocalizations.of(context)
                                          .return_warehouse,
                                      style: TextStyle(color: Colors.white),
                                    )),

                          // Spacer(),
                          // SizedBox(height: 20,),
                        ],
                      )
                    ])),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: AppColor.preBase,
                onPrimary: Colors.white,
                surface: AppColor.preBase,
                onSurface: AppColor.text,
              ),
              dialogBackgroundColor: Colors.white,
            ),
            child: child,
          );
        },
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat.yMMMd().format(selectedDate);
      });
  }
}
