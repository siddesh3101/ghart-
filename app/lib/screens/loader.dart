import 'package:flutter/material.dart';

class AppLoader {
  static var _isLoaderShowing = false;

  static void showLoader(BuildContext context,
      {bool barrierDismissible = false}) {
    if (!_isLoaderShowing) {
      showDialog(
        context: context,
        builder: (context) => WillPopScope(
          onWillPop: () => Future.value(barrierDismissible),
          child: const Center(child: AppProgressIndicator()),
        ),
      );
      _isLoaderShowing = true;
    }
  }

  static void hideLoader(BuildContext context) {
    if (_isLoaderShowing) {
      Navigator.pop(context);
      _isLoaderShowing = false;
    }
  }
}

class AppProgressIndicator extends StatelessWidget {
  final Color? colour;

  const AppProgressIndicator({
    Key? key,
    this.colour,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: CircularProgressIndicator(color: colour),
      ),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
