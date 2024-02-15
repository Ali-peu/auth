import 'package:auth/auth/ui/widgets/custom_container.dart';
import 'package:flutter/material.dart';

class RegistrationButtonWithPlatform extends StatelessWidget {
  final IconData platformaIcon;
  final String platformName;

  const RegistrationButtonWithPlatform(
      {required this.platformName, required this.platformaIcon, super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              platformaIcon,
              color: Colors.black,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Продолжить в ',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Text(
                    platformName,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
