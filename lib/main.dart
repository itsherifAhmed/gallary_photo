import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:video_player/video_player.dart';

import 'AssetThumbnail.dart';
import 'Gallary.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Photo Manager Demo',
      home: Material(
        child: Center(
          child: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () async {
                  final permitted = await PhotoManager.requestPermission();
                  if (!permitted) return;
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => Gallery()),
                  );
                },
                child: Text('Open Gallery'),
              );
            },
          ),
        ),
      ),
    );
  }
}
