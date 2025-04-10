import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controller/dashboard_controller.dart';

class DesktopOrdersScreen extends StatefulWidget {
  const DesktopOrdersScreen({super.key});

  @override
  State<DesktopOrdersScreen> createState() => _DesktopOrdersScreenState();
}

class _DesktopOrdersScreenState extends State<DesktopOrdersScreen> {
  final DashboardController controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            TextFormField(controller:controller.textEditingController,
              onChanged: (query)=>controller.searchQuery(query),
              decoration: InputDecoration(hintText: 'Search',prefixIcon: Icon(Icons.search)),),
            SizedBox(height: 20,),
            Obx(
              () {
                  Visibility(visible: false,
                    child: Text(controller.dataList.length.toString()),);
                  return SizedBox(
                    height: 400,
                    child: Theme(
                      data: Theme.of(context).copyWith(
                          cardTheme: const CardTheme(
                            color: Colors.white, elevation: 0,)),
                      child: PaginatedDataTable2(
                        columnSpacing: 12,
                        horizontalMargin: 12,
                        minWidth: 786,
                        dividerThickness: 0,
                        showCheckboxColumn: true,
                        dataRowHeight: 50,
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
                        columns: [
                          DataColumn2(label: Text("column1")),
                          DataColumn2(label: Text("column2"),
                              onSort: (columnIndex, ascending) =>
                                  controller.sortById(columnIndex, ascending)),
                          DataColumn2(label: Text("column3")),
                          DataColumn2(label: Text("column4"),
                              onSort: (columnIndex, ascending) =>
                                  controller.sortById(columnIndex, ascending)),
                        ],
                        source: MyOrders(),
                        showFirstLastButtons: true,
                        onPageChanged: (value) {},
                        onRowsPerPageChanged: (noOfRow) {},
                        renderEmptyRowsInTheEnd: false,
                        sortAscending: controller.sortAscending.value,
                        sortArrowIcon: Icons.line_axis,
                        sortColumnIndex: controller.sortColumnIndex.value,
                        sortArrowBuilder: (bool ascending, bool sorted) {
                          if (sorted) {
                            return Icon(ascending ? Icons.upload : Icons
                                .arrow_circle_down_sharp, size: 15,);
                          } else {
                            return Icon(Icons.u_turn_left, size: 15,);
                          }
                        },
                      ),
                    ),
                  );
              }
            ),
          ],
        ),
      ),
    );
  }
}

class MyOrders extends DataTableSource{
  final DashboardController controller = Get.put(DashboardController());
  @override
  DataRow? getRow(int index) {
    final data = controller.dataList[index];
    return DataRow2(
      onTap: (){},
        selected: controller.selectedRow[index],
        onSelectChanged: (value){
        controller.selectedRow[index] = value ?? false;
        },
      cells: [
        DataCell(Text(data['Column1'] ?? '')),
        DataCell(Text(data['Column2'] ?? '')),
        DataCell(Text(data['Column3'] ?? '')),
        DataCell(Text(data['Column4'] ?? '')),

      ]
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.dataList.length;

  @override
  int get selectedRowCount => 0;

}
