import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:imba/ui/screens/appointment.dart';
import 'package:imba/ui/screens/view_house.dart';

import '../../data/models/search_response_model.dart';
import '../../secure_storage/secure_storage_manager.dart';
import '../../utilities/constants.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/logo.dart';

class InfiniteSearchResult extends StatefulWidget {
  final String token;
  final String area;
  final String city;
  final int page;
  final int size;
  final bool isBorehole;
  final bool isSolar;
  final String minRent;
  final String maxRent;
  final bool waterInclusive;
  final bool electricityInclusive;
  final bool isDeposit;
  final String contact;
  final bool isGated;
  final bool isTiled;
  final bool isWalled;
  final String classification;
  final String type;
  final String searchValue;
  final String startDate;
  final String endDate;
  final String minRooms;
  final String maxRooms;
  final bool isSearch;

  const InfiniteSearchResult(
      {Key? key,
      required this.area,
      required this.city,
      required this.isSearch,
      required this.token,
      required this.page,
      required this.size,
      required this.isBorehole,
      required this.isSolar,
      required this.minRent,
      required this.maxRent,
      required this.waterInclusive,
      required this.electricityInclusive,
      required this.isDeposit,
      required this.contact,
      required this.isGated,
      required this.isTiled,
      required this.isWalled,
      required this.classification,
      required this.type,
      required this.searchValue,
      required this.startDate,
      required this.endDate,
      required this.minRooms,
      required this.maxRooms})
      : super(key: key);

  @override
  State<InfiniteSearchResult> createState() => _InfiniteSearchResultState();
}

class _InfiniteSearchResultState extends State<InfiniteSearchResult> {
  int _page = 0;

  // you can change this value to fetch more or less posts per page (10, 15, 5, etc)
  final int _limit = 10;

  // There is next page or not
  bool _hasNextPage = true;

  // Used to display loading indicators when _firstLoad function is running
  bool _isFirstLoadRunning = false;

  // Used to display loading indicators when _loadMore function is running
  bool _isLoadMoreRunning = false;

  // This holds the data from the server indipendently
  List<SearchedList> searchList = [];
  List<ViewedList> viewedList = [];
  String userToken = '';
  var listLength = 0;

  final SecureStorageManager _secureStorageManager = SecureStorageManager();
  Object errorMessage = "";

  // This function will be called when the app launches (see the initState function)
  void _firstLoad() async {
    setState(() {
      _isFirstLoadRunning = true;
    });
    try {
      var token = await _secureStorageManager.getToken();
      final res = await http.get(Uri.parse(
          "$BASE_URL/house/list?page=$_page&size=$_limit&area=${widget.area}&city=${widget.city}&searchValue=${widget.searchValue}&startDate=${widget.startDate}&type=${widget.type}&classification=${widget.classification}&endDate=${widget.endDate}&borehole=${widget.isBorehole}&solar=${widget.isSolar}&minRent=${widget.minRent}&maxRent=${widget.maxRent}&rentWaterInclusive=${widget.waterInclusive}&rentElectricityInclusive=${widget.electricityInclusive}&needsDeposit=${widget.isDeposit}&token=$token&contact=${widget.contact}&gated=${widget.isGated}&tiled=${widget.isTiled}&walled=${widget.isWalled}&minNumberRooms=${widget.minRooms}&maxNumberRooms=${widget.maxRooms}"));

      final json = jsonDecode(res.body);
      setState(() {
        widget.isSearch
            ? (searchList = SearchResponse.fromJson(json).searchedList)
            : viewedList = SearchResponse.fromJson(json).viewedList;
      });
    } catch (err) {
      if (kDebugMode) {
        print(err.toString());
        print('Something went wrong');
      }
    }

    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  // This function will be triggered whenver the user scroll
  // to near the bottom of the list view
  void _loadMore() async {
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });
      _page += 1; // Increase _page by 1
      try {
        var token = await _secureStorageManager.getToken();
        final res = await http.get(Uri.parse(
            "$BASE_URL/house/list?page=$_page&size=$_limit&area=${widget.area}&searchValue=${widget.searchValue}&startDate=${widget.startDate}&city=${widget.city}&type=${widget.type}&classification=${widget.classification}&endDate=${widget.endDate}&borehole=${widget.isBorehole}&solar=${widget.isSolar}&minRent=${widget.minRent}&maxRent=${widget.maxRent}&rentWaterInclusive=${widget.waterInclusive}&rentElectricityInclusive=${widget.electricityInclusive}&needsDeposit=${widget.isDeposit}&token=$token&contact=${widget.contact}&gated=${widget.isGated}&tiled=${widget.isTiled}&walled=${widget.isWalled}&minNumberRooms=${widget.minRooms}&maxNumberRooms=${widget.maxRooms}"));
        final SearchResponse fetchedPosts = json.decode(res.body);
        if (fetchedPosts.searchedList.isNotEmpty ||
            fetchedPosts.viewedList.isNotEmpty) {
          setState(() {
            widget.isSearch
                ? searchList.addAll(fetchedPosts.searchedList)
                : viewedList.addAll(fetchedPosts.viewedList);
          });
        } else {
          // This means there is no more data
          // and therefore, we will not send another GET request
          setState(() {
            _hasNextPage = false;
          });
        }
      } catch (err) {
        if (kDebugMode) {
          print(err.toString());
          print('Something went wrong!');
          setState(() {
            errorMessage = err;
          });
        }
      }

      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  // The controller for the ListView
  late ScrollController _controller;

  @override
  void initState() {
    super.initState();

    _firstLoad();
    _controller = ScrollController()..addListener(_loadMore);
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    listLength = widget.isSearch ? searchList.length : viewedList.length;
    return _isFirstLoadRunning
        ? const Center(
            child: LoadingIndicator(),
          )
        : listLength < 1
            ? Center(
                child: Container(
                  height: 500,
                  width: 500,
                  alignment: Alignment.center,
                  child: const Center(
                    child: Text("No properties found",
                        style: TextStyle(fontSize: 30, color: Colors.black)),
                  ),
                ),
              )
            : Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        controller: _controller,
                        itemCount: widget.isSearch
                            ? searchList.length
                            : viewedList.length,
                        itemBuilder: (_, index) => Card(
                          child: Row(children: [
                            Expanded(
                                flex: 2,
                                child: Column(children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ViewHouse(
                                                  id: widget.isSearch
                                                      ? searchList[index].id
                                                      : viewedList[index].id,
                                                  flag: "actions")));
                                    },
                                    child: const Logo(
                                        imageUrl: 'assets/images/houseicon.png',
                                        height: 100,
                                        width: 100),
                                  )
                                ])),
                            Expanded(
                              flex: 3,
                              child: Column(children: [
                                Text(
                                    widget.isSearch
                                        ? searchList[index].id.toString()
                                        : viewedList[index].houseAddress,
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)),
                                Text(
                                    widget.isSearch
                                        ? searchList[index].area
                                        : viewedList[index].area,
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold)),
                                Text(
                                    widget.isSearch
                                        ? searchList[index].city
                                        : viewedList[index].city,
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold))
                              ]),
                            ),
                            Expanded(
                                flex: 1,
                                child: Column(children: [
                                  Text(
                                      widget.isSearch
                                          ? searchList[index]
                                              .numberRooms
                                              .toString()
                                          : viewedList[index]
                                              .numberRooms
                                              .toString(),
                                      style: const TextStyle(
                                        color: ColorConstants.yellow,
                                        fontSize: 17,
                                      ))
                                ])),
                            Expanded(
                                flex: 2,
                                child: Column(children: [
                                  Text(
                                      widget.isSearch
                                          ? searchList[index].currency +
                                              searchList[index].rent.toString()
                                          : viewedList[index].currency +
                                              viewedList[index].rent.toString(),
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                  CustomElevateButton(
                                    name: widget.isSearch ? "VIEW" : "RESERVE",
                                    color: Colors.black,
                                    fontSize: 10,
                                    onSubmit: () {
                                      widget.isSearch
                                          ? Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ViewHouse(
                                                        id: searchList[index]
                                                            .id,
                                                        flag: 'actions',
                                                      )))
                                          : WidgetsBinding.instance!
                                              .addPostFrameCallback((_) {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Appointment(
                                                              action: 'UPDATE',
                                                              houseId:
                                                                  viewedList[
                                                                          index]
                                                                      .id)));
                                            });
                                    },
                                  )
                                ]))
                          ]),
                        ),
                      ),
                    ),

                    // when the _loadMore function is running
                    if (_isLoadMoreRunning == true)
                      const Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 40),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),

                    // When nothing else to load
                    if (_hasNextPage == false)
                      Container(
                        padding: const EdgeInsets.only(top: 30, bottom: 40),
                        color: Colors.amber,
                        child: const Center(
                          child: Text('You have fetched all of the content'),
                        ),
                      ),
                  ],
                ),
              );
    // );
  }
}
