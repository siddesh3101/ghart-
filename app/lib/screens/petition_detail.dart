import 'package:flutter/material.dart';

import '../constants.dart';
import '../constants/colors.dart';

class PetitionDetail extends StatefulWidget {
  final dynamic data;
  const PetitionDetail({super.key, required this.data});

  @override
  State<PetitionDetail> createState() => _PetitionDetailState();
}

class _PetitionDetailState extends State<PetitionDetail> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            // backgroundColor: MyColors.offWhite,
            body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          topBar(context, widget.data['img']),

          Padding(
            padding: const EdgeInsets.only(
              left: kDefaultPadding,
            ),
            child: Text(
              widget.data['name'],
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: LinearProgressIndicator(
              value: widget.data['count'] / double.parse(widget.data['target']),
              backgroundColor: Colors.grey.withOpacity(0.3),
              minHeight: 10,
              borderRadius: BorderRadius.circular(20),
              color: MyColors.primaryColor,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(
                    (widget.data['count'] >= int.parse(widget.data['target']))
                        ? 'Completed'
                        : widget.data['count'].toString() +
                            ' of ' +
                            widget.data['target'] +
                            ' signed',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Colors.black.withOpacity(0.3),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    widget.data['img'],
                    height: 60,
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.data['name'],
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        widget.data['cause'],
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: Colors.black.withOpacity(0.3),
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    decoration: BoxDecoration(
                      color: MyColors.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                          Image.asset('assets/images/social.png', height: 40),
                    )),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Social Activity',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 14),
                        ),
                        // Spacer(),
                        // Image.asset(
                        //   'assets/foloow.png',
                        //   width: 70,
                        //   height: 50,
                        // )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),

          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 22),
            child: Text(
              'Sign this petition to support the cause and help the people in need.',
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          // Container(
          //   width: double.infinity,
          //   margin: const EdgeInsets.symmetric(horizontal: 20),
          //   child: Image.asset(
          //     'assets/icons/location.png',
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {},
                    child: Text(
                      'Sign Petition',
                      textAlign: TextAlign.center,
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: MyColors.primaryColor,
                        foregroundColor: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    )));
  }

  Container topBar(BuildContext context, dynamic img) {
    return Container(
      height: 245,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 160,
            decoration: BoxDecoration(
                image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(img),
            )),
          ),
          // back btn
          Positioned(
              top: 15,
              left: 5,
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ))),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Petition Details',
                    style: TextStyle(color: Colors.black, fontSize: 20))
              ],
            ),
          ),
          Positioned(
              top: 115,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 70,
                    margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.1),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/users.png',
                                height: 40,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text('+20 signed already!!',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16)),
                              SizedBox(
                                width: 10,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
