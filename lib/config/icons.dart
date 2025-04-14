

class ClusterIcons {
  ClusterIcons._();

  static String name(String icon){
    return icon.replaceAll("assets/icons/", "").replaceAll(".svg", "");
  }

  static String icon(String iconName) {
    return 'assets/icons/$iconName.svg';
  }

  //内置list图标
  static const String all = "assets/icons/all_entry.svg";
  static const String markRead = "assets/icons/mark_read.svg";
  static const String markUnread = "assets/icons/mark_unread.svg";
  static const String addCollection = "assets/icons/add_collection.svg";
  static const String today = "assets/icons/today.svg";

  //用户建的list图标
  static const String menu = 'assets/icons/menu.svg';
  static const String starOutline = 'assets/icons/star_outline.svg';
  static const String triangle = 'assets/icons/triangle.svg';
  static const String squareOutline = 'assets/icons/square_outline.svg';
  static const String diamondOutline = 'assets/icons/diamond_outline.svg';
  static const String hexagonOutline = 'assets/icons/hexagon_outline.svg';
  static const String badgeOutline = 'assets/icons/badge_outline.svg';
  static const String heartOutline = 'assets/icons/heart_outline.svg';

  static const String shieldOutline = 'assets/icons/shield_outline.svg';
  static const String asterisk = 'assets/icons/asterisk.svg';
  static const String chatBubble = 'assets/icons/chat_bubble.svg';
  static const String penCancel = 'assets/icons/pen_cancel.svg';
  static const String scribble = 'assets/icons/scribble.svg';
  static const String fileOutline = 'assets/icons/file_outline.svg';
  static const String bookOpen = 'assets/icons/book_open.svg';
  static const String bookClosed = 'assets/icons/book_closed.svg';

  static const String noteOutline = 'assets/icons/note_outline.svg';
  static const String paperclip = 'assets/icons/paperclip.svg';
  static const String accessibility = 'assets/icons/accessibility.svg';
  static const String runner = 'assets/icons/runner.svg';
  static const String friends = 'assets/icons/friends.svg';
  static const String commandKey = 'assets/icons/command_key.svg';
  static const String sunOutline = 'assets/icons/sun_outline.svg';
  static const String moonOutline = 'assets/icons/moon_outline.svg';

  static const String cloudOutline = 'assets/icons/cloud_outline.svg';
  static const String snowflake = 'assets/icons/snowflake.svg';
  static const String peace = 'assets/icons/peace.svg';
  static const String globeAmericas = 'assets/icons/globe_americas.svg';
  static const String globeGrid = 'assets/icons/globe_grid.svg';
  static const String sparkleOne = 'assets/icons/sparkle_one.svg';
  static const String sparkleTwo = 'assets/icons/sparkle_two.svg';
  static const String refreshSync = 'assets/icons/refresh_sync.svg';

  static const String soccer = 'assets/icons/soccer.svg';
  static const String baseball = 'assets/icons/baseball.svg';
  static const String drop = 'assets/icons/drop.svg';
  static const String umbrella = 'assets/icons/umbrella.svg';
  static const String playOutline = 'assets/icons/play_outline.svg';
  static const String musicNote = 'assets/icons/music_note.svg';
  static const String musicDouble = 'assets/icons/music_double.svg';
  static const String microphone = 'assets/icons/microphone.svg';

  static const String swiftLogo = 'assets/icons/swift_logo.svg';
  static const String terminal = 'assets/icons/terminal.svg';
  static const String contrastHalf = 'assets/icons/contrast_half.svg';
  static const String lightning = 'assets/icons/lightning.svg';
  static const String warning = 'assets/icons/warning.svg';
  static const String megaphone = 'assets/icons/megaphone.svg';
  static const String flag = 'assets/icons/flag.svg';
  static const String sendArrow = 'assets/icons/send_arrow.svg';


  static final List<String> iconsPaths = [
    ClusterIcons.menu,
    ClusterIcons.starOutline,
    ClusterIcons.triangle,
    ClusterIcons.squareOutline,
    ClusterIcons.diamondOutline,
    ClusterIcons.hexagonOutline,
    ClusterIcons.badgeOutline,
    ClusterIcons.heartOutline,
    ClusterIcons.shieldOutline,
    ClusterIcons.asterisk,
    ClusterIcons.chatBubble,
    ClusterIcons.penCancel,
    ClusterIcons.scribble,
    ClusterIcons.fileOutline,
    ClusterIcons.bookOpen,
    ClusterIcons.bookClosed,
    ClusterIcons.noteOutline,
    ClusterIcons.paperclip,
    ClusterIcons.accessibility,
    ClusterIcons.runner,
    ClusterIcons.friends,
    ClusterIcons.commandKey,
    ClusterIcons.sunOutline,
    ClusterIcons.moonOutline,
    ClusterIcons.cloudOutline,
    ClusterIcons.snowflake,
    ClusterIcons.peace,
    ClusterIcons.globeAmericas,
    ClusterIcons.globeGrid,
    ClusterIcons.sparkleOne,
    ClusterIcons.sparkleTwo,
    ClusterIcons.refreshSync,
    ClusterIcons.soccer,
    ClusterIcons.baseball,
    ClusterIcons.drop,
    ClusterIcons.umbrella,
    ClusterIcons.playOutline,
    ClusterIcons.musicNote,
    ClusterIcons.musicDouble,
    ClusterIcons.microphone,
    ClusterIcons.swiftLogo,
    ClusterIcons.terminal,
    ClusterIcons.contrastHalf,
    ClusterIcons.lightning,
    ClusterIcons.warning,
    ClusterIcons.megaphone,
    ClusterIcons.flag,
    ClusterIcons.sendArrow,
  ];

}
