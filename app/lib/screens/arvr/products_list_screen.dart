import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_hackathon/models/product_model.dart';
import 'package:flutter_hackathon/screens/arvr/product_detail_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  Stream<List<ProductModel>> getAllProducts() => FirebaseFirestore.instance
      .collection('products')
      .snapshots()
      .map((query) =>
          query.docs.map((item) => ProductModel.fromMap(item)).toList());

  List<ProductModel> prods = [];

  @override
  void initState() {
    super.initState();
    getAllProducts().listen((event) {
      setState(() {
        prods = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Furniture AR Viewer',
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: prods.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      // TODO
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ProductDetailScreen(
                                product: prods[index],
                              )));
                    },
                    child: Card(
                      elevation: 8,
                      shadowColor: Colors.black45,
                      margin: const EdgeInsets.all(6),
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black26)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                height: 110,
                                width: 110,
                                child:
                                    Image.network(prods[index].imageUrl ?? '')
                                // child: ModelViewer(
                                //       src: '${prods[index]['modelUrl']}', // a bundled asset file
                                //
                                //   ),
                                ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${prods[index].name} \n',
                                  style: const TextStyle(fontSize: 16),
                                ),
                                Text(
                                  '',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
