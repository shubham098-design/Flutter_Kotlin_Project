import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:r_goldsmith_shop_flutter/admine/utils/custom_drawer.dart';

import '../../../../user/services/supabase_services.dart';
import '../../../controller/product_controller.dart';
import '../../../models/product_model.dart';
import '../../../utils/product_data_source.dart';

class MobAllProductScreen extends StatefulWidget {
  const MobAllProductScreen({super.key});

  @override
  State<MobAllProductScreen> createState() => _MobAllProductScreenState();
}

class _MobAllProductScreenState extends State<MobAllProductScreen> {

  final ProductController productController = Get.put(ProductController()); // Controller Initialize

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(title: Text("Product Table")),
      body: Obx(() {
        if (productController.getProductsLoading.value) {
          return Center(child: CircularProgressIndicator()); // Loading Indicator
        }

        if (productController.products.isEmpty) {
          return Center(child: Text("No Products Found"));
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                width: constraints.maxWidth,
                padding: EdgeInsets.all(10),
                child: PaginatedDataTable2(
                  minWidth: 600, // Table ki minimum width
                  columnSpacing: 15, // Column ke beech ka gap
                  horizontalMargin: 10, // Table ke left-right margin
                  headingRowHeight: 50, // Header height
                  dataRowHeight: 60, // Row height
                  dividerThickness: 1,
                  showCheckboxColumn: true,
                  headingTextStyle: Theme
                      .of(context)
                      .textTheme
                      .titleMedium,
                  headingRowColor: WidgetStateProperty.resolveWith((
                      state) => Colors.blueAccent),
                  headingRowDecoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  rowsPerPage: constraints.maxWidth < 600 ? 3 : 5, // Mobile: 3 rows, Desktop: 5 rows
                  showFirstLastButtons: true,
                  onPageChanged: (value) {},
                  renderEmptyRowsInTheEnd: false,
                  sortArrowIcon: Icons.line_axis,
                  columns: const [
                    DataColumn(label: Text('ID')),
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('Price')),
                    DataColumn(label: Text('Stock')),
                    DataColumn(label: Text('Category')),
                    DataColumn(label: Text('Image')),
                  ],
                  source: ProductDataSource(productController.products),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
