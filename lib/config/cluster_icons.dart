

import 'package:flutter/cupertino.dart';
// ignore_for_file: constant_identifier_names
class ClusterIcons {
  ClusterIcons._();

  static String name(String icon){
    return icon.replaceAll("assets/icons/", "").replaceAll(".svg", "");
  }

  static String icon(String iconName) {
    return 'assets/icons/$iconName.svg';
  }

  //内置list图标
  static const String cards = "assets/icons/cards.svg";
  static const String unread = "assets/icons/unread.svg";
  static const String today = "assets/icons/today.svg";
  static const String collection = "assets/icons/collection.svg";
  static const String read = "assets/icons/read.svg";

  static final Map<String, IconData> iconMap = {
    'list_bullet': list_bullet, 'star': star, 'triangle': triangle,
    'square': square, 'app_badge': app_badge, 'hexagon': hexagon,

    'checkmark_seal': checkmark_seal, 'heart': heart, 'shield': shield,
    'staroflife': staroflife, 'antenna_radiowaves_left_right': antenna_radiowaves_left_right, 'pencil_outline': pencil_outline,

    'scribble': scribble, 'doc': doc, 'book': book,
    'alt': alt, 'scissors_alt': scissors_alt, 'paperclip': paperclip,

    'padlock': padlock, 'arrow_2_circlepath_circle': arrow_2_circlepath_circle, 'arrow_3_trianglepath': arrow_3_trianglepath,
    'command': command, 'sun_max': sun_max, 'moon': moon,

    'cloud': cloud, 'wind_snow': wind_snow, 'arrow_swap': arrow_swap,
    'gobackward_10': gobackward_10, 'globe': globe, 'recordingtape': recordingtape,

    'sparkles': sparkles, 'rectangle_expand_vertical': rectangle_expand_vertical, 'bitcoin_circle': bitcoin_circle,
    'bold_underline': bold_underline, 'drop': drop, 'umbrella': umbrella,

    'play': play, 'music_note': music_note, 'music_house': music_house,
    'personalhotspot': personalhotspot, 'bolt_horizontal_circle': bolt_horizontal_circle, 'table': table,

    'circle_righthalf_fill': circle_righthalf_fill, 'bolt_circle': bolt_circle, 'exclamationmark_triangle': exclamationmark_triangle,
    'circle_bottomthird_split': circle_bottomthird_split, 'flag': flag, 'location': location,
  };

  static final Map<IconData, String> reverseIconsMap = {
    for (var entry in iconMap.entries) entry.value: entry.key,
  };

  static const IconData list_bullet = CupertinoIcons.list_bullet;
  static const IconData star = CupertinoIcons.star;
  static const IconData triangle = CupertinoIcons.triangle;
  static const IconData square = CupertinoIcons.square;
  static const IconData app_badge = CupertinoIcons.app_badge; // "diamond",
  static const IconData hexagon = CupertinoIcons.hexagon;

  static const IconData checkmark_seal = CupertinoIcons.checkmark_seal; // "seal",
  static const IconData heart = CupertinoIcons.heart;
  static const IconData shield = CupertinoIcons.shield;
  static const IconData staroflife = CupertinoIcons.staroflife;
  static const IconData antenna_radiowaves_left_right = CupertinoIcons.antenna_radiowaves_left_right; // "message",
  static const IconData pencil_outline = CupertinoIcons.pencil_outline; // "pencil.and.outline",

  static const IconData scribble = CupertinoIcons.scribble;
  static const IconData doc = CupertinoIcons.doc; // "document",
  static const IconData book = CupertinoIcons.book;
  static const IconData alt = CupertinoIcons.alt; // "book.closed",
  static const IconData scissors_alt = CupertinoIcons.scissors_alt; // "scroll",
  static const IconData paperclip = CupertinoIcons.paperclip;

  static const IconData padlock = CupertinoIcons.padlock; // "figure",
  static const IconData arrow_2_circlepath_circle = CupertinoIcons.arrow_2_circlepath_circle; // "figure.run",
  static const IconData arrow_3_trianglepath = CupertinoIcons.arrow_3_trianglepath; // "figure.2",
  static const IconData command = CupertinoIcons.command;
  static const IconData sun_max = CupertinoIcons.sun_max;
  static const IconData moon = CupertinoIcons.moon;

  static const IconData cloud = CupertinoIcons.cloud;
  static const IconData wind_snow = CupertinoIcons.wind_snow; // "snowflake",
  static const IconData arrow_swap = CupertinoIcons.arrow_swap; // "peacesign",
  static const IconData gobackward_10 = CupertinoIcons.gobackward_10; //"globe.americas.fill"
  static const IconData globe = CupertinoIcons.globe;
  static const IconData recordingtape = CupertinoIcons.recordingtape; // "sparkle",

  static const IconData sparkles = CupertinoIcons.sparkles;
  static const IconData rectangle_expand_vertical = CupertinoIcons.rectangle_expand_vertical; // "lasso.badge.sparkles",
  static const IconData bitcoin_circle = CupertinoIcons.bitcoin_circle; // "soccerball",
  static const IconData bold_underline = CupertinoIcons.bold_underline; // "tennisball",
  static const IconData drop = CupertinoIcons.drop;
  static const IconData umbrella = CupertinoIcons.umbrella;

  static const IconData play = CupertinoIcons.play;
  static const IconData music_note = CupertinoIcons.music_note;
  static const IconData music_house = CupertinoIcons.music_house; // "music.quarternote.3",
  static const IconData personalhotspot = CupertinoIcons.personalhotspot; // "microphone",
  static const IconData bolt_horizontal_circle = CupertinoIcons.bolt_horizontal_circle; // "swift",
  static const IconData table = CupertinoIcons.table; // "apple.terminal",

  static const IconData circle_righthalf_fill = CupertinoIcons.circle_righthalf_fill; // "circle.lefthalf.filled.righthalf.striped.horizontal.inverse",
  static const IconData bolt_circle = CupertinoIcons.bolt_circle;
  static const IconData exclamationmark_triangle = CupertinoIcons.exclamationmark_triangle;
  static const IconData circle_bottomthird_split = CupertinoIcons.circle_bottomthird_split; // "megaphone",
  static const IconData flag = CupertinoIcons.flag;
  static const IconData location = CupertinoIcons.location;

  // "bell",  // 􀋙
  // "tag",  // 􀋡
  // "camera",  // 􀌞
  // "quote.opening",  // 􁈏
  // "video",  // 􀍉
  // "envelope",  // 􀍕
  // "line.3.crossed.swirl.circle",  // 􀫎
  // "cart",  // 􀍩
  //
  // "creditcard",  // 􀍯
  // "wand.and.rays",  // 􀍱
  // "gauge.with.dots.needle.bottom.50percent",  // 􀍽
  // "paintbrush",  // 􀎑
  // "paintbrush.pointed",  // 􀣶
  // "hammer",  // 􀙄
  // "pianokeys",  // 􀎏
  // "briefcase",  // 􀎜
  //
  // "puzzlepiece.extension",  // 􀥭
  // "house",  // 􀎞
  // "lightbulb",  // 􀛭
  // "fan",  // 􁁋
  // "chair.lounge",  // 􁐴
  // "powerplug",  // 􀡷
  // "laser.burst",  // 􂁝
  // "toilet",  // 􁐾
  //
  // "lock",  // 􀎠
  // "key",  // 􀟕
  // "pin",  // 􀎦
  // "mappin.and.ellipse",  // 􀎫
  // "safari",  // 􀎬
  // "faceid",  // 􀎽
  // "cpu",  // 􀫥
  // "apps.ipad",  // 􀮕
  //
  // "applewatch.watchface",  // 􀫋
  // "airpods",  // 􀟥
  // "trash",  // 􀈑
  // "airplane",  // 􀑓
  // "car",  // 􀙘
  // "fuelpump",  // 􀵞
  // "bandage",  // 􀎓
  // "syringe",  // 􀠷
  //
  // "pill",  // 􁚭
  // "bird",  // 􁗟
  // "pawprint",  // 􀾞
  // "leaf",  // 􀥲
  // "crown",  // 􀦅
  // "hat.cap",  // 􂏨
  // "film",  // 􀎶
  // "face.smiling",  // 􀎸
  //
  // "eyes",  // 􀦧
  // "ear",  // 􀜣
  // "hand.raised",  // 􀉻
  // "hand.thumbsup",  // 􀉿
  // "hand.point.up.left",  // 􀝰
  // "cube",  // 􀐘
  // "shippingbox",  // 􀐚
  // "cone",  // 􀳇
  //
  // "square.stack.3d.down.right",  // 􀐜
  // "square.stack.3d.up",  // 􀐞
  // "scope",  // 􀐩
  // "paintpalette",  // 􀝥
  // "gamecontroller",  // 􀛸
  // "xmark.triangle.circle.square",  // 􂮰
  // "cup.and.saucer",  // 􀸘
  // "carrot",  // 􁖎
  //
  // "chart.pie",  // 􀑀
  // "burst",  // 􀑂
  // "gift",  // 􀑉
  // "lifepreserver",  // 􀡦
  // "binoculars",  // 􀠍
  // "rectangle.3.group.bubble",  // 􀬄
  // "text.quote",  // 􀋿
  // // .environment(\.locale, .init(identifier: "en")) // 强制使用英文环境
  // "textformat",  // 􀅒
  //
  // "checkmark.circle",  // 􀁢
  // "info.circle",  // 􀅴
  // "at",  // 􀅷
  // "exclamationmark.3",  // 􀣴
  // "ellipsis.curlybraces",  // 􁇵
  // "number",  // 􀆃
  // "bitcoinsign",  // 􁑞
  // "dollarsign",  // 􁎢
}
