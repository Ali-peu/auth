import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.45,
          child: const Divider(
            color: Colors.black,
          ),
        ),
        const Flexible(child: Center(child: Text('Или'))),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.45,
          child: const Divider(
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
