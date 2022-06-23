import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uza_sales/app/retailer/model/faq_model.dart';
import 'package:uza_sales/app/retailer/widget/colors.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FaqWidget extends StatefulWidget {
  _FaqWidget createState() => _FaqWidget();
}

class _FaqWidget extends State<FaqWidget> {
  List<FAQ> faqs = [];

  @override
  void initState() {
    super.initState();
    // faqs.addAll(this.getList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: AppColor.base, title: Text('Uza Faq')),
      body: FutureBuilder<List<FAQ>>(
          future: getList(),
          builder: (BuildContext context, AsyncSnapshot<List<FAQ>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: Text('Please wait its loading...'));
            } else {
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                return ListView.builder(
                    itemCount: this.faqs.length,
                    physics: const ScrollPhysics(),
                    padding: EdgeInsets.only(left: 20, right: 20),
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.all(20),
                        child: ExpandablePanel(
                          header: Text(
                            this.faqs[index].question,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          collapsed: Text(
                            this.faqs[index].answer,
                            softWrap: true,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          expanded: Text(
                            this.faqs[index].answer,
                            softWrap: true,
                          ),
                          //  tapHeaderToExpand: true,
                          //  hasIcon: true,
                        ),
                      );
                    });
              }
            }
          }),
    );
  }

  Future<List<FAQ>> getList() async {
    FAQ faq1 = new FAQ(
        AppLocalizations.of(context).qn_1, AppLocalizations.of(context).ans_1);
    FAQ faq2 = new FAQ(
        AppLocalizations.of(context).qn_2, AppLocalizations.of(context).ans_2);
    FAQ faq3 = new FAQ(
        AppLocalizations.of(context).qn_3, AppLocalizations.of(context).ans_3);
    FAQ faq4 = new FAQ(
        AppLocalizations.of(context).qn_4, AppLocalizations.of(context).ans_4);
    FAQ faq5 = new FAQ(
        AppLocalizations.of(context).qn_5, AppLocalizations.of(context).ans_5);
    FAQ faq6 = new FAQ(
        AppLocalizations.of(context).qn_6, AppLocalizations.of(context).ans_6);
    FAQ faq7 = new FAQ(
        AppLocalizations.of(context).qn_7, AppLocalizations.of(context).ans_7);
    FAQ faq8 = new FAQ(
        AppLocalizations.of(context).qn_8, AppLocalizations.of(context).ans_8);

    setState(() {
      this.faqs.add(faq1);
      this.faqs.add(faq2);
      this.faqs.add(faq3);
      this.faqs.add(faq4);
      this.faqs.add(faq5);
      this.faqs.add(faq6);
      this.faqs.add(faq7);
      this.faqs.add(faq8);
    });
    return Future.value(faqs);
  }
}
