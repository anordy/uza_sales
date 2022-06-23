import 'package:flutter/material.dart';
import 'package:uza_sales/app/retailer/widget/colors.dart';
import 'package:uza_sales/app/retailer/widget/utils.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:uza_sales/app/sales/model/target_model.dart';

class TargetItems extends StatefulWidget {
  final Product product;
  const TargetItems({Key key, @required this.product}) : super(key: key);

  @override
  _TargetItemsState createState() => _TargetItemsState();
}

class _TargetItemsState extends State<TargetItems> {
  double getProductPercent(int sale, int target) {
    return (sale ?? 0 / target) * 100;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, top: 8.0, right: 5.0),
      child: Container(
        height: 150,
        width: Utils.displayWidth(context) * 0.3,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                      height: 55.0,
                      width: 55.0,
                      child: SleekCircularSlider(
                        min: 0,
                        max: 100,
                        initialValue: getProductPercent(
                            this.widget.product.sales,
                            this.widget.product.target),
                        appearance: CircularSliderAppearance(
                            //  size: 360,
                            //  startAngle: 360,
                            angleRange: 360,
                            infoProperties: InfoProperties(
                                mainLabelStyle: TextStyle(
                                    color: Color(0xFF292C34), fontSize: 12)),
                            customWidths: CustomSliderWidths(
                              progressBarWidth: 5,
                              trackWidth: 4,
                            ),
                            customColors: CustomSliderColors(
                              progressBarColor: AppColor.preBase,
                              trackColor: Color(0xFfE2E2E2),
                              hideShadow: true,
                              dynamicGradient: true,
                              dotColor: AppColor.preBase,
                            )),
                        onChange: (double value) {
                          print(value);
                        },

                        onChangeStart: (double startValue) {
                          // callback providing a starting value (when a pan gesture starts)
                        },
                        onChangeEnd: (double endValue) {
                          // ucallback providing an ending value (when a pan gesture ends)
                        },
                        // innerWidget: (double value) {
                        //   // use your custom widget inside the slider (gets a slider value from the callback)
                        // },
                      ))
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                this.widget.product.productName,
                style: TextStyle(
                    color: AppColor.title,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                "${this.widget.product.sales} ${this.widget.product.unit} / ${this.widget.product.target} ${this.widget.product.unit}",
                style: TextStyle(color: Color(0xFF292C34), fontSize: 10),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
