import 'package:flutter/material.dart';
import 'package:flutter_hackathon/models/product_model.dart';
import 'package:flutter_hackathon/screens/web_screen.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:android_intent_plus/android_intent.dart' as android_content;
import 'package:android_intent_plus/flag.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductModel product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  void launchIntent(String fileURL) async {
    print('fileURL: ' + fileURL);
    final intent = android_content.AndroidIntent(
      action: 'android.intent.action.VIEW',
      // Intent.ACTION_VIEW
      // See https://developers.google.com/ar/develop/scene-viewer#3d-or-ar
      // data should be something like "https://arvr.google.com/scene-viewer/1.0?file=https://raw.githubusercontent.com/KhronosGroup/glTF-Sample-Models/master/2.0/Avocado/glTF/Avocado.gltf"
      data: Uri(
        scheme: 'https',
        host: 'arvr.google.com',
        path: '/scene-viewer/1.0',
        queryParameters: {
          'mode': 'ar_only',
          'file': fileURL,
        },
      ).toString(),
      // package changed to com.google.android.googlequicksearchbox
      // to support the widest possible range of devices
      package: 'com.google.ar.core',
      arguments: <String, dynamic>{
        'browser_fallback_url':
            'market://details?id=com.google.android.googlequicksearchbox',
      },
    );
    await intent.launch().onError((error, stackTrace) {
      debugPrint('ModelViewer Intent Error: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    ProductModel prod = widget.product;

    return Scaffold(
      backgroundColor: Colors.blue.shade200,
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.41,
                child: Stack(alignment: Alignment.topRight, children: [
                  ModelViewer(
                    // backgroundColor: Get.isDarkMode?Colors.:Colors.white12,
                    backgroundColor: Colors.blue.shade200,
                    loading: Loading.lazy,
                    src: prod.modelUrl ?? '', // a bundled asset file
                    ar: true,
                    arPlacement: ArPlacement.floor,
                    arModes: ['scene-viewer', 'webxr'],
                    autoRotate: true,
                    cameraControls: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(Icons.arrow_back_ios)),
                      ],
                    ),
                  )
                ]),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 40.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${prod.name}',
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              RatingBarIndicator(
                                itemSize: 24,
                                rating: double.parse(prod.rating.toString()),
                                itemBuilder: (ctx, idx) => Icon(
                                  Icons.star,
                                  size: 20,
                                  color: Colors.amber,
                                ),
                                unratedColor: Colors.grey.shade300,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 25.0, bottom: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                'Desciption:',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.blue),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.32,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Text(prod.description.toString()),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Container(
                              height: 50,
                              child: ElevatedButton(
                                  onPressed: () async {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => WebViewExample(
                                            url:
                                                'https://www.google.com/searchbyimage?image_url=${prod.imageUrl}&client=app')));
                                  },
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      backgroundColor: Colors.amber.shade100,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.shopping_cart_outlined,
                                          size: 18,
                                          color: Colors.amber.shade700),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Text(
                                        'Buy Now',
                                        style: TextStyle(
                                            color: Color(0xFFFFC107),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  )),
                            )),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: Container(
                              height: 50,
                              child: ElevatedButton(
                                  onPressed: () async {
                                    launchIntent(prod.modelUrl.toString());
                                  },
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      backgroundColor: Colors.blue.shade100,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/ar.svg',
                                        height: 22,
                                        color: Colors.blue.shade700,
                                        width: 22,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Text(
                                        'AR View',
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  )),
                            )),
                          ],
                        )
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
