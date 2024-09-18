import 'package:flutter/material.dart';
import 'package:online_groceries/common_widget/round_button.dart';

import '../../common/color_extension.dart';
import '../../common_widget/filter_row.dart';

class FilterView extends StatefulWidget {
  const FilterView({super.key});

  @override
  State<FilterView> createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  List selectArr = [];

  List filterCatArr = [
    {
      "id": "1",
      "name": "Ghế gỗ",
    },
    {
      "id": "2",
      "name": "Bàn học",
    },
    {
      "id": "3",
      "name": "Tủ đầu giường",
    },
    {
      "id": "4",
      "name": "Bàn trang điểm",
    },
  ];

  List filterBrandArr = [
    {
      "id": "4",
      "name": "BH Store",
    },
    {
      "id": "2",
      "name": "Thái Công",
    },

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Image.asset(
                "assets/img/close.png",
                width: 20,
                height: 20,
              )),
          title: Text(
            "Lọc sản phẩm",
            style: TextStyle(
                color: TColor.primaryText,
                fontSize: 20,
                fontWeight: FontWeight.w700),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
              color: Color(0xffF2F3F2),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          "Loại sản phẩm",
                          style: TextStyle(
                              color: TColor.primaryText,
                              fontSize: 24,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Column(
                        children: filterCatArr.map((fObj) {
                          return FilterRow(
                            fObj: fObj,
                            isSelect: selectArr.contains(fObj),
                            onPressed: () {
                              if (selectArr.contains(fObj)) {
                                selectArr.remove(fObj);
                              } else {
                                selectArr.add(fObj);
                              }
                              setState(() {});
                            },
                          );
                        }).toList(),
                      ),

                     const SizedBox(height: 15,),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          "Thương hiệu",
                          style: TextStyle(
                              color: TColor.primaryText,
                              fontSize: 24,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Column(
                        children: filterBrandArr.map((fObj) {
                          return FilterRow(
                            fObj: fObj,
                            isSelect: selectArr.contains(fObj),
                            onPressed: () {
                              if (selectArr.contains(fObj)) {
                                selectArr.remove(fObj);
                              } else {
                                selectArr.add(fObj);
                              }
                              setState(() {});
                            },
                          );
                        }).toList(),
                      )
                    ],
                  ),
                ),
              ),
              RoundButton(title: "Lọc sản phẩm", onPressed: () {})
            ],
          ),
        ));
  }
}
