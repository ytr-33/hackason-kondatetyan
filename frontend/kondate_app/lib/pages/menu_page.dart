import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return const Text('data');
        },
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.check),
            label: 'Get Menu',
            onTap: () {
              // Get Menu ボタンが押されたときの処理
            },
          ),
        ],
      ),
    );
  }
}
