import 'package:flutter/material.dart';

import '../models/product_model.dart';

class ProductDataSource extends DataTableSource {
  final List<Product> products;

  ProductDataSource(this.products);

  @override
  DataRow? getRow(int index) {
    if (index >= products.length) return null;
    final product = products[index];

    return DataRow(cells: [
      DataCell(Text(product.id.toString()),showEditIcon: true,placeholder: true),
      DataCell(Text(product.name)),
      DataCell(Text(product.price)),
      DataCell(Text(product.stock.toString())),
      DataCell(Text(product.category)),
      DataCell(
        Image.network(
          product.firstImageUrl,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
      ),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => products.length;

  @override
  int get selectedRowCount => 0;
}
