

class PageInfo<T> {

  final int total;
  final List<T> list;

  PageInfo({this.total = 0, this.list = const []});
}