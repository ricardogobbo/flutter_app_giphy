class Gif {
  String id;
  String title;
  String url;

  Gif(this.id, this.title, this.url);

  @override
  String toString() {
    return this.url;
  }


}