import 'dart:convert';
import 'dart:io';
import 'package:jiffy/jiffy.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oktoast/oktoast.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:uza_sales/app/retailer/widget/colors.dart';
import 'package:uza_sales/app/retailer/widget/toast_widget.dart';
import 'package:uza_sales/app/retailer/widget/utils.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:uza_sales/app/sales/model/route_model.dart';
import 'package:uza_sales/app/sales/provider/visit_provider.dart';
import 'package:uza_sales/app/sales/screen/myRoute_screen.dart';
import 'package:uza_sales/app/sales/widget/custom_dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CheckInPage extends StatefulWidget {
  final MyRoute routes;
  final SalesStore stores;
  const CheckInPage({Key key, @required this.routes, @required this.stores})
      : super(key: key);

  @override
  _CheckInPageState createState() => _CheckInPageState();
}

class _CheckInPageState extends State<CheckInPage> {
  String dateTime;
  List<Asset> images = <Asset>[];
  String _error = 'No Error Dectected';
  String imageBase64;
  DateTime selectedDate = DateTime.now();
  TabController _tabController;
  int _selectedIndex = 0;
  TextEditingController _dateController = TextEditingController();
  TextEditingController _nextController = TextEditingController();

  String _shopStatus = "Closed";
  // List<String> statusLists = ['closed', 'moved', 'n o Orders'];

  File _image;
  final picker = ImagePicker();

  Future getCameraImage() async {
    final pickedFile =
        await picker.getImage(source: ImageSource.camera, imageQuality: 50);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        imageBase64 = base64Encode(_image.readAsBytesSync());
        print(_image);
        print(imageBase64);
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
      _error = error;
    });
  }

  @override
  void initState() {
    super.initState();

    _dateController.text = Jiffy(DateTime.now()).format('yyyy-MM-dd hh:mm');
    print(_dateController.text);
    _nextController.text = Jiffy(DateTime.now()).format('yyyy-MM-dd');
    imageCache.maximumSize = 0;
    imageCache.clear();
  }

  @override
  Widget build(BuildContext context) {
    final _checkProvider = Provider.of<VisitProvider>(context);
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
                              "Check In",
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
                      children: [
                        Text(AppLocalizations.of(context).shop_status),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                isScrollControlled: true,
                                context: context,
                                builder: (context) => shopStatus());
                          },
                          child: Container(
                            height: 45,
                            width: Utils.displayWidth(context),
                            decoration: BoxDecoration(
                                border: Border.all(color: Color(0xFFC7D3DD)),
                                borderRadius: BorderRadius.circular(50.0)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("$_shopStatus"),
                                  Icon(
                                    FontAwesomeIcons.chevronDown,
                                    size: 15,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(AppLocalizations.of(context).next_visit),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            _selectDate(context);
                          },
                          child: Container(
                            height: 45,
                            width: Utils.displayWidth(context),
                            decoration: BoxDecoration(
                                border: Border.all(color: Color(0xFFC7D3DD)),
                                borderRadius: BorderRadius.circular(50.0)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.calendar_today,
                                        color: AppColor.preBase,
                                      )),
                                  Text(
                                    "${_nextController.text}",
                                    style: TextStyle(color: Colors.black),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
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
                                    child: Text(
                                  AppLocalizations.of(context)
                                      .add_photo
                                      .toUpperCase(),
                                  style: TextStyle(color: Color(0xFFB7B7B7)),
                                )),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        _image == null
                            ? Container()
                            : Container(
                                height: 100,
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
                                height: 120,
                                // color: Colors.grey,
                                child: GridView.count(
                                  crossAxisCount: 3,
                                  children:
                                      List.generate(images.length, (index) {
                                    Asset asset = images[index];
                                    return AssetThumb(
                                      asset: asset,
                                      width: 300,
                                      height: 100,
                                    );
                                  }),
                                ),
                              )
                            : Container(),
                        Spacer(),
                        Center(
                          child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(60.0)),
                              color: AppColor.preBase,
                              height: 50,
                              minWidth: Utils.displayWidth(context) * 0.6,
                              onPressed: () {
                                _checkProvider
                                    .checkIn(
                                        routeId: this.widget.routes.id,
                                        storeId: this.widget.stores.id,
                                        checkInTime: _dateController.text,
                                        isOrderPending: true,
                                        shopStatus: _shopStatus,
                                        nextApp: _nextController.text,
                                        image: imageBase64)
                                    .then((value) => {
                                          if (!value)
                                            {
                                              // showDialog(
                                              //     context: context,
                                              //     builder:
                                              //         (BuildContext context) {
                                              //       return CustomToast(
                                              //           desc:
                                              //               "Check in was success",
                                              //           cancel: "Okay",
                                              //           ok: "Back Home",
                                              //           cancelChange: () {
                                              //             Navigator.pop(
                                              //                 context);
                                              //           },
                                              //           okChange: () {
                                              //             Navigator.pop(
                                              //                 context);

                                              //             pushNewScreen(
                                              //               context,
                                              //               screen:
                                              //                   MyRouteScreen(),
                                              //               withNavBar:
                                              //                   true, // OPTIONAL VALUE. True by default.
                                              //               pageTransitionAnimation:
                                              //                   PageTransitionAnimation
                                              //                       .cupertino,
                                              //             );
                                              //           });
                                              //     })

                                              pushNewScreen(
                                                context,
                                                screen: MyRouteScreen(),
                                                withNavBar:
                                                    true, // OPTIONAL VALUE. True by default.
                                                pageTransitionAnimation:
                                                    PageTransitionAnimation
                                                        .cupertino,
                                              ),
                                              showToastWidget(
                                                ToastWidget(
                                                    icon: Icon(
                                                      Icons.close,
                                                      color: Colors.white,
                                                      size: 15,
                                                    ),
                                                    height: 50,
                                                    width: 250,
                                                    color: Colors.white,
                                                    description:
                                                        "Check in as success"),
                                                duration: Duration(seconds: 3),
                                                position: ToastPosition.bottom,
                                              ),
                                            }
                                          else
                                            {
                                              showToastWidget(
                                                ToastWidget(
                                                    icon: Icon(
                                                      Icons.close,
                                                      color: Colors.white,
                                                      size: 15,
                                                    ),
                                                    height: 50,
                                                    width: 250,
                                                    color: Colors.white,
                                                    description:
                                                        "Visit Arleady Stored"),
                                                duration: Duration(seconds: 3),
                                                position: ToastPosition.bottom,
                                              ),
                                              pushNewScreen(
                                                context,
                                                screen: MyRouteScreen(),
                                                withNavBar:
                                                    true, // OPTIONAL VALUE. True by default.
                                                pageTransitionAnimation:
                                                    PageTransitionAnimation
                                                        .cupertino,
                                              )
                                            }
                                        });

                                //  Navigator.of(context).pop();
                              },
                              child: Text(
                                AppLocalizations.of(context).confirm_check_in,
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

  // filter bottom sheet
  Widget shopStatus() {
    return makeDismisible(
      child: DraggableScrollableSheet(
        initialChildSize: 0.4,
        minChildSize: 0.4,
        maxChildSize: 0.4,
        builder: (_, controller) => Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
          child: Padding(
            padding: const EdgeInsets.only(left: 35.0, right: 35.0, top: 50),
            child: ListView(
              controller: controller,
              // crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    print("closed");
                    setState(() {
                      _shopStatus = "Closed";
                    });
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    height: Utils.displayHeight(context) * 0.05,
                    width: Utils.displayWidth(context) * 0.5,
                    // color: Colors.blue,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        "Closed",
                        style: TextStyle(color: Color(0xFF31373B)),
                      ),
                    ),
                  ),
                ),
                // SizedBox(
                //   height: 5,
                // ),
                Divider(),
                // SizedBox(
                //   height: 5,
                // ),
                InkWell(
                  onTap: () {
                    print("Opened");
                    setState(() {
                      _shopStatus = "Opened";
                    });
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    // color: Colors.blue,
                    height: Utils.displayHeight(context) * 0.05,
                    width: Utils.displayWidth(context) * 0.5,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        "Opened",
                        style: TextStyle(color: Color(0xFF31373B)),
                      ),
                    ),
                  ),
                ),
                // SizedBox(
                //   height: 15,
                // ),
                Divider(),
                // SizedBox(
                //   height: 15,
                // ),
                InkWell(
                  onTap: () {
                    print("moved");
                    setState(() {
                      _shopStatus = "Moved";
                    });
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    // color: Colors.blue,
                    height: Utils.displayHeight(context) * 0.05,
                    width: Utils.displayWidth(context) * 0.5,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        "Moved",
                        style: TextStyle(color: Color(0xFF31373B)),
                      ),
                    ),
                  ),
                ),
                // SizedBox(
                //   height: 15,
                // ),
                Divider(),
                // SizedBox(
                //   height: 15,
                // ),
                InkWell(
                  onTap: () {
                    print("Busy");
                    setState(() {
                      _shopStatus = "Busy";
                    });
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    // color: Colors.blue,
                    height: Utils.displayHeight(context) * 0.05,
                    width: Utils.displayWidth(context) * 0.5,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        "Busy",
                        style: TextStyle(color: Color(0xFF31373B)),
                      ),
                    ),
                  ),
                ),
                // SizedBox(
                //   height: 15,
                // ),
                Divider(),
                // SizedBox(height: 15),
                // Center(
                //   child: MaterialButton(
                //       shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(60.0)),
                //       color: AppColor.preBase,
                //       height: 50,
                //       minWidth: Utils.displayWidth(context) * 0.4,
                //       onPressed: () {},
                //       child: Text(
                //         "Select".toUpperCase(),
                //         style: TextStyle(color: Colors.white),
                //       )),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // select date
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
        // _dateController.text = DateFormat.yMMMd().format(selectedDate);
        _nextController.text = Jiffy(selectedDate).format('yyyy-MM-dd');
      });
  }

// show Picture
  Widget showPicture() {
    return makeDismisible(
      child: DraggableScrollableSheet(
        initialChildSize: 0.1,
        minChildSize: 0.1,
        maxChildSize: 0.1,
        builder: (_, controller) => Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
          child: Padding(
            padding: const EdgeInsets.only(
                left: 35.0, right: 35.0, top: 20, bottom: 10),
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
                // InkWell(
                //   onTap: () {
                //     loadAssets();
                //     Navigator.of(context).pop();
                //   },
                //   child: ListTile(
                //       leading:
                //           Icon(Icons.photo_library, color: AppColor.preBase),
                //       title: Text("Choose from Galerry")),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
