import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:panorama/panorama.dart';

class PanoramaPage extends StatefulWidget {
  const PanoramaPage({super.key, required this.images, required this.labels});
  final List<String> images;
  final List<String> labels;

  @override
  State<PanoramaPage> createState() => _PanoramaPageState();
}

class _PanoramaPageState extends State<PanoramaPage> {
  int _selectedImage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Panorama(
            animSpeed: 1.0,
            sensorControl: SensorControl.Orientation,
            child: Image.network(
              widget.images[_selectedImage],
            )),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
              width: double.infinity,
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: 24,
                      color: _selectedImage > 0
                          ? Colors.white
                          : Colors.transparent,
                    ),
                    onPressed: () {
                      if (_selectedImage > 0)
                        setState(() {
                          _selectedImage--;
                        });
                    },
                  ),
                  Text(
                    widget.labels[_selectedImage],
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      size: 24,
                      color: _selectedImage < widget.images.length - 1
                          ? Colors.white
                          : Colors.transparent,
                    ),
                    onPressed: () {
                      if (_selectedImage < widget.images.length - 1)
                        setState(() {
                          _selectedImage++;
                        });
                    },
                  )
                ],
              )),
        ),
        Positioned(
          top: 30,
          left: 10,
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: 24,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        )
      ],
    ));
  }
}
