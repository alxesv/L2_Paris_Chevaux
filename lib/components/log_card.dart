import 'package:flutter/material.dart';
import 'package:projet_chevaux/models/logs.dart';
import 'package:intl/intl.dart';

final DateFormat formatter = DateFormat('yyyy-MM-dd');

class LogCard extends StatelessWidget {
  const LogCard({
    super.key,
    required this.log,
  });
  final log;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          elevation: 2.0,
          color: Colors.white,
          child: ListTile(
            title: Text(log.message),
            subtitle: Text(formatter.format(log.time)),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
