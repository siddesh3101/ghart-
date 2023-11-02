import 'dart:collection';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hackathon/constants/colors.dart';
import 'package:flutter_hackathon/screens/arvr/agent/map_screen.dart';
import 'package:flutter_hackathon/screens/arvr/agent/providers/location_provider.dart';
import 'package:flutter_hackathon/screens/arvr/agent/services/create_ad.dart';

import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:provider/provider.dart';

class RoomAds extends StatefulWidget {
  const RoomAds({super.key});

  @override
  State<RoomAds> createState() => _RoomAdsState();
}

class _RoomAdsState extends State<RoomAds> {
  List<int> selectedBedrooms = [];
  firebase_storage.UploadTask? uploadTask;
  final List<int> bedroomOptions = [1, 2, 3, 4, 5];
  var selectedBedroom = 1;
  var _locationController = TextEditingController();
  TimeOfDay _timeOfDay = TimeOfDay(hour: 8, minute: 30);
  var _rentController = TextEditingController();
  var _numberController = TextEditingController(text: "+91 9004137508");
  var _descriptionController = TextEditingController();
  var _name = TextEditingController();
  var _address = TextEditingController();
  var _area = TextEditingController();
  var _vastu = TextEditingController();
  late TimeOfDay time;
  PlatformFile? demo;
  PlatformFile? demo1;
  late List<Item> itemList;
  late List<Item> selectedList;
  PlatformFile? demo2;
  DateTime selectedDate = DateTime.now();
  int currentindex = 0;
  int currentCategory = 0;
  int currentType = 0;
  int currentindexOptions = 0;
  int currentindexGrid = -1;
  late String data;
  List occupancy = ['Single', 'Shared', 'Any'];
  List category = ['Apartment', 'Commercial', 'Duplex'];
  List type = ['Rental', 'Sale'];
  List gender = ['Male', 'Female', 'Any'];
  List options = ['Show', 'Hide'];

  Future onPickImageButtonClicked() async {
    final tempImage = await FilePicker.platform.pickFiles();
    if (tempImage == null) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('An error occurred. Failed to pick image!'),
      ));
      return;
    }

    setState(() {
      demo = tempImage.files.first;
    });
  }

  Future<String> upload() async {
    final path = 'files/${demo!.name}';
    final file = File(demo!.path!);
    final ref = firebase_storage.FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);
    final snapshot = await uploadTask!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    return urlDownload;
  }

  Future<String> upload1() async {
    final path = 'files/${demo1!.name}';
    final file = File(demo1!.path!);
    final ref = firebase_storage.FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);
    final snapshot = await uploadTask!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    return urlDownload;
  }

  Future<String> upload2() async {
    final path = 'files/${demo2!.name}';
    final file = File(demo2!.path!);
    final ref = firebase_storage.FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);
    final snapshot = await uploadTask!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    return urlDownload;
  }

  void _showTimePicker() {
    showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((value) {
      setState(() {
        _timeOfDay = value!;
        data =
            "${selectedDate.toString().split(" ")[0]} ${_timeOfDay.format(context).toString()}:00";
      });
    });
  }

  void onPickImageButtonClicked1() async {
    final tempImage = await FilePicker.platform.pickFiles();
    if (tempImage == null) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('An error occurred. Failed to pick image!'),
      ));
      return;
    }

    setState(() {
      demo1 = tempImage.files.first;
    });
  }

  void onPickImageButtonClicked2() async {
    final tempImage = await FilePicker.platform.pickFiles();
    if (tempImage == null) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('An error occurred. Failed to pick image!'),
      ));
      return;
    }

    setState(() {
      demo2 = tempImage.files.first;
    });
  }

  Widget _buildChip(String label, Color color) {
    return Chip(
      labelPadding: EdgeInsets.all(2.0),
      label: Text(
        label,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: color,
      elevation: 6.0,
      shadowColor: Colors.grey[60],
      padding: EdgeInsets.all(8.0),
    );
  }

  chipList() {
    return Wrap(
      spacing: 6.0,
      runSpacing: 6.0,
      children: <Widget>[
        _buildChip('1', Color(0xFFff6666)),
        _buildChip('2', Color(0xFF007f5c)),
        _buildChip('3', Color(0xFF5f65d3)),
        _buildChip('4', Color(0xFF19ca21)),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    time = TimeOfDay.now();
    loadList();
  }

// List ammenities = [
//     'Tv',
//     'Fridge',
//     'Kitchen',
//     'Wifi',
//     'Machine',
//     'AC',
//     'Backup',
//     'Cook',
//     'Parking'
//   ];
  loadList() {
    itemList = [];
    selectedList = [];
    itemList.add(Item("assets/apna/television.png", 1, 'Tv'));
    itemList.add(Item("assets/apna/fridge.png", 2, 'Fridge'));
    itemList.add(Item("assets/apna/kitchen.png", 3, 'Kitchen'));
    itemList.add(Item("assets/apna/wifi.png", 4, 'Wifi'));
    itemList.add(Item("assets/apna/washingmachine.png", 5, 'Machine'));
    itemList.add(Item("assets/apna/airconditioner.png", 6, 'AC'));
    itemList.add(Item("assets/apna/thunderbolt.png", 7, 'Backup'));
    itemList.add(Item("assets/apna/placeholder.png", 8, 'Cook'));
    itemList.add(Item("assets/apna/cooking.png", 9, 'Parking'));
  }

  @override
  Widget build(BuildContext context) {
    final locationData = Provider.of<LocationProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
              child: Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AiQrDataWidget(
                  title: 'Building name',
                  hint: 'Sonam Paradise',
                  onSubmit: (p0) {
                    _name.text = p0;
                  },
                  isIntro: true,
                ),
                SizedBox(
                  height: 15,
                ),
                AiQrDataWidget(
                  title: 'Address',
                  hint: '18/404 sonam paradise old golden nest..',
                  onSubmit: (p0) {
                    _address.text = p0;
                  },
                  isIntro: true,
                ),
                SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(MyColors.primaryColor),
                    ),
                    onPressed: () async {
                      await locationData.getCurrentPosition();
                      if (locationData.permissionAllowed == true) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MapScreen(),
                            )).then((value) {
                          setState(() {});
                        });
                      } else {
                        print("Permission Denied");
                      }
                    },
                    child: Consumer<LocationProvider>(
                      builder: (context, cart, child) {
                        if (cart.longitude == null) {
                          return Text('Set Location');
                        }
                        return Text(
                            'Lat: ${cart.latitude!.round()} Long: ${cart.longitude!.round()}');
                      },
                    )),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Bedrooms',
                  style: TextStyle(
                    fontSize: 17,
                    color: MyColors.primaryColor,
                  ),
                ),
                Wrap(
                  spacing: 8.0,
                  children: bedroomOptions.map((bedrooms) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedBedroom = bedrooms;
                        });
                      },
                      child: Chip(
                        label: Text('$bedrooms Bedroom'),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: 10,
                ),
                AiQrDataWidget(
                  title: 'Area in square ft',
                  hint: '565 sq ft',
                  onSubmit: (p0) {
                    _area.text = p0;
                  },
                  isIntro: true,
                ),
                SizedBox(
                  height: 15,
                ),

                Text(
                  'Category',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              currentCategory = index;
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            // width: 80,
                            // height: 20,
                            decoration: BoxDecoration(
                                color: currentCategory == index
                                    ? MyColors.primaryColor
                                    : Colors.white10,
                                border: currentCategory == index
                                    ? null
                                    : Border.all(width: 1),
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                "${category[index]}",
                                style: TextStyle(
                                    color: currentCategory == index
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: category.length,
                  ),
                ),

                const SizedBox(
                  height: 15,
                ),
                AiQrDataWidget(
                  title: 'Vastu',
                  hint: 'eg North Facing',
                  onSubmit: (p0) {
                    _vastu.text = p0;
                  },
                  isIntro: true,
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  'Status',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),

                SizedBox(
                  height: 60,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: houses.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Checkbox(
                            activeColor: MyColors.primaryColor,
                            checkColor: MyColors.white,
                            value: houses[index].active,
                            onChanged: (value) {
                              setState(() {
                                setState(() {
                                  houses[index].active = value!;
                                });
                              });
                            },
                          ),
                          Text('${houses[index].name}')
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                Text(
                  'Type',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              currentType = index;
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            // width: 80,
                            // height: 20,
                            decoration: BoxDecoration(
                                color: currentType == index
                                    ? MyColors.primaryColor
                                    : Colors.white10,
                                border: currentType == index
                                    ? null
                                    : Border.all(width: 1),
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                "${type[index]}",
                                style: TextStyle(
                                    color: currentType == index
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: type.length,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.currency_rupee),
                      labelText: 'Cost of the flat'),
                  autofocus: false,
                  maxLength: 10,
                  controller: _rentController,
                  // keyboardType: TextInputType.phone,
                  onChanged: (value) {
                    if (value.length == 10) {
                      //   setState(
                      //     () {
                      //       _validPhoneNumber = true;
                      //     },
                      //   );
                      // } else {
                      //   setState(
                      //     () {
                      //       _validPhoneNumber = false;
                      //     },
                      //   );
                      // }}
                    }
                  },
                ),
                const Text(
                  "Add Photo (Upload all 3 photos)",
                  style: TextStyle(fontSize: 17, color: MyColors.primaryColor),
                ),
                const SizedBox(
                  height: 10,
                ),
                // (demo != null)
                //     ? DottedBorder(
                //         child: Image.file(
                //           demo!.absolute,
                //           height: 250,
                //           width: 250,
                //           scale: 2,
                //           fit: BoxFit.fill,
                //         ),
                //       )
                //     : DottedBorder(
                //         child: MaterialButton(
                //           onPressed: () async {
                //             // if (kIsWeb) {
                //             //   startweb();
                //             // } else {
                //             onPickImageButtonClicked();
                //           },
                //           child: const Icon(Icons.image),
                //         ),
                //       ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    (demo != null)
                        ? DottedBorder(
                            child: Image.file(
                              File(demo!.path!),
                              height: 220,
                              width: 200,
                              // scale: 2,
                              fit: BoxFit.fill,
                            ),
                          )
                        : DottedBorder(
                            child: MaterialButton(
                              onPressed: () async {
                                // if (kIsWeb) {
                                //   startweb();
                                // } else {
                                onPickImageButtonClicked();
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Image.asset(
                                  "assets/apna/flat.png",
                                  width: 170,
                                  height: 190,
                                  color: Colors.black.withOpacity(0.4),
                                ),
                              ),
                            ),
                          ),
                    const SizedBox(
                      width: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        (demo1 != null)
                            ? DottedBorder(
                                child: Image.file(
                                  File(demo1!.path!),
                                  height: 120,
                                  width: 150,
                                  // scale: 2,
                                  fit: BoxFit.fill,
                                ),
                              )
                            : DottedBorder(
                                child: MaterialButton(
                                  onPressed: () async {
                                    // if (kIsWeb) {
                                    //   startweb();
                                    // } else {
                                    onPickImageButtonClicked1();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Image.asset(
                                      "assets/apna/flat.png",
                                      width: 100,
                                      height: 100,
                                      color: Colors.black.withOpacity(0.4),
                                    ),
                                  ),
                                ),
                              ),
                        const SizedBox(
                          height: 5,
                        ),
                        (demo2 != null)
                            ? DottedBorder(
                                child: Image.file(
                                  File(demo2!.path!),
                                  height: 92,
                                  width: 150,
                                  // scale: 2,
                                  fit: BoxFit.fill,
                                ),
                              )
                            : DottedBorder(
                                child: MaterialButton(
                                  onPressed: () async {
                                    // if (kIsWeb) {
                                    //   startweb();
                                    // } else {
                                    onPickImageButtonClicked2();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Image.asset(
                                      "assets/apna/flat.png",
                                      width: 100,
                                      height: 87,
                                      color: Colors.black.withOpacity(0.4),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),

                AiQrDataWidget(
                    maxLines: 3,
                    hint:
                        'A very lucky house facing the sea side in marin drives.....',
                    onSubmit: (p0) {
                      _descriptionController.text = p0;
                    },
                    isIntro: true,
                    title: 'Description'),
                // SizedBox(
                //   height: 10,
                // ),

                // AiQrDataWidget(
                //     hint: 'Please write valid matterport link',
                //     onSubmit: (p0) {},
                //     isIntro: true,
                //     title: 'Matterport Link'),

                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Available From",
                  style: TextStyle(fontSize: 17, color: MyColors.primaryColor),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(MediaQuery.of(context).size.width, 50),
                      maximumSize: Size(MediaQuery.of(context).size.width, 50),
                      backgroundColor: Colors.white),
                  onPressed: () async {
                    final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime(2015, 8),
                        lastDate: DateTime(2101));
                    if (picked != null && picked != selectedDate) {
                      // setModalState(() {
                      //   selectedDate = picked;
                      // });
                      setState(() {
                        selectedDate = picked;
                        // optionsmap["date"] =
                        //     ;
                      });
                    }
                  },
                  child: Text(
                    selectedDate.toString().split(" ")[0],
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Ammenities",
                  style: TextStyle(fontSize: 17, color: MyColors.primaryColor),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 150,
                  width: double.infinity,
                  child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: itemList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisExtent: 100,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5),
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(width: 1),
                              borderRadius: BorderRadius.circular(5)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 30,
                                height: 30,
                                child: GridItem(
                                    item: itemList[index],
                                    isSelected: (bool value) {
                                      setState(() {
                                        if (value) {
                                          selectedList.add(itemList[index]);
                                        } else {
                                          selectedList.remove(itemList[index]);
                                        }
                                      });
                                      // print("$index : $value");
                                    },
                                    key: Key(itemList[index].rank.toString())),
                              ),
                              Text("${itemList[index].ammenity}")
                            ],
                          ),
                        );
                      }),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Contact Number",
                  style: TextStyle(fontSize: 17, color: MyColors.primaryColor),
                ),
                TextField(
                  controller: _numberController,
                  enabled: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Show - Users can call and chat you.",
                  style: TextStyle(fontSize: 17, color: MyColors.primaryColor),
                ),
                const Text(
                  "Hide - Users can only chat with you.",
                  style: TextStyle(fontSize: 17, color: MyColors.primaryColor),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: double.infinity,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              currentindexOptions = index;
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: 100,
                            height: 20,
                            decoration: BoxDecoration(
                                color: currentindexOptions == index
                                    ? MyColors.primaryColor
                                    : Colors.white10,
                                border: currentindexOptions == index
                                    ? null
                                    : Border.all(width: 1),
                                borderRadius: BorderRadius.circular(15)),
                            child: Text(
                              "${options[index]}",
                              style: TextStyle(
                                  color: currentindexOptions == index
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: options.length,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),

                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      backgroundColor: MyColors.primaryColor,
                    ),
                    onPressed: () async {
                      // String location = _locationController.text;
                      // String cost = _rentController.text;
                      // String contact = _numberController.text;
                      // String description = _descriptionController.text;
                      // File img1 = demo!.absolute;
                      // File img2 = demo1!.absolute;
                      // File img3 = demo2!.absolute;
                      // DateTime date = selectedDate;

                      // log(ref1.toString());
                      // final ref2 = firebase_storage.FirebaseStorage.instance
                      //     .ref();
                      // final ref3 = firebase_storage.FirebaseStorage.instance
                      //     .ref();

                      // final hi = await ref1.getDownloadURL();
                      // log(hi);
                      try {
                        // log(file1.toString());
                        // final file2 = ref1.putFile(img2);
                        // final file3 = ref1.putFile(img3);

                        final PropertyPayload payload = PropertyPayload(
                          name: _name.text,
                          address: _address.text,
                          bedroom: selectedBedroom.toString(),
                          bathroom: '2',
                          squareArea: _area.text,
                          category: currentCategory == 0
                              ? 'Apartment'
                              : currentCategory == 1
                                  ? 'Commercial'
                                  : 'Duplex',
                          vastu: _vastu.text,
                          status: 'Active',
                          type: currentType == 0 ? 'Rental' : 'Sale',
                          price: '500000',
                          description: 'A beautiful property',
                          images: [
                            await upload() ?? '',
                            await upload1() ?? '',
                            await upload2() ?? '',
                          ],
                          matterPortLink: 'matterport.com/link',
                          latitude: locationData.latitude.toString(),
                          longitude: locationData.longitude.toString(),
                          amenities:
                              selectedList.map((e) => e.ammenity).toList(),
                          sellerName: 'Siddesh Shetty',
                          sellerNumber: '+919004137508',
                          sellerPic: 'seller.jpg',
                        );

                        await CreateAd().createPet(payload);

                        // await FirebaseFirestore.instance
                        //     .collection(FirebaseCollectionName.flatmateSearch)
                        //     .add(
                        //       payload,
                        //     );

                        // locationData.changeAdStatus(true);
                        // Navigator.push(
                        //   context,
                        //   // PageTransition(
                        //   //   child: const PreferencesScreen(),
                        //   //   type: PageTransitionType.fade,
                        //   // ),
                        // );
                      } catch (e) {
                        print('error' + e.toString());
                      }

                      // onNextButtonClicked();
                      // context.pushNamed("confirmOrder");
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        'Submit',
                        style: TextStyle(letterSpacing: 2, fontSize: 25),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}

class Item {
  String imageUrl;
  int rank;
  String ammenity;

  Item(
    this.imageUrl,
    this.rank,
    this.ammenity,
  );
}

class GridItem extends StatefulWidget {
  final Key key;
  final Item item;
  final ValueChanged<bool> isSelected;

  const GridItem(
      {required this.item, required this.isSelected, required this.key});

  @override
  _GridItemState createState() => _GridItemState();
}

class _GridItemState extends State<GridItem> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
          widget.isSelected(isSelected);
        });
      },
      child: Stack(
        children: <Widget>[
          Image.asset(
            widget.item.imageUrl,
            color: Colors.black.withOpacity(isSelected ? 0.9 : 0),
            colorBlendMode: BlendMode.color,
          ),
          isSelected
              ? const Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.check_circle,
                      color: Colors.blue,
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}

@immutable
class FirebaseCollectionName {
  static const posts = 'posts';
  static const users = 'users';
  static const flatSearch = 'flat_search';
  static const flatmateSearch = 'flatmate_search';

  const FirebaseCollectionName._();
}

@immutable
class FlatmatePayload extends MapView<String, dynamic> {
  final UserId userId;
  final String displayName;
  final String userDPURL;
  final String location;
  final DateTime availableFrom;
  final String cost;
  final String fileUrl1;
  final String fileUrl2;
  final String fileUrl3;
  final String contact;
  final String description;
  final String occupancy;

  FlatmatePayload({
    required this.displayName,
    required this.userDPURL,
    required this.userId,
    required this.location,
    required this.availableFrom,
    required this.cost,
    required this.fileUrl1,
    required this.fileUrl2,
    required this.fileUrl3,
    required this.contact,
    required this.description,
    required this.occupancy,
  }) : super({
          FirebaseFieldName.userId: userId,
          FirebaseFieldName.location: location,
          FirebaseFieldName.availableFrom: availableFrom,
          FirebaseFieldName.cost: cost,
          FirebaseFieldName.fileUrl1: fileUrl1,
          FirebaseFieldName.fileUrl2: fileUrl2,
          FirebaseFieldName.fileUrl3: fileUrl3,
          FirebaseFieldName.contact: contact,
          FirebaseFieldName.description: description,
          FirebaseFieldName.displayName: displayName,
          FirebaseFieldName.userDPUrl: userDPURL,
          FirebaseFieldName.occupancy: occupancy,
        });
}

@immutable
class FirebaseFieldName {
  static const userId = 'uid';
  static const postId = 'post_id';
  static const displayName = 'display_name';
  static const email = 'email';
  static const gender = 'gender';
  static const location = 'location';
  static const lat = 'lat';
  static const long = 'long';
  static const contact = 'contact';
  static const cost = 'cost';
  static const budget = 'budget';
  static const availableFrom = 'available_from';
  static const fileUrl1 = 'file_url1';
  static const fileUrl2 = 'file_url2';
  static const fileUrl3 = 'file_url3';
  static const amenities = 'amenities';
  static const description = 'description';
  static const userDPUrl = 'userDPUrl';
  static const occupancy = 'occupancy';

  const FirebaseFieldName._();
}

typedef UserId = String;

class AiQrDataWidget extends StatefulWidget {
  const AiQrDataWidget({
    required this.hint,
    required this.onSubmit,
    required this.isIntro,
    super.key,
    this.onChanged,
    required this.title,
    this.maxLines = 1,
  });

  final Function(String)? onSubmit;
  final Function(String)? onChanged;
  final String hint;
  final String title;
  final bool isIntro;
  final int maxLines;

  @override
  State<AiQrDataWidget> createState() => AiQrDataWidgetState();
}

class AiQrDataWidgetState extends State<AiQrDataWidget> {
  final border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
  );

  final errorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: const BorderSide(color: Colors.red),
  );

  final _qrDataController = TextEditingController();
  String get text => _qrDataController.text;
  @override
  void initState() {
    super.initState();
    _qrDataController.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _qrDataController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(
            fontSize: 17,
            color: MyColors.primaryColor,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          maxLines: widget.maxLines,
          onChanged: (text) {
            if (text.isNotEmpty) widget.onChanged!(text);
          },
          onFieldSubmitted: (text) {
            if (text.isNotEmpty) widget.onSubmit!(text);
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: _qrDataController,
          decoration: InputDecoration(
            enabledBorder: border,
            hintText: widget.hint,
            hintStyle: TextStyle(
                color: Color.fromARGB(255, 175, 168, 251).withOpacity(0.8)),
            border: border,
            focusedBorder: border,
            errorBorder: errorBorder,
            focusedErrorBorder: errorBorder,
          ),
        ),
      ],
    );
  }
}

List<House> houses = [
  House("Active", true, false, false),
  House("Inactive", false, true, false),
  House("Sold", false, false, true),
];

class House {
  final String name;
  bool active;
  bool sold;
  bool inactive;

  House(this.name, this.active, this.sold, this.inactive);
}

@immutable
class PropertyPayload extends MapView<String, dynamic> {
  final String name;
  final String address;
  final String bedroom;
  final String bathroom;
  final String squareArea;
  final String category;
  final String vastu;
  final String status;
  final String type;
  final String price;
  final String description;
  final List<String> images;
  final String matterPortLink;
  final String latitude;
  final String longitude;
  final List<String> amenities;
  final String sellerName;
  final String sellerNumber;
  final String sellerPic;

  PropertyPayload({
    required this.name,
    required this.address,
    required this.bedroom,
    required this.bathroom,
    required this.squareArea,
    required this.category,
    required this.vastu,
    required this.status,
    required this.type,
    required this.price,
    required this.description,
    required this.images,
    required this.matterPortLink,
    required this.latitude,
    required this.longitude,
    required this.amenities,
    required this.sellerName,
    required this.sellerNumber,
    required this.sellerPic,
  }) : super({
          FirebaseField.name: name,
          FirebaseField.address: address,
          FirebaseField.bedroom: bedroom,
          FirebaseField.bathroom: bathroom,
          FirebaseField.squareArea: squareArea,
          FirebaseField.category: category,
          FirebaseField.vastu: vastu,
          FirebaseField.status: status,
          FirebaseField.type: type,
          FirebaseField.price: price,
          FirebaseField.description: description,
          FirebaseField.images: images,
          FirebaseField.matterPortLink: matterPortLink,
          FirebaseField.latitude: latitude,
          FirebaseField.longitude: longitude,
          FirebaseField.amenities: amenities,
          FirebaseField.sellerName: sellerName,
          FirebaseField.sellerNumber: sellerNumber,
          FirebaseField.sellerPic: sellerPic,
        });
}

@immutable
class FirebaseField {
  static const name = 'name';
  static const address = 'address';
  static const bedroom = 'bedroom';
  static const bathroom = 'bathroom';
  static const squareArea = 'squareArea';
  static const category = 'category';
  static const vastu = 'vastu';
  static const status = 'status';
  static const type = 'type';
  static const price = 'price';
  static const description = 'description';
  static const images = 'images';
  static const matterPortLink = 'matterPortLink';
  static const latitude = 'latitude';
  static const longitude = 'longitude';
  static const amenities = 'amenities';
  static const sellerName = 'sellerName';
  static const sellerNumber = 'sellerNumber';
  static const sellerPic = 'sellerPic';

  const FirebaseField._();
}
