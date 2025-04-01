
class Category {

  final int id;
  final String title;
  final int userId;
  final bool hideGlobally;
  Category({
    required this.id,
    required this.title,
    this.userId = 0,
    this.hideGlobally = false,
  });
}