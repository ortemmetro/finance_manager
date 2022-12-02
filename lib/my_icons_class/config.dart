import 'dart:convert';

class IconsIconsIcons {
  final String name;
  final String css_prefix_text;
  final bool css_use_suffix;
  final bool hinting;
  final int units_per_em;
  final int ascent;
  final List<Glyph> glyphs;
  IconsIconsIcons({
    required this.name,
    required this.css_prefix_text,
    required this.css_use_suffix,
    required this.hinting,
    required this.units_per_em,
    required this.ascent,
    required this.glyphs,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'css_prefix_text': css_prefix_text,
      'css_use_suffix': css_use_suffix,
      'hinting': hinting,
      'units_per_em': units_per_em,
      'ascent': ascent,
      'glyphs': glyphs.map((x) => x.toMap()).toList(),
    };
  }

  factory IconsIconsIcons.fromMap(Map<String, dynamic> map) {
    return IconsIconsIcons(
      name: map['name'] as String,
      css_prefix_text: map['css_prefix_text'] as String,
      css_use_suffix: map['css_use_suffix'] as bool,
      hinting: map['hinting'] as bool,
      units_per_em: map['units_per_em'].toInt() as int,
      ascent: map['ascent'].toInt() as int,
      glyphs: List<Glyph>.from((map['glyphs'] as List<int>).map<Glyph>((x) => Glyph.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory IconsIconsIcons.fromJson(String source) => IconsIconsIcons.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Glyph {
  final String uid;
  final String css;
  final int code;
  final String src;
  final bool selected;
  final Svg svg;
  final List<String> search;
  Glyph({
    required this.uid,
    required this.css,
    required this.code,
    required this.src,
    required this.selected,
    required this.svg,
    required this.search,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'css': css,
      'code': code,
      'src': src,
      'selected': selected,
      'svg': svg.toMap(),
      'search': search,
    };
  }

  factory Glyph.fromMap(Map<String, dynamic> map) {
    return Glyph(
      uid: map['uid'] as String,
      css: map['css'] as String,
      code: map['code'].toInt() as int,
      src: map['src'] as String,
      selected: map['selected'] as bool,
      svg: Svg.fromMap(map['svg'] as Map<String,dynamic>),
      search: List<String>.from((map['search'] as List<String>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Glyph.fromJson(String source) => Glyph.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Svg {
  final String path;
  final int width;
  Svg({
    required this.path,
    required this.width,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'path': path,
      'width': width,
    };
  }

  factory Svg.fromMap(Map<String, dynamic> map) {
    return Svg(
      path: map['path'] as String,
      width: map['width'].toInt() as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Svg.fromJson(String source) => Svg.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Svg(path: $path, width: $width)';

  @override
  bool operator ==(covariant Svg other) {
    if (identical(this, other)) return true;
  
    return 
      other.path == path &&
      other.width == width;
  }

  @override
  int get hashCode => path.hashCode ^ width.hashCode;
}