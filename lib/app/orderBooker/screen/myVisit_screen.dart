import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uza_sales/app/retailer/shimmers/route_shimmers.dart';
import 'package:uza_sales/app/retailer/shimmers/shimmer_products.dart';
import 'package:uza_sales/app/retailer/widget/colors.dart';
import 'package:uza_sales/app/sales/card/summary_card.dart';
import 'package:uza_sales/app/sales/provider/visit_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyVisitScreen extends StatefulWidget {
  const MyVisitScreen({Key key}) : super(key: key);

  @override
  _SummaryScreenState createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<MyVisitScreen> {
  DateTime selectedDate = DateTime.now();
  TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _dateController.text = DateFormat.yMMMd().format(DateTime.now());
    Future.delayed(const Duration(seconds: 0), () {
      Provider.of<VisitProvider>(context, listen: false)
          .fetchVisit(_dateController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    final visit = Provider.of<VisitProvider>(context);
    return Scaffold(
        backgroundColor: AppColor.bgScreen2,
        body: SafeArea(
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
                              AppLocalizations.of(context).visit_summary,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: AppColor.title,
                                  fontWeight: FontWeight.w600),
                            ),
                            Spacer(),
                            // SizedBox(
                            //   width: 60,
                            // ),
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
                                    border: Border.all(color: AppColor.border)),
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
                  Container(
                      // height: Utils.displayHeight(context) * 0.74,
                      color: Colors.transparent,
                      child: visit.isVisitLoad
                          ? RouteShimmers()
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount:
                                  visit?.availableVisit?.visit?.length ?? 0,
                              itemBuilder: (context, index) {
                                return SummaryCard(
                                  visit: visit.availableVisit.visit[index],
                                );
                              }))
                ])),
              )
            ],
          ),
        )));
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
