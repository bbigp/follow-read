
class Conf {

  final String name;
  final String value;
  final int userId;

  const Conf({
    required this.name,
    required this.userId,
    this.value = "",
  });

}