import 'package:flutter/material.dart';

class loadingWidget extends StatelessWidget {
  const loadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
      ),
    );
  }
}