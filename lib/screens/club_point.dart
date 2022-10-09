import 'package:flutter/material.dart';
import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:active_ecommerce_flutter/app_config.dart';
import 'package:active_ecommerce_flutter/repositories/clubpoint_repository.dart';
import 'package:active_ecommerce_flutter/helpers/shimmer_helper.dart';
import 'package:active_ecommerce_flutter/custom/toast_component.dart';
import 'package:active_ecommerce_flutter/screens/wallet.dart';
import 'package:toast/toast.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';


class Clubpoint extends StatefulWidget {
  @override
  _ClubpointState createState() => _ClubpointState();
}

class _ClubpointState extends State<Clubpoint> {
  ScrollController _xcrollController = ScrollController();

  List<dynamic> _list = [];
  List<dynamic> _converted_ids = [];
  bool _isInitial = true;
  int _page = 1;
  int _totalData = 0;
  bool _showLoadingContainer = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchData();

    _xcrollController.addListener(() {
      //print("position: " + _xcrollController.position.pixels.toString());
      //print("max: " + _xcrollController.position.maxScrollExtent.toString());

      if (_xcrollController.position.pixels ==
          _xcrollController.position.maxScrollExtent) {
        setState(() {
          _page++;
        });
        _showLoadingContainer = true;
        fetchData();
      }
    });
  }

  fetchData() async {
    var clubpointResponse =
        await ClubpointRepository().getClubPointListResponse(page: _page);
    _list.addAll(clubpointResponse.clubpoints);
    _isInitial = false;
    _totalData = clubpointResponse.meta.total;
    _showLoadingContainer = false;
    setState(() {});
  }

  reset() {
    _list.clear();
    _converted_ids.clear();
    _isInitial = true;
    _totalData = 0;
    _page = 1;
    _showLoadingContainer = false;
    setState(() {});
  }

  Future<void> _onRefresh() async {
    reset();
    fetchData();
  }

  onPressConvert(item_id,_convertedSnackbar) async{

    var clubpointToWalletResponse =
    await ClubpointRepository().getClubpointToWalletResponse(
      item_id
    );

    if (clubpointToWalletResponse.result == false) {
      ToastComponent.showDialog(clubpointToWalletResponse.message, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
    } else {
      /*ToastComponent.showDialog(clubpointToWalletResponse.message, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);*/
      Scaffold.of(context).showSnackBar(_convertedSnackbar);

      _converted_ids.add(item_id);
      setState(() {

      });
    }


  }

  onPopped(value) async {
     reset();
     fetchData();
  }

  @override
  Widget build(BuildContext context) {

    SnackBar _convertedSnackbar = SnackBar(
      content: Text(
        AppLocalizations.of(context).club_point_screen_snackbar_points_converted,
        style: TextStyle(color: MyTheme.font_grey),
      ),
      backgroundColor: MyTheme.soft_accent_color,
      duration: const Duration(seconds: 3),
      action: SnackBarAction(
        label: AppLocalizations.of(context).club_point_screen_snackbar_show_wallet,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Wallet();
          })).then((value) {
            onPopped(value);
          });
        },
        textColor: MyTheme.accent_color,
        disabledTextColor: Colors.grey,
      ),
    );

    return Directionality(
      textDirection: app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar(context),
        body: Stack(
          children: [
            RefreshIndicator(
              color: MyTheme.accent_color,
              backgroundColor: Colors.white,
              onRefresh: _onRefresh,
              displacement: 0,
              child: CustomScrollView(
                controller: _xcrollController,
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                slivers: [
                  SliverList(
                    delegate: SliverChildListDelegate([
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: buildList(_convertedSnackbar),
                      ),
                    ]),
                  )
                ],
              ),
            ),
            Align(
                alignment: Alignment.bottomCenter, child: buildLoadingContainer())
          ],
        ),
      ),
    );
  }

  Container buildLoadingContainer() {
    return Container(
      height: _showLoadingContainer ? 36 : 0,
      width: double.infinity,
      color: Colors.white,
      child: Center(
        child: Text(_totalData == _list.length
            ? AppLocalizations.of(context).common_no_more_items
            : AppLocalizations.of(context).common_loading_more_items),
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
        AppLocalizations.of(context).club_point_screen_earned_points,
        style: TextStyle(fontSize: 16, color: MyTheme.accent_color),
      ),
      elevation: 0.0,
      titleSpacing: 0,
    );
  }

  buildList(_convertedSnackbar) {
    if (_isInitial && _list.length == 0) {
      return SingleChildScrollView(
          child: ShimmerHelper()
              .buildListShimmer(item_count: 10, item_height: 100.0));
    } else if (_list.length > 0) {
      return SingleChildScrollView(
        child: ListView.builder(
          itemCount: _list.length,
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(0.0),
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return buildItemCard(index,_convertedSnackbar);
          },
        ),
      );
    } else if (_totalData == 0) {
      return Center(child: Text(AppLocalizations.of(context).common_no_data_available));
    } else {
      return Container(); // should never be happening
    }
  }

  buildItemCard(index,_convertedSnackbar) {
    return Card(
      shape: RoundedRectangleBorder(
        side: new BorderSide(color: MyTheme.light_grey, width: 1.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 0.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            Container(
                width: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _list[index].date,
                      style: TextStyle(
                        color: MyTheme.dark_grey,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      AppLocalizations.of(context).club_point_screen_converted_question,
                      style: TextStyle(
                        color: MyTheme.dark_grey,
                      ),
                    ),
                    Text(
                      _list[index].convert_status == 1 || _converted_ids.contains(_list[index].id) ? "Yes" : "No",
                      style: TextStyle(
                        color: _list[index].convert_status == 1? Colors.green: Colors.blue,
                      ),
                    ),
                  ],
                )),
            Spacer(),
            Container(
                width: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      _list[index].points.toString(),
                      style: TextStyle(
                          color: MyTheme.accent_color,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    _list[index].convert_status == 1 || _converted_ids.contains(_list[index].id) ? Text(
                      AppLocalizations.of(context).club_point_screen_done,
                      style: TextStyle(
                        color: Colors.green,
                      ),
                    ):SizedBox(
                      height: 24,
                      width: 80,

                      child: FlatButton(
                        color: MyTheme.accent_color,
                        child: Text(
                          AppLocalizations.of(context).club_point_screen_convert,
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          onPressConvert(_list[index].id,_convertedSnackbar);
                        },
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
