import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String name;
  final int quantity;
  final double price;
  final String type;

  CartItem( 
      {@required this.id,
      @required this.name,
      @required this.quantity,
      @required this.price,
      @required this.type});
}