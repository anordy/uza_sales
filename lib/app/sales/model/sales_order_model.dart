// To parse this JSON data, do
//
//     final salesOrder = salesOrderFromJson(jsonString);

import 'dart:convert';

SalesOrder salesOrderFromJson(String str) => SalesOrder.fromJson(json.decode(str));

String salesOrderToJson(SalesOrder data) => json.encode(data.toJson());

class SalesOrder {
    SalesOrder({
        this.totalSales,
        this.locationVisited,
        this.orders,
        this.totalOrders,
        
    });

    double totalSales;
    int locationVisited;
    List<Order> orders;
    int totalOrders;

    factory SalesOrder.fromJson(Map<String, dynamic> json) => SalesOrder(
        totalSales: json["totalSales"],
        locationVisited: json["locationVisited"],
        orders: List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
        totalOrders: json["totalOrders"],
    );

    Map<String, dynamic> toJson() => {
        "totalSales": totalSales,
        "locationVisited": locationVisited,
        "orders": List<dynamic>.from(orders.map((x) => x.toJson())),
        "totalOrders": totalOrders,
    };
}

class Order {
    Order({
        this.orderPaymentStatus,
        this.checkIn,
        this.orderId,
        this.supplier,
        this.orderStatus,
        this.checkOut,
        this.orderDate,
        this.storeName,
        this.items,
        this.orderTotal,
    });

    String orderPaymentStatus;
    DateTime checkIn;
    String orderId;
    String supplier;
    String storeName;
    String orderStatus;
    dynamic checkOut;
    DateTime orderDate;
    List<SaleItem> items;
    double orderTotal;

    factory Order.fromJson(Map<String, dynamic> json) => Order(
        orderPaymentStatus: json["orderPaymentStatus"],
        checkIn: json["checkIn"] == null ? null : DateTime.parse(json["checkIn"]),
        orderId: json["orderId"],
        supplier: json["supplier"],
        orderStatus: json["orderStatus"],
        checkOut: json["checkOut"],
        storeName: json['storeName'] == null ? "": json['storeName'] as String,
        orderDate: DateTime.parse(json["orderDate"]),
        items: List<SaleItem>.from(json["items"].map((x) => SaleItem.fromJson(x))),
        orderTotal: json["orderTotal"],
    );

    Map<String, dynamic> toJson() => {
        "orderPaymentStatus": orderPaymentStatus,
        "checkIn": checkIn == null ? null : checkIn.toIso8601String(),
        "orderId": orderId,
        "supplier": supplier,
        "orderStatus": orderStatus,
        "checkOut": checkOut,
        "storeName": storeName,
        "orderDate": "${orderDate.year.toString().padLeft(4, '0')}-${orderDate.month.toString().padLeft(2, '0')}-${orderDate.day.toString().padLeft(2, '0')}",
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "orderTotal": orderTotal,
    };
}

class SaleItem {
    SaleItem({
        this.productId,
        this.productName,
        this.count,
        this.type,
        this.unitPrice,
        this.unit,
        this.discountAmount,
        this.totalPrice,
        this.supplierId,
    });

    String productId;
    String productName;
    int count;
    dynamic type;
    String unit;
    double unitPrice;
    double discountAmount;
    double totalPrice;
    String supplierId;

    factory SaleItem.fromJson(Map<String, dynamic> json) => SaleItem(
        productId: json["productId"],
        productName: json["productName"],
        count: json["count"],
        type: json["type"],
        unit: json['unit'],
        unitPrice: json["unitPrice"],
        discountAmount: json["discountAmount"],
        totalPrice: json["totalPrice"],
        supplierId: json["supplierId"],
    );

    Map<String, dynamic> toJson() => {
        "productId": productId,
        "productName": productName,
        "count": count,
        "type": type,
        "unit": unit,
        "unitPrice": unitPrice,
        "discountAmount": discountAmount,
        "totalPrice": totalPrice,
        "supplierId": supplierId,
    };
}
