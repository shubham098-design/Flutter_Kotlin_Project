import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController{
  var dataList = <Map<String,String>>[].obs;
  var dataList2 = <Map<String,String>>[].obs;
  RxList<bool> selectedRow = <bool>[].obs;
  RxInt sortColumnIndex = 1.obs;
  RxBool sortAscending = true.obs;
  TextEditingController textEditingController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchDummyData();
  }

  void fetchDummyData(){
    selectedRow.addAll(List.generate(36, (index)=>false));

    dataList.addAll(List.generate(36,
        (index)=>{
      'Column1' : 'Data ${index+1} -1',
      'Column2' : 'Data ${index+1} -2',
      'Column3' : 'Data ${index+1} -3',
      'Column4' : 'Data ${index+1} -4',
    }));
    dataList2.addAll(List.generate(36,
            (index)=>{
          'Column1' : 'Data ${index+1} -1',
          'Column2' : 'Data ${index+1} -2',
          'Column3' : 'Data ${index+1} -3',
          'Column4' : 'Data ${index+1} -4',
        }));
  }

  void sortById(int sortColumnIndex , bool ascending){
    sortAscending.value = ascending;
    dataList.sort((a,b){
      if(ascending){
        return dataList[0]['Column1'].toString().toLowerCase().compareTo( dataList[0]['Column1'].toString().toLowerCase());
      }else{
        return dataList[0]['Column1'].toString().toLowerCase().compareTo( dataList[0]['Column1'].toString().toLowerCase());
      }
    });



    this.sortColumnIndex.value = sortColumnIndex;
  }
  void searchQuery(String query){
    dataList.assignAll(dataList2.where((item)=> item['Column1']!.contains(query.toLowerCase())));
  }
}