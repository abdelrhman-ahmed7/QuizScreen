import 'package:flutter/material.dart';

class errorWidget extends StatelessWidget {
  final String error;
  const errorWidget({
    super.key,
    required this.error
  });

  @override
  Widget build(BuildContext context) {
    return     Column(

      children: [

        Text(error),

        ElevatedButton(onPressed: (){}, child: Text("Refresh"))

      ],

    );
  }
}