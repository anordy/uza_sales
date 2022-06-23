import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:uza_sales/app/retailer/widget/colors.dart';
import 'package:uza_sales/app/retailer/widget/loading.dart';
import 'package:uza_sales/app/retailer/widget/utils.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:uza_sales/app/sales/model/route_model.dart';
import 'package:uza_sales/app/sales/provider/visibility_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:uza_sales/app/sales/screen/myRoute_screen.dart';
import 'package:uza_sales/app/sales/widget/custom_dialog.dart';

import '../sales_home.dart';

class PosVisibilityPage extends StatefulWidget {
  final SalesStore stores;
  const PosVisibilityPage({Key key, @required this.stores}) : super(key: key);

  @override
  _PosVisibilityPageState createState() => _PosVisibilityPageState();
}

class _PosVisibilityPageState extends State<PosVisibilityPage> {
  String dateTime;
  List<Asset> images = <Asset>[];
  List<String> imagesList = [];
  String _error = 'No Error Dectected';
  String base64Camera;
  String base64Gallery;
  TextEditingController _commentController = TextEditingController();

  File _image;
  final picker = ImagePicker();

  Future getCameraImage() async {
    final pickedFile =
        await picker.getImage(source: ImageSource.camera, imageQuality: 50);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        base64Camera = base64Encode(_image.readAsBytesSync());
        // print(_image);
        print("======= base64Camera  ");
        print(base64Camera);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(
          takePhotoIcon: "chat",
          doneButtonTitle: "Selected",
        ),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      // base64Gallery= base64Encode(images.readAsBytesSync());

      _error = error;
    });
  }

  @override
  void initState() {
    super.initState();
    imageCache.maximumSize = 0;
    imageCache.clear();
  }

  @override
  Widget build(BuildContext context) {
    final _pos = Provider.of<VisibilityProvider>(context);
    return Scaffold(
        backgroundColor: AppColor.bgScreen2,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: AppColor.bgScreen2,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                    ),
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
                                  .pos_visibility
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
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Spacer(),
                        images.length > 0
                            ? Center(
                                child: Text(
                                  "SalesStore POS Placement",
                                  style: TextStyle(
                                      color: Color(0xFF31373B), fontSize: 14),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            : Text(
                                "Take a photo (s) of the SalesStore or \n Supermarket branding",
                                style: TextStyle(
                                    color: Color(0xFF7D7D7D), fontSize: 18),
                                textAlign: TextAlign.center,
                              ),
                        SizedBox(
                          height: 30,
                        ),
                        _image == null
                            ? Container()
                            : Container(
                                height: 80,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white),
                                child: Row(
                                  children: [
                                    Image.file(_image),
                                  ],
                                ),
                              ),
                        images.length > 0
                            ? Container(
                                height: 90,
                                // color: Colors.grey,
                                child: GridView.count(
                                  crossAxisSpacing: 2,
                                  mainAxisSpacing: 2,
                                  crossAxisCount: 3,
                                  children:
                                      List.generate(images.length, (index) {
                                    Asset asset = images[index];
                                    return AssetThumb(
                                      asset: asset,
                                      width: 90,
                                      height: 56,
                                    );
                                  }),
                                ),
                              )
                            : Container(),
                        SizedBox(
                          height: 25,
                        ),
                        images.length > 0
                            ? Text(
                                "Define POS Brand",
                                style: TextStyle(
                                    color: Color(0xFF31373B), fontSize: 14),
                              )
                            : Text(''),
                        SizedBox(
                          height: 40,
                        ),
                        Text("Comment",
                            style: TextStyle(color: Color(0xFF31373B))),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            height: 45,
                            width: Utils.displayWidth(context),
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.3),
                                border: Border.all(color: Color(0xFFC7D3DD)),
                                borderRadius: BorderRadius.circular(50.0)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 3),
                              child: TextFormField(
                                controller: _commentController,
                                decoration: InputDecoration(
                                    hintText: AppLocalizations.of(context)
                                        .enter_comment,
                                    hintStyle: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        color: Color(0xFFAEAEAE)),
                                    border: InputBorder.none),
                              ),
                            )),

                        // SizedBox(
                        //   height: 30.0,
                        // ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                isScrollControlled: true,
                                context: context,
                                builder: (context) => showPicture());
                          },
                          child: DottedBorder(
                            color: Color(0xFFA0A0A0),
                            strokeWidth: 1,
                            borderType: BorderType.RRect,
                            radius: Radius.circular(40),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40)),
                              child: Container(
                                height: 45,
                                width: Utils.displayWidth(context),
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(40.0)),
                                child: Center(
                                    child: images.length <= 0
                                        ? Text(
                                            AppLocalizations.of(context)
                                                .add_photo
                                                .toUpperCase(),
                                            style: TextStyle(
                                                color: Color(0xFF40403F)),
                                          )
                                        : Text(
                                            AppLocalizations.of(context)
                                                .add_more_photo
                                                .toUpperCase(),
                                            style: TextStyle(
                                                color: Color(0xFF40403F)),
                                          )),
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                        Center(
                          child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(60.0)),
                              color: AppColor.preBase,
                              height: 50,
                              minWidth: Utils.displayWidth(context),
                              onPressed: () {
                                imagesList.add(base64Camera);
                                _pos
                                    .savePos(
                                        storeId: this.widget.stores.id,
                                        comment: _commentController.text,
                                        images: imagesList)
                                    .then((value) => {
                                          pushNewScreen(
                                            context,
                                            screen: MyRouteScreen(),
                                            withNavBar:
                                                true, // OPTIONAL VALUE. True by default.
                                            pageTransitionAnimation:
                                                PageTransitionAnimation
                                                    .cupertino,
                                          ),
                                        });

                                // showDialog(
                                //     context: context,
                                //     builder: (BuildContext context) {
                                //       return CustomToast(
                                //           desc:
                                //               "Your Photos has successful been upload continue with product visibility",
                                //           cancel: "MAYBE LATER",
                                //           ok: "Yes",
                                //           cancelChange: () {
                                //             Navigator.pop(context);
                                //           },
                                //           okChange: () {
                                //             pushNewScreen(
                                //               context,
                                //               screen: SalesHome(),
                                //               withNavBar:
                                //                   false, // OPTIONAL VALUE. True by default.
                                //               pageTransitionAnimation:
                                //                   PageTransitionAnimation
                                //                       .cupertino,
                                //             );
                                //           });
                                //     });
                              },
                              child: _pos.isPOS
                                  ? Loading()
                                  : Text(
                                      AppLocalizations.of(context)
                                          .upload_photos
                                          .toUpperCase(),
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
        )));
  }

  Widget makeDismisible({@required Widget child}) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(context).pop(),
        child: GestureDetector(
          onTap: () {},
          child: child,
        ),
      );

// show Picture
  Widget showPicture() {
    return makeDismisible(
      child: DraggableScrollableSheet(
        initialChildSize: 0.2,
        minChildSize: 0.2,
        maxChildSize: 0.2,
        builder: (_, controller) => Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
          child: Padding(
            padding: const EdgeInsets.only(left: 35.0, right: 35.0, top: 20),
            child: ListView(
              controller: controller,
              // crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    getCameraImage();
                    Navigator.of(context).pop();
                  },
                  child: ListTile(
                      leading: Icon(
                        Icons.photo_camera,
                        color: AppColor.preBase,
                      ),
                      title: Text("Take a Picture")),
                ),
                InkWell(
                  onTap: () {
                    loadAssets();
                    Navigator.of(context).pop();
                  },
                  child: ListTile(
                      leading:
                          Icon(Icons.photo_library, color: AppColor.preBase),
                      title: Text("Choose from Galerry")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
