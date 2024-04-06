import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/auth/custom_auth/auth_util.dart';

bool isIteminCart(
  List<dynamic>? cartproducts,
  int itemId,
) {
  // find item based on itemid cartproducts json and return item
  if (cartproducts == null) {
    return false;
  } else {
    for (var product in cartproducts) {
      if (product['id'] == itemId) {
        return true;
      }
    }
    return false;
  }
}

dynamic paymentMethods(dynamic paymentMethodsList) {
  // return only list where enabled is true
  if (paymentMethodsList == null) {
    return [];
  } else {
    List<dynamic> enabledPaymentMethods = [];
    for (var paymentMethod in paymentMethodsList) {
      if (paymentMethod['enabled'] == true) {
        enabledPaymentMethods.add(paymentMethod);
      }
    }
    return enabledPaymentMethods;
  }
}

dynamic findItemInCart(
  List<dynamic>? cartproducts,
  int itemId,
) {
  // find item based on itemid cartproducts json and return item
  for (var product in cartproducts!) {
    if (product['id'] == itemId) {
      return product;
    }
  }
  return null;
}

int? getItemQuantity(
  List<dynamic>? cartproducts,
  int itemId,
) {
  // find item based on itemid cartproducts json and return item
  for (var product in cartproducts!) {
    if (product['id'] == itemId) {
      if (product['quantity'] != "") {
        return product['quantity']['value'];
      }
    }
  }
  return 1;
}

String? getItemKey(
  List<dynamic>? cartproducts,
  int itemId,
) {
  // find item based on itemid cartproducts json and return item
  for (var product in cartproducts!) {
    if (product['id'] == itemId) {
      return product['item_key'];
    }
  }
  return null;
}

int totalCartItems(List<dynamic>? itemsList) {
  // find total items length from json which can be null as well
  if (itemsList == null) {
    return 0;
  } else {
    int totalItems = 0;

    totalItems = itemsList.length;

    return totalItems;
  }
}

double getProductPrice(String? price) {
  // divide price by 100 and return double
  if (price != null) {
    return int.parse(price) / 100;
  } else {
    return 0.0;
  }
}

dynamic lineItems(dynamic products) {
  // return list of products with only id and quantity

  if (products is List) {
    // Scenario 1: List of objects
    return products
        .map((item) => {
              'product_id': item['id'],
              'quantity': item['quantity']['value'],
            })
        .toList();
  } else if (products is Map) {
    // Scenario 2: Single object
    return [
      {
        'product_id': products['id'],
        'quantity': products['quantity']['value'],
      }
    ];
  } else {
    throw Exception('Invalid data format. Please provide a list or a map.');
  }
}

bool isSimpleorVariableProduct(String producttype) {
  // if product type is variable return true else false
  if (producttype == 'variable') {
    return true;
  } else {
    return false;
  }
}
