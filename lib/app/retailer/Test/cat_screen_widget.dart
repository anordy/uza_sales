import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';


class CategoryScreenWidget extends StatelessWidget {

    const CategoryScreenWidget({ Key key }) : super(key: key);
  @override
  Widget build(BuildContext context) => SliverPadding(
        padding: EdgeInsets.all(10),
        sliver:
         MultiSliver(
          pushPinnedChildren: true,
          children: [
            SliverStack(
              insetOnOverlap: true,
              children: [
                // SliverPositioned.fill(
                //   top: CardHeaderWidget.padding,
                //   child: CardBackgroundWidget(),
                // ),
                buildCard(context),
              ],
            ),
          ],
        ),
      );

  Widget buildCard(BuildContext context) => MultiSliver(
        children: <Widget>[
          SliverPinnedHeader(child: 
          Text("Header 01")
          ),
          SliverClip(
            child: MultiSliver(
              children: <Widget>[
                buildNews(),
              ],
            ),
          ),
        ],
      );

  Widget buildNews() => SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => Text("news"),
          childCount: 2,
        ),
      );

 

}
