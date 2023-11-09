import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingDataWidget extends StatelessWidget {
  const LoadingDataWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: LoadingWidget(
        text: 'Loading Data...',
        
      ),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
            width: 40, height: 40, child: CircularProgressIndicator()),
        const SizedBox(height: 20),
        Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18),
        )
      ],
    );
  }
}

void hideLoadingIndicator() {
  Navigator.of(Get.overlayContext!).pop();
}

void showLoadingIndicator(String text) {
  showDialog(
    barrierColor: Colors.white54,
    context: Get.overlayContext!,
    barrierDismissible: false,
    builder: (_) => WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: Card(
          elevation: 8,
          child: Padding(
              padding: const EdgeInsets.all(20),
              child: LoadingWidget(
                text: text,
              )),
        ),
      ),
    ),
  );
}
