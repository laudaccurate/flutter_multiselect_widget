import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class MultiSelect extends StatefulWidget {
  final String description;
  // final value;
  final List<String> items;

  const MultiSelect({Key key, this.description, this.items}) : super(key: key);
  @override
  MultiSelectState createState() => MultiSelectState();
}

class MultiSelectState extends State<MultiSelect> {
  double _screenHeight;
  double _screenWidth;
  var selectedItems = new Set<String>();
  String searchTerm;
  TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    _screenHeight = MediaQuery.of(context).size.height;
    _screenWidth = MediaQuery.of(context).size.width;

    if (widget.items != null && widget.items.isNotEmpty) {
      return Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${widget.description} : " ?? "MultiSelect",
            // textAlign: TextAlign.left,
            style: TextStyle(fontSize: 17.0, color: Colors.grey[700]),
          ),
          SizedBox(height: _screenHeight * 0.01),
          Wrap(
            children:
                selectedItems.toList().map((e) => selectedItemChip(e)).toList(),
            direction: Axis.horizontal,
            spacing: _screenWidth * 0.02,
            runSpacing: _screenHeight * 0.008,
          ),
          SizedBox(height: _screenHeight * 0.015),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return StatefulBuilder(
                      builder: (context, setState) {
                        return SimpleDialog(
                          title: Text(
                            widget.description ?? "Select Options",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600),
                          ),
                          titlePadding: EdgeInsets.symmetric(vertical: 20.0),
                          contentPadding: EdgeInsets.all(10.0),
                          children: [
                            SizedBox(height: _screenHeight * 0.01),
                            searchBar(),
                            SizedBox(height: _screenHeight * 0.01),
                            Divider(
                              color: Colors.grey[300],
                              thickness: 1.0,
                              height: 5.0,
                            ),
                            SizedBox(height: _screenHeight * 0.015),
                            Column(
                              children: widget.items
                                  .map(
                                    (e) => Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () {
                                          setState(
                                            () {
                                              selectedItems.contains(e)
                                                  ? selectedItems.remove(e)
                                                  : selectedItems.add(e);
                                            },
                                          );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                e,
                                                style: TextStyle(
                                                  color: Colors.grey[700],
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 20.0,
                                                ),
                                              ),
                                              selectedItems.contains(e)
                                                  ? Icon(
                                                      CupertinoIcons.check_mark,
                                                      color: Colors.green[300],
                                                    )
                                                  : Text(''),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                            SizedBox(height: _screenHeight * 0.07),
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Container(
                                alignment: Alignment.bottomRight,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 20.0),
                                child: Text(
                                  'Close',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey[800],
                                  ),
                                ),
                              ),
                            ),
                            // SizedBox(height: _screenHeight * 0.02),
                          ],
                        );
                      },
                    );
                  },
                );
              },
              child: Container(
                width: _screenWidth * 0.95,
                height: _screenHeight * 0.04,
                // color: Colors.blue,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Select ${widget.description}',
                              style: TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey[700],
                              )),
                          SizedBox(width: _screenWidth * 0.2),
                          Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                    // SizedBox(width: _screenHeight * 0.015),
                    Container(
                      height: 1.5,
                      color: Colors.grey[400],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return Container();
    }
  }

  Widget searchBar() {
    return Container(
      padding: EdgeInsets.only(left: 15.0, right: 6.5, top: 2.5, bottom: 2.5),
      width: _screenWidth * 0.88,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.all(
          Radius.circular(35.0),
        ),
      ),
      child: TextField(
        controller: searchController,
        keyboardType: TextInputType.text,
        style: TextStyle(fontSize: 18.0),
        onChanged: (value) {
          setState(() {
            searchTerm = searchController.text;
          });
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Search .....",
          hintStyle: TextStyle(color: Colors.grey[400]),
          suffixIcon: Icon(CupertinoIcons.search),
        ),
      ),
    );
  }

  Widget selectedItemChip(item) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.5),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.all(
          Radius.circular(25.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            item.toString(),
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 17.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(width: _screenWidth * 0.02),
          GestureDetector(
            onTap: () {
              setState(() {
                selectedItems.remove(item);
              });
            },
            child: Icon(
              CupertinoIcons.multiply_circle_fill,
              color: Colors.grey[700],
            ),
          )
        ],
      ),
    );
  }
}
