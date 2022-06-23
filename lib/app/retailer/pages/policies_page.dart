import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Expansionpanel extends StatefulWidget {
  Expansionpaneltate createState() => Expansionpaneltate();
}

class Expansionpaneltate extends State<Expansionpanel> {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          title: Text(AppLocalizations.of(context).policies),
        ),
        body: ListView(
          shrinkWrap: true,
          primary: false,
          children: [
            listItem(
                title: AppLocalizations.of(context).faq,
                icon: Icons.dashboard_rounded,
                body: faqBody()),
            listItem(
                title: AppLocalizations.of(context).privacy_policy,
                icon: Icons.help_rounded,
                body: poliicyBody()),
            listItem(
                title: AppLocalizations.of(context).terms_condition,
                icon: Icons.settings,
                body: termsBody()),
          ],
        ));
  }

  Widget listItem({int index, String title, IconData icon, Widget body}) {
    final GlobalKey expansionTileKey = GlobalKey();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, border: Border.all(color: Colors.grey[50])),
        child: Theme(
          data: ThemeData(accentColor: Colors.black),
          child: ExpansionTile(
            key: expansionTileKey,
            onExpansionChanged: (value) {
              if (value) {
                _scrollToSelectedContent(expansionTileKey: expansionTileKey);
              }
            },
            leading: Icon(
              icon,
              size: 40,
            ),
            title: Text(
              title,
              style: TextStyle(fontSize: 17),
            ),
            children: [body],
          ),
        ),
      ),
    );
  }

  Widget faqBody() {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, bottom: 8),
      child: Container(
          width: MediaQuery.of(context).size.width * 0.91,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text("List of Faq")),
    );
  }

  Widget poliicyBody() {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, bottom: 8),
      child: Container(
          width: MediaQuery.of(context).size.width * 0.91,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text("List of Policies")),
    );
  }

  Widget termsBody() {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, bottom: 8),
      child: Container(
          width: MediaQuery.of(context).size.width * 0.91,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text("Some terms and condition")),
    );
  }

  void _scrollToSelectedContent({GlobalKey expansionTileKey}) {
    final keyContext = expansionTileKey.currentContext;
    if (keyContext != null) {
      Future.delayed(Duration(milliseconds: 200)).then((value) {
        Scrollable.ensureVisible(keyContext,
            duration: Duration(milliseconds: 200));
      });
    }
  }
}
