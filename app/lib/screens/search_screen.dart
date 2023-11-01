import 'package:flutter/material.dart';
import 'package:flutter_hackathon/constants/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../services/get_events.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<dynamic> events = [];
  bool loading = true;

  void fetchSearchData(String q) async {
    try {
      // Replace EventsService().getItinerary() with your data fetching logic here
      final data = await EventsService().getSearch(q);
      print(data);

      setState(() {
        events = data;
        loading = false;
      });
    } catch (error) {
      throw error;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchSearchData('');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        title: Text(
          'Search',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SvgPicture.asset('assets/images/search.svg',
                    height: 30, width: 30),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: TextField(
                  onChanged: (value) {
                    fetchSearchData(value);
                  },
                  decoration: InputDecoration(
                      hintText: 'Search', border: InputBorder.none),
                )),
                SvgPicture.asset('assets/images/filter.svg',
                    height: 32, width: 25)
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: loading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount: events.length,
                      itemBuilder: (context, index) {
                        return SearchItem(
                          date: events[index]['date'],
                          title: events[index]['eventName'],
                          image: events[index]['img'],
                          chip: events[index]['category'],
                          onTap: () {
                            // Navigator.pushNamed(context, '/event',
                            //     arguments: events[index]);
                          },
                        );
                      },
                    ),
            )
          ],
        ),
      ),
    ));
  }
}

class SearchItem extends StatelessWidget {
  final String date;
  final String title;
  final String image;
  final Function onTap;
  final String chip;
  const SearchItem(
      {super.key,
      required this.date,
      required this.title,
      required this.image,
      required this.onTap,
      required this.chip});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(0, 5), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(image, height: 110, width: 110)),
              SizedBox(
                width: 15,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                        color: MyColors.primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      chip,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    date,
                    style: TextStyle(
                        color: MyColors.primaryColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              )),
              SizedBox(
                width: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
