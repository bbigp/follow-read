
class Conf {

  final String name;
  final String value;
  final int userId;

  const Conf({
    required this.name,
    required this.userId,
    this.value = "",
  });

  static final String keyAutoRead = "autoRead";
  static final String keyShowAll = "showAll";
  static final String keyBaseUrls = "baseUrls";

}