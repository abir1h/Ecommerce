import 'dart:convert';
import 'package:active_ecommerce_flutter/data_model/BigzbeShopList.dart';
import 'package:active_ecommerce_flutter/screens/bigzloot-single.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shimmer/shimmer.dart';

import '../my_theme.dart';

class Bigzloot extends StatefulWidget {
  @override
  State<Bigzloot> createState() => _BigzlootState();
}

class _BigzlootState extends State<Bigzloot> {

  @override
  void initState(){
    super.initState();
    Slider = getSliderData();
    FutuerBigzbeShopList = fetchBogzbleShopList();
  }

  List items = [];
   Future Slider;
   List SliderItems = [];
  getSliderData() async{
    final response = await http.get(Uri.parse("https://bigzbe.com/api/v2/bzslider"));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      for(Map i in data){
        items.add(i["image"]);
      }
      return items;
    }else{
      return items;
    }
  }



   //#################-- Show category 00###############
  Future FutuerBigzbeShopList;
  fetchBogzbleShopList() async {
    final response = await http
        .get(Uri.parse('https://bigzbe.com/api/v2/bigzloot'));

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
    return SafeArea(
      child: Scaffold(
        appBar: buildAppBar(context),
        body: Column(
          children: [
            //############### -- SLieder --#################
              buildSlider(),
            //############### -- SLieder --#################

            SizedBox(height: 30,),

            buildBigzbeShopFutuer(width)


          ],
        ),
      )
    );
  }

  Expanded buildBigzbeShopFutuer(double width) {
    return Expanded(
            child: FutureBuilder(
              future: FutuerBigzbeShopList,
              builder: (context, AsyncSnapshot<dynamic> snapshot) {
                if(snapshot.hasData){
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                      itemBuilder: (_, index){
                        return InkWell(
                          onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>SingleBigzloot(id: snapshot.data[index]["id"].toString(),))),
                          child: Container(
                            margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                            padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: AssetImage("assets/placeholder-rect.jpg"),
                                  fit: BoxFit.cover,
                                )
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: Container(
                                    //   alignment: Alignment.topRight,
                                    padding: EdgeInsets.only(left:10, right:10, top:5, bottom:5),
                                    decoration: BoxDecoration(
                                      borderRadius:  BorderRadius.circular(100),
                                      color: Colors.white70,
                                    ),
                                    child:  Text("${snapshot.data[index]["shop_category"]}",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey
                                      ),
                                    ),
                                  ),),

                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                  children: [
                                    Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(500),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.5),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: Offset(0, 3), // changes position of shadow
                                            ),
                                          ],
                                          image: DecorationImage(
                                            image: AssetImage("assets/placeholder-rect.jpg"),
                                            fit: BoxFit.cover,
                                          )
                                      ),

                                    ),

                                    SizedBox(width: 30,),
                                    Column(
                                      children: [
                                        Text("${snapshot.data[index]["name"]}",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text("${snapshot.data[index]["address"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        )
                                      ],
                                    ),



                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                  );

                }else if(snapshot.connectionState == ConnectionState.waiting){
                  return ListView.builder(
                    itemCount: 5,

                    itemBuilder: (_, index)=>Shimmer.fromColors(
                    highlightColor: Colors.white,
                    baseColor: Colors.grey.withOpacity(0.2),
                    child: Container(
                      width: width,
                      height: 120,
                      margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: AssetImage("assets/placeholder-rect.jpg"),
                            fit: BoxFit.cover,
                          )
                      ),
                    ),
                  )
                  );
                }else{
                  return Center(
                    child: Text("No data found.",

                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: Colors.red
                      ),
                    ),
                  );
                }
              },
            ),
          );
  }



   FutureBuilder<dynamic> buildSlider() {
     return FutureBuilder(
          future: Slider,
            builder: (context, AsyncSnapshot<dynamic> snapshot){
            if(snapshot.hasData){
              return CarouselSlider.builder(
                itemCount: items.length,
                options: CarouselOptions(
                  height: 150,
                  aspectRatio: 16/9,
                  viewportFraction: 0.8,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  initialPage: 0,
                  enableInfiniteScroll:true,
                  reverse: false,
                  autoPlayInterval: Duration(seconds: 5),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal,
                ),
                itemBuilder: (context, index, realIdx) {
                  return  Container(
                    height: 120,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                            image: NetworkImage("https://bigzbe.com/public/uploads/bzslider/${items[index]}"),
                            fit: BoxFit.cover
                        )
                    ),

                  );
                },
              );
            }else if(snapshot.connectionState == ConnectionState.waiting){
              return CarouselSlider.builder(
                itemCount: 3,
                options: CarouselOptions(
                  height: 150,
                  aspectRatio: 16/9,
                  viewportFraction: 0.8,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  initialPage: 0,
                  enableInfiniteScroll:true,
                  reverse: false,
                  autoPlayInterval: Duration(seconds: 5),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal,
                ),
                itemBuilder: (context, index, realIdx) {
                  return  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                            image: AssetImage("assets/Loading.gif"),

                        )
                    ),

                  );
                },
              );

            }else{
              return Center(child: Text("Something went warning"),);
            }

            }
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



