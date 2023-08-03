import 'dart:convert';
import 'dart:developer';

import 'package:demo_class/pages/stockAnalysisService.dart';
import 'package:demo_class/pages/stockAnaysisModel.dart';
import 'package:flutter/material.dart';

import '../constants/styleConstant.dart';


class StockAnalysisPage extends StatefulWidget {
  const StockAnalysisPage({Key? key}) : super(key: key);

  @override
  State<StockAnalysisPage> createState() => _StockAnalysisPage();
}

class _StockAnalysisPage extends State<StockAnalysisPage> {
  // String get $i => null;

  StockAnalysis stockAnalysis = StockAnalysis();

  final TextEditingController _searchController = TextEditingController();
  static String _searchItem = '';

  Future searchHandling() async {
    // await Future.delayed(const Duration(seconds: 3));
    log(" SEARCH ${_searchController.text}");
    if (_searchItem == "") {
      return await stockAnalysis.fetchStockListFromUrl("");
    } else {
      return await stockAnalysis.fetchStockListFromUrl(_searchItem);
    }
  }

  @override
  void initState() {
    searchHandling();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
         'Stock Analysis',  style: TextStyle(color: Colors.black, fontSize: 15,fontWeight: FontWeight.bold),),
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
      ),
      // backgroundColor: const Color(0xffeff3ff),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [


              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  width: width,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 20, right: 5, left: 5, bottom: 50),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _searchController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: "Search",
                            hintStyle:
                                Theme.of(context).textTheme.subtitle1!.copyWith(
                                      fontSize: 18,
                                      color: Colors.grey,
                                    ),
                            // filled: true,
                            // fillColor: Theme.of(context).backgroundColor,
                            prefixIcon: const Icon(Icons.search),
                            border: InputBorder.none,
                            errorBorder: InputBorder.none,
                            errorMaxLines: 4,
                          ),
                          // validator: validator,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: (query) {
                            setState(() {
                              _searchItem = query;
                            });
                          },
                          textCapitalization: TextCapitalization.sentences,
                        ),
                        FutureBuilder(
                          future: searchHandling(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              try {
                                final snapshotData = json.decode(snapshot.data);


                                StockAnalysisModel stockAnalaysisModel =
                                    StockAnalysisModel.fromJson(snapshotData);
                                // log(snapshotData.toString());
                                return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: stockAnalaysisModel.results!.length,
                                    physics: const ScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Card(
                                        margin: kMarginPaddSmall,
                                        color: stockAnalaysisModel.results![index].remainingQty!.toInt()<10?Colors.red.shade50:Colors.white,
                                        elevation: kCardElevation,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12.0)),
                                        child: Container(
                                          padding: kMarginPaddSmall,
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                    Icon(Icons.qr_code),
                                                      Text("${ stockAnalaysisModel.results![index].code}"),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text("Rem Qty:",style: TextStyle(fontWeight: FontWeight.bold),),
                                                      Text("${stockAnalaysisModel.results![index].remainingQty}"),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              // SizedBox(height: 10,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: 200,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          "${stockAnalaysisModel.results![index].name}",
                                                          style: TextStyle(fontWeight: FontWeight.bold),
                                                        ),
                                                        Text(
                                                          "${stockAnalaysisModel.results![index].itemCategoryName}",
                                                          style: TextStyle(fontWeight: FontWeight.bold),
                                                        ),
                                                      ],
                                                    ),
                                                  ),




                                                ],
                                              ),
                                              // kHeightSmall,

                                            ],
                                          ),
                                        ),
                                      );
                                    });


                                  // DataTable(
                                  //   sortColumnIndex: 0,
                                  //   columnSpacing: 0,
                                  //   horizontalMargin: 0,
                                  //
                                  //   // columnSpacing: 10,
                                  //
                                  //   columns: [
                                  //     DataColumn(
                                  //       label: SizedBox(
                                  //         width: width * .1,
                                  //         child: const Text(
                                  //           'SN',
                                  //           style: TextStyle(
                                  //               fontSize: 18,
                                  //               fontWeight: FontWeight.bold),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //     DataColumn(
                                  //       label: SizedBox(
                                  //         width: width * .3,
                                  //         child: const Text(
                                  //           'Name',
                                  //           style: TextStyle(
                                  //               fontSize: 18,
                                  //               fontWeight: FontWeight.bold),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //     DataColumn(
                                  //       label: SizedBox(
                                  //         width: width * .25,
                                  //         child: const Text(
                                  //           'Purchase',
                                  //           style: TextStyle(
                                  //               fontSize: 18,
                                  //               fontWeight: FontWeight.bold),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //     DataColumn(
                                  //       label: SizedBox(
                                  //         width: width * .25,
                                  //         child: const Text(
                                  //           'Remaining',
                                  //           style: TextStyle(
                                  //               fontSize: 18,
                                  //               fontWeight: FontWeight.bold),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ],
                                  //   rows: List.generate(
                                  //       stockAnalaysisModel.results!.length,
                                  //       (index) => DataRow(
                                  //             // selected: true,
                                  //             cells: [
                                  //               DataCell(
                                  //                 Text(
                                  //                   (index + 1).toString(),
                                  //                   style: const TextStyle(
                                  //                       fontSize: 12,
                                  //                       fontWeight:
                                  //                           FontWeight.bold),
                                  //                 ),
                                  //               ),
                                  //               DataCell(
                                  //                 Text(
                                  //                   stockAnalaysisModel
                                  //                       .results![index].name
                                  //                       .toString(),
                                  //                   style: const TextStyle(
                                  //                       fontSize: 12,
                                  //                       fontWeight:
                                  //                           FontWeight.bold),
                                  //                 ),
                                  //               ),
                                  //               // DataCell(Text(
                                  //               //   stockAnalaysisModel
                                  //               //       .results![index].code
                                  //               //       .toString(),
                                  //               //   style: const TextStyle(
                                  //               //       fontSize: 12,
                                  //               //       fontWeight:
                                  //               //           FontWeight.bold),
                                  //               // )),
                                  //               DataCell(
                                  //                 Text(
                                  //                   stockAnalaysisModel
                                  //                       .results![index]
                                  //                       .purchaseQty
                                  //                       .toString(),
                                  //                   style: const TextStyle(
                                  //                       fontWeight:
                                  //                           FontWeight.bold,
                                  //                       fontSize: 12,
                                  //                       color: Colors.black),
                                  //                 ),
                                  //               ),
                                  //               DataCell(
                                  //                 Text(
                                  //                   stockAnalaysisModel
                                  //                       .results![index]
                                  //                       .remainingQty
                                  //                       .toString(),
                                  //                   style: const TextStyle(
                                  //                       fontWeight:
                                  //                           FontWeight.bold,
                                  //                       fontSize: 12,
                                  //                       color: Colors.black),
                                  //                 ),
                                  //               ),
                                  //               // DataCell(
                                  //               //   Container(
                                  //               //     height: 20,
                                  //               //     width: 20,
                                  //               //     decoration: BoxDecoration(
                                  //               //         color:
                                  //               //             Colors.indigo[900],
                                  //               //         borderRadius:
                                  //               //             const BorderRadius
                                  //               //                     .all(
                                  //               //                 Radius.circular(
                                  //               //                     5))),
                                  //               //     child: const Center(
                                  //               //       child: FaIcon(
                                  //               //         FontAwesomeIcons
                                  //               //             .penToSquare,
                                  //               //         size: 15,
                                  //               //         color: Colors.white,
                                  //               //       ),
                                  //               //     ),
                                  //               //   ),
                                  //               // )
                                  //             ],
                                  //           )));
                              } catch (e) {
                                throw Exception(e);
                              }
                            } else {
                              return Text("djlk");
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
