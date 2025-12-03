import 'package:flutter/material.dart';

class AppError extends StatelessWidget {
  final String description;
  final void Function() onTap;

  const AppError({
    Key? key,
    required this.description,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            child: Text(
              description, 
              style: Theme.of(context).textTheme.bodyMedium,
            )
          )
        ]
      )
    );
  }
}