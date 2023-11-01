import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hackathon/constants/colors.dart';
import 'package:flutter_hackathon/screens/main_screen.dart';
import 'package:flutter_hackathon/services/get_events.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class CreatePetition extends StatefulWidget {
  static const nameRoute = '/loginpage';
  const CreatePetition({Key? key}) : super(key: key);

  @override
  State<CreatePetition> createState() => _CreatePetitionState();
}

class _CreatePetitionState extends State<CreatePetition> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _budgetController = TextEditingController();
  final TextEditingController _targetController = TextEditingController();

  bool loading = false;

  @override
  void dispose() {
    _titleController.dispose();
    _budgetController.dispose();
    _targetController.dispose();
    super.dispose();
  }

  String _selectedCategory = 'Social';
  File? image;

  void showNotification(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.redAccent, content: Text(message.toString())));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.white,
          title: Text('Create Petition',
              style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold)),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/searchPet');
              },
              icon: const Icon(
                Icons.search,
                color: Colors.black,
              ),
            )
          ],
        ),
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                // const Upside(
                //   imgUrl: "assets/event.png",
                // ),
                const PageTitleBar(title: 'Fill the form to create petition'),
                Padding(
                  padding: const EdgeInsets.only(top: 100.0),
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFieldContainer(
                                child: TextFormField(
                                  controller: _titleController,
                                  cursorColor: MyColors.primaryColor,
                                  decoration: const InputDecoration(
                                      icon: Icon(
                                        Icons.title,
                                        color: MyColors.primaryColor,
                                      ),
                                      hintText: 'Title',
                                      hintStyle:
                                          TextStyle(fontFamily: 'OpenSans'),
                                      border: InputBorder.none),
                                  validator: Validators.compose([
                                    Validators.required('Title is required'),
                                  ]),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFieldContainer(
                                child: TextFormField(
                                  controller: _budgetController,
                                  cursorColor: MyColors.primaryColor,
                                  decoration: InputDecoration(
                                      icon: const Icon(
                                        Icons.text_fields,
                                        color: MyColors.primaryColor,
                                      ),
                                      hintText: "Cause",
                                      hintStyle: const TextStyle(
                                          fontFamily: 'OpenSans'),
                                      border: InputBorder.none),
                                  validator: Validators.compose([
                                    Validators.required('Cause is required'),
                                  ]),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFieldContainer(
                                child: TextFormField(
                                  controller: _targetController,
                                  keyboardType: TextInputType.number,
                                  cursorColor: MyColors.primaryColor,
                                  decoration: InputDecoration(
                                      icon: const Icon(
                                        Icons.people,
                                        color: MyColors.primaryColor,
                                      ),
                                      hintText: "Target Audience",
                                      hintStyle: const TextStyle(
                                          fontFamily: 'OpenSans'),
                                      border: InputBorder.none),
                                  validator: Validators.compose([
                                    Validators.required(
                                        'Target Audience is required'),
                                  ]),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              // drop down for category
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 50),
                                child: DropdownButtonFormField(
                                  decoration: InputDecoration(
                                      icon: const Icon(
                                        Icons.lock,
                                        color: MyColors.primaryColor,
                                      ),
                                      hintText: "Category",
                                      hintStyle: const TextStyle(
                                          fontFamily: 'OpenSans'),
                                      border: InputBorder.none),
                                  items: const [
                                    DropdownMenuItem(
                                      child: Text("Social"),
                                      value: "Social",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("Rally"),
                                      value: "Rally",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("Conference"),
                                      value: "Conference",
                                    ),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedCategory = value.toString();
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ElevatedButton(
                                  onPressed: () async {
                                    final image = await ImagePicker()
                                        .pickImage(source: ImageSource.gallery);
                                    if (image != null) {
                                      setState(
                                          () => this.image = File(image.path));
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: MyColors.primaryColor),
                                  child: const Text("Upload Image")),
                              const SizedBox(
                                height: 30,
                              ),
                              loading
                                  ? const CircularProgressIndicator()
                                  : RoundedButton(
                                      text: 'Create',
                                      press: () async {
                                        final title = _titleController.text;
                                        final cause = _budgetController.text;
                                        final target = _targetController.text;
                                        final category = _selectedCategory;
                                        if (title.length == 0 ||
                                            cause.length == 0 ||
                                            target.length == 0 ||
                                            category.length == 0 ||
                                            image == null) {
                                          showNotification(context,
                                              'Please fill all the fields');
                                          return;
                                        }
                                        final hash = base64Encode(
                                            File(image!.path)
                                                .readAsBytesSync());

                                        await EventsService()
                                            .createPet(title, cause, category,
                                                target, hash)
                                            .then((value) {
                                          Navigator.pushReplacementNamed(
                                              context, '/searchPet');
                                        });
                                      }),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Upside extends StatelessWidget {
  const Upside({Key? key, required this.imgUrl}) : super(key: key);
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          width: size.width,
          height: size.height / 3,
          alignment: Alignment.center,
          color: Colors.white,
          // decoration: const BoxDecoration(
          //   image: DecorationImage(
          //       image: AssetImage('assets/event.png'), fit: BoxFit.fitHeight),
          // ),
          child: Image.asset(
            'assets/event.png',
            width: 200,
            height: 100,
          ),
        ),
      ],
    );
  }
}

iconBackButton(BuildContext context) {
  return IconButton(
    color: Colors.white,
    iconSize: 28,
    icon: const Icon(CupertinoIcons.arrow_left),
    onPressed: () {
      Navigator.pop(context);
    },
  );
}

class PageTitleBar extends StatelessWidget {
  const PageTitleBar({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 4,
        decoration: BoxDecoration(
          color: MyColors.primaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 20,
                letterSpacing: 1,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class TextFieldContainer extends StatelessWidget {
  const TextFieldContainer({Key? key, this.child}) : super(key: key);
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: const Color(0xfffeeeee4),
        borderRadius: BorderRadius.circular(29),
      ),
      child: child,
    );
  }
}

class RoundedButton extends StatelessWidget {
  const RoundedButton(
      {Key? key, this.press, this.textColor = Colors.white, required this.text})
      : super(key: key);
  final String text;
  final Function()? press;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: newElevatedButton(),
      ),
    );
  }

  Widget newElevatedButton() {
    return ElevatedButton(
      onPressed: press,
      style: ElevatedButton.styleFrom(
          primary: MyColors.primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          textStyle: TextStyle(
              letterSpacing: 2,
              color: textColor,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans')),
      child: Text(
        text,
        style: TextStyle(color: textColor, fontSize: 17),
      ),
    );
  }
}

class UnderPart extends StatelessWidget {
  const UnderPart(
      {Key? key,
      required this.title,
      required this.navigatorText,
      required this.onTap})
      : super(key: key);
  final String title;
  final String navigatorText;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 13,
              color: Colors.grey,
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          width: 20,
        ),
        InkWell(
          onTap: () {
            onTap();
          },
          child: Text(
            navigatorText,
            style: const TextStyle(
                color: MyColors.primaryColor,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                fontFamily: 'Opensans'),
          ),
        )
      ],
    );
  }
}
