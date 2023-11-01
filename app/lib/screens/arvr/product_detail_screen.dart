import 'package:flutter/material.dart';
import 'package:flutter_hackathon/models/product_model.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductModel product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    ProductModel prod = widget.product;

    return Scaffold(
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
                    backgroundColor: Colors.grey,
                    src: prod.modelUrl ?? '', // a bundled asset file
                    ar: true,
                    arPlacement: ArPlacement.floor,
                    arModes: ['scene-viewer', 'webxr', 'quick-look'],
                    autoRotate: true,
                    cameraControls: true,
                  ),
                  // ModelView(url: product.prodModelUrl.value),
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
                    color: Colors.black12,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0)),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${prod.name}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, left: 20.0, right: 20.0, bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              'Desciption:',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.32,
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
                    ],
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
