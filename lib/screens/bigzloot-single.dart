import 'dart:convert';

import 'package:active_ecommerce_flutter/helpers/shimmer_helper.dart';
import 'package:active_ecommerce_flutter/screens/bigzloot-json.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import '../my_theme.dart';

class SingleBigzloot extends StatefulWidget {
  final dynamic id;
  final dynamic itemIndex;
  SingleBigzloot({this.id, this.itemIndex});

  @override
  State<SingleBigzloot> createState() => _SingleBigzlootState();
}

class _SingleBigzlootState extends State<SingleBigzloot> {

  @override
  void initState(){
    super.initState();
    FutuerBigzbeShopList = fetchBogzbleSingleShop();
  }

  //#################-- Show category 00###############
  Future FutuerBigzbeShopList;
  fetchBogzbleSingleShop() async {
    final response = await http
        .get(Uri.parse('https://bigzbe.com/api/v2/bigzloot/${widget.id}'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return jsonDecode(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Bigtrost');
    }
  }


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      //appBar: buildAppBar(context),

      body: Container( 
        width: width,
        height: height,
        child: FutureBuilder(
          future: FutuerBigzbeShopList,
          builder: (_, AsyncSnapshot<dynamic> snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(
                child: Image.asset("assets/Loading.gif", height: 50, width: 50,),
              );
            }else if(snapshot.hasData){
              var data = snapshot.data;
              return  SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: width,
                      height: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
                        image: DecorationImage(
                          image: AssetImage("assets/placeholder-rect.jpg"),
                          fit:BoxFit.cover,
                        ),
                      ),
                      child:  Stack(
                        children: [
                          Positioned(
                            left: 20, top: 40,
                            child: IconButton(
                              onPressed: ()=>Navigator.pop(context),
                              icon: Icon(
                                Icons.arrow_back_ios,
                              ),
                              color: MyTheme.accent_color,
                              iconSize: 20,
                            ),
                          ),

                          data["is_discounted"] == '1' ? Positioned(
                              right: 20,
                              top: 50,
                              child: Container(
                                padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                                decoration: BoxDecoration(
                                    color: MyTheme.accent_color,
                                    borderRadius: BorderRadius.circular(100)
                                ),
                                child: Text("${data["flat_discount"]}% OFF",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600
                                  ),
                                ),
                              ))
                              : Center(),
                        ],
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${data["name"]}",
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  Text("${data["shop_category"]}",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.blueAccent
                                    ),
                                  ),
                                ],
                              ),

                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    color: Colors.blue,
                                  ),
                                  Text(
                                    "${data["address"]}",
                                    style: TextStyle(
                                        fontSize: 15
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),

                          SizedBox(height: 20,),

                          Container(
                            width: width,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text(
                                  "Contact",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    color: Colors.black45
                                  ),
                                ),
                                SizedBox(height: 5,),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.call,
                                        color: Colors.black45
                                    ),
                                    SizedBox(width: 5,),
                                    Text(
                                      "${data["phone"]}",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black45
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),

                          ),

                          SizedBox(height: 20,),
                      Container(
                        width: width,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.watch_later_outlined,
                                color: Colors.deepPurpleAccent
                            ),
                            SizedBox(width: 5,),
                            Text(
                              "Opening Hours",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                color: Colors.black54
                              ),
                            ),
                          ],
                        ),
                      ), SizedBox(height: 20,),
                          Container(
                            width: width,
                            height: 500,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              //color: Colors.white,
                            ),
                            child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                             itemCount: BigzlootJson.bigzlootTime[widget.itemIndex].length,
                              itemBuilder: (_, index){
                                var data =  BigzlootJson.bigzlootTime[widget.itemIndex][index];
                                print(data);
                               return Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   Container(
                                     width: 50,
                                     height: 50,
                                     margin: EdgeInsets.only(bottom: 10),
                                     decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(100),
                                       color: Colors.blue,
                                     ),
                                     child: Center(
                                       child: Text("${data["day"]}",
                                         style: TextStyle(
                                           color: Colors.white,
                                         ),
                                       ),
                                     ),
                                   ),
                                   Container(
                                     width: 100,
                                     height: 50,
                                     padding: EdgeInsets.all(10),
                                     decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(5),
                                       color: Colors.white,
                                       boxShadow: [
                                         BoxShadow(
                                             spreadRadius: 1,
                                             blurRadius: 10,
                                             offset: Offset(0,2),
                                             color: Colors.grey.shade200
                                         )
                                       ],
                                     ),
                                     child: Center(
                                       child: Text(
                                         "${data["open"]}",
                                         style: TextStyle(
                                             fontSize: 15,
                                             fontWeight: FontWeight.w600
                                         ),
                                       ),
                                     ),
                                   ),
                                   Icon(
                                     Icons.remove,
                                   ),
                                   Container(
                                     width: 100,
                                     height: 50,
                                     padding: EdgeInsets.all(10),
                                     decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(5),
                                       color: Colors.white,
                                       boxShadow: [
                                         BoxShadow(
                                             spreadRadius: 1,
                                             blurRadius: 10,
                                             offset: Offset(0,2),
                                             color: Colors.grey.shade200
                                         )
                                       ],
                                     ),
                                     child: Center(
                                       child: Text(
                                         "${data["close"]}",
                                         style: TextStyle(
                                             fontSize: 15,
                                             fontWeight: FontWeight.w600
                                         ),
                                       ),
                                     ),
                                   ),
                                 ],
                               );
                              },
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            }else{
              return Center(
                child: Column(
                  children: [
                    Image.asset("assets/Loading.gif", height: 50, width: 50,),
                    Text("Something went wearing, Trying to reconnect")
                  ],
                ),
              );
            }
          }

        ),

      ),

    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      leading: Builder(
        builder: (context) => IconButton(
          icon: Icon(Icons.arrow_back, color: MyTheme.dark_grey),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      title: Text(
        "Bigzloot",
        // AppLocalizations.of(context).bkash_screen_pay_with_bkash,
        style: TextStyle(fontSize: 16, color: MyTheme.accent_color),
      ),
      elevation: 0.0,
      titleSpacing: 0,
    );
  }
}
