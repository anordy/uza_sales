import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:uza_sales/app/retailer/widget/colors.dart';
import 'package:uza_sales/app/sales/items/target_items.dart';
import 'package:uza_sales/app/sales/provider/target_provider.dart';
import 'package:uza_sales/app/sales/widget/custom_slider_thumb_circle.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BookerTargetScreen extends StatefulWidget {
  final double sliderHeight;
  final int min;
  final int max;
  final fullWidth;

  BookerTargetScreen(
      {this.sliderHeight = 40,
      this.max = 100,
      this.min = 0,
      this.fullWidth = false});
  @override
  _BookerTargetScreenState createState() => _BookerTargetScreenState();
}

class _BookerTargetScreenState extends State<BookerTargetScreen> {
  //     var numberFormat = NumberFormat('#,##,000.00');

  TextEditingController _month = TextEditingController();
  var formatter = NumberFormat('#,###,000');

  double getTotalPercent(int sale, int target) {
    return (sale / target);
  }

  double _value = 0;
  @override
  void initState() {
    super.initState();
    _month.text = Jiffy(DateTime.now()).MMMM;
    print("=========   this month ${_month.text}  ");
  }

  @override
  Widget build(BuildContext context) {
    final target = Provider.of<TargetProvider>(context);
    return Scaffold(
        backgroundColor: AppColor.bgScreen2,
        body: SafeArea(
          child: Container(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: Column(
                children: [
                  Container(
                      color: AppColor.bgScreen2,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              // IconButton(
                              //     icon: Icon(Icons.arrow_back_ios),
                              //     onPressed: () {
                              //       Navigator.of(context).pop();
                              //     }),
                              // SizedBox(width: 2,),

                              Text(
                                AppLocalizations.of(context).my_target,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: AppColor.title,
                                    fontWeight: FontWeight.w600),
                              ),
                              // SizedBox(
                              //   width: 80,
                              // ),
                              Spacer(),
                              Container(
                                height: 40,
                                width: 120,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: AppColor.border)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    // mainAxisAlignment:
                                    // MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(
                                        Icons.calendar_today,
                                        size: 14,
                                        color: AppColor.preBase,
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Text(
                                        "${_month.text}",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: AppColor.preBase,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            
                            
                            
                            ],
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 20.0,
                  ),
                  target.isTarget
                      ? Text("0")
                      : Text(
                          "Tsh ${formatter.format(target?.availableTarget?.revenue?.target ?? 0)}",
                          style: TextStyle(
                              fontSize: 20,
                              color: AppColor.title,
                              fontWeight: FontWeight.bold),
                        ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Expanded(
                    child: Center(
                      child: SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: AppColor.preBase,
                          inactiveTrackColor: Colors.white,
                          thumbColor: Colors.white,
                          trackHeight: 10.0,
                          thumbShape: CustomSliderThumbCircle(
                            thumbRadius: this.widget.sliderHeight * .4,
                            min: this.widget.min,
                            max: this.widget.max,
                          ),
                          overlayColor: Colors.transparent,
                          //valueIndicatorColor: Colors.white,
                          activeTickMarkColor: AppColor.preBase,
                          inactiveTickMarkColor: Colors.white,
                        ),
                        child: Slider(
                            value: getTotalPercent(30, 20000),
                            onChanged: (value) {
                              setState(() {
                                _value = value;
                              });
                            }),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  target.isTarget
                      ? Text("Tsh 0")
                      : Text(
                          "Tsh ${formatter.format(target.availableTarget.revenue.sales ?? 0)} / Tsh ${formatter.format(target.availableTarget.revenue.target ?? 0)}",
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColor.title,
                          ),
                        ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 0.0, horizontal: 0),
                    child: Container(
                      // color: Colors.green,
                      height: 450,
                      child: GridView.count(
                          crossAxisCount: 2,
                          primary: true,
                          shrinkWrap: true,
                          crossAxisSpacing: 2,
                          mainAxisSpacing: 2,
                          childAspectRatio: (16 / 14),
                          physics: ScrollPhysics(),
                          children: List.generate(
                              target?.availableTarget?.products?.length ?? 0,
                              (index) {
                            return InkWell(
                                child: TargetItems(
                              product: target.availableTarget.products[index],
                            ));
                          })),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
