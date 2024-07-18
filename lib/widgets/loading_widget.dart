import 'package:flutter/material.dart';

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

void hideLoadingIndicator(BuildContext context) {
  Navigator.of(context).pop();
}

void showLoadingIndicator(String text, BuildContext context) {
  showDialog(
    barrierColor: Colors.white54,
    context: context,
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
