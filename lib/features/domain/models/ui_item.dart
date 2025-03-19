
abstract class BaseUiItem {
  const BaseUiItem();
}

enum ViewType {
  feedItem,
  groupTitleItem,
  listItem,
  divider32,
  entryItem,
  noMore,
  feedHeaderItem,
  noContentYetItem,

}

class UiItem {
  final ViewType type;
  final BaseUiItem content;

  const UiItem({
    required this.type,
    required this.content,
  });
}



class EmptyUiData extends BaseUiItem {

}