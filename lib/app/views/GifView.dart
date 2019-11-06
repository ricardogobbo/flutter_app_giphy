import 'dart:io';
import 'dart:typed_data';

import 'package:app_5_gifs/app/models/Gif.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class GifView extends StatelessWidget {

  Gif _gif;


  GifView(this._gif);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_gif.title),
        backgroundColor: Colors.black,

        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share, color: Colors.white),
            onPressed: () async{
              var request = await HttpClient().getUrl(Uri.parse(_gif.url));
              var response = await request.close();
              Uint8List bytes = await consolidateHttpClientResponseBytes(response);
              await Share.file('Giphy', 'giphy.gif', bytes, 'image/gif');

            })
        ],
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Image.network(_gif.url),
      ),
    );
  }
}
