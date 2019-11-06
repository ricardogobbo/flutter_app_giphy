import 'package:app_5_gifs/app/views/GifView.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:app_5_gifs/app/services/GifService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  GifService gifService = GifService();

  final _searchTextController = TextEditingController();

  int _offset = 0;

  String _query;

  _getGifs() async{
    if(_query != "" && _query != null) {
      return gifService.getSearchGifList(_query, offset: _offset ?? 0);
    }
    else
      return gifService.getTrendingGifList();
  }
  _getCount(List data) {
    if(_query != "" && _query != null) {
      return data.length+1;
    }
    return data.length;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.network("https://developers.giphy.com/static/img/dev-logo-lg.7404c00322a8.gif"),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: _searchTextField(),
          ),
          Expanded(
            child: _futureContainer(),
          )
        ],
      ),
    );
  }

  Widget _searchTextField(){
    // Return Text Field
    return TextField(
      controller: _searchTextController,
      onSubmitted: (text){
        setState(() {
          _query = text;
          _offset = 0;
        });
      },
      decoration: InputDecoration(
          labelText: "Pesquisar GIFs",
          labelStyle: TextStyle(color: Colors.white, fontSize: 18),
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white)
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white54)
          )
      ),
      style: TextStyle(color: Colors.white,fontSize: 22),
      textAlign: TextAlign.center,
    );
  }

  Widget _futureContainer(){
    return FutureBuilder(
      future: _getGifs(),
      builder: (context, snapshot){
        switch(snapshot.connectionState) {
          case ConnectionState.waiting:
          case ConnectionState.none:
            return _progressIndicator();
          default:
            if(snapshot.hasError){
              return Container();
            }
            return _gifTable(context, snapshot);
        }
      },
    );
  }

  Widget _progressIndicator(){
    return Container(
      width: 200,
      height: 200,
      alignment: Alignment.center,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white54),
        strokeWidth: 5,
      ),
    );
  }

  Widget _gifTable(context, snapshot){
    return GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10
        ),
        itemCount: _getCount(snapshot.data),
        itemBuilder: (context, index){
          if(_query == null || index < snapshot.data.length){
            return GestureDetector(
              child: CachedNetworkImage(
                  imageUrl: snapshot.data[index].url,
                  placeholder: (context, url) => _progressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                onLongPress: (){
                  //Share.share(snapshot.data[index].url);
                },
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => GifView(snapshot.data[index])
                    )
                  );
                },
            );
          } else {
            return Container(
              alignment: Alignment.center,
              child: GestureDetector(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.add, color: Colors.white, size: 70),
                    Text("Carregar Mais", style: TextStyle(
                      color: Colors.white,
                      fontSize: 22
                    ),)
                  ],
                ),
                onTap: (){
                  setState(() {
                    _offset += 19;
                  });
                },
              )
            );
          }
        });
  }

}
