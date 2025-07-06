// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'category_response.dart';

class CategoryResponseMapper extends ClassMapperBase<CategoryResponse> {
  CategoryResponseMapper._();

  static CategoryResponseMapper? _instance;
  static CategoryResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CategoryResponseMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'CategoryResponse';

  static int _$id(CategoryResponse v) => v.id;
  static const Field<CategoryResponse, int> _f$id = Field('id', _$id);
  static String _$title(CategoryResponse v) => v.title;
  static const Field<CategoryResponse, String> _f$title =
      Field('title', _$title);
  static int _$userId(CategoryResponse v) => v.userId;
  static const Field<CategoryResponse, int> _f$userId =
      Field('userId', _$userId, key: r'user_id');
  static bool? _$hideGlobally(CategoryResponse v) => v.hideGlobally;
  static const Field<CategoryResponse, bool> _f$hideGlobally =
      Field('hideGlobally', _$hideGlobally, key: r'hide_globally', opt: true);

  @override
  final MappableFields<CategoryResponse> fields = const {
    #id: _f$id,
    #title: _f$title,
    #userId: _f$userId,
    #hideGlobally: _f$hideGlobally,
  };

  static CategoryResponse _instantiate(DecodingData data) {
    return CategoryResponse(
        id: data.dec(_f$id),
        title: data.dec(_f$title),
        userId: data.dec(_f$userId),
        hideGlobally: data.dec(_f$hideGlobally));
  }

  @override
  final Function instantiate = _instantiate;

  static CategoryResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CategoryResponse>(map);
  }

  static CategoryResponse fromJson(String json) {
    return ensureInitialized().decodeJson<CategoryResponse>(json);
  }
}

mixin CategoryResponseMappable {
  String toJson() {
    return CategoryResponseMapper.ensureInitialized()
        .encodeJson<CategoryResponse>(this as CategoryResponse);
  }

  Map<String, dynamic> toMap() {
    return CategoryResponseMapper.ensureInitialized()
        .encodeMap<CategoryResponse>(this as CategoryResponse);
  }

  CategoryResponseCopyWith<CategoryResponse, CategoryResponse, CategoryResponse>
      get copyWith =>
          _CategoryResponseCopyWithImpl<CategoryResponse, CategoryResponse>(
              this as CategoryResponse, $identity, $identity);
  @override
  String toString() {
    return CategoryResponseMapper.ensureInitialized()
        .stringifyValue(this as CategoryResponse);
  }

  @override
  bool operator ==(Object other) {
    return CategoryResponseMapper.ensureInitialized()
        .equalsValue(this as CategoryResponse, other);
  }

  @override
  int get hashCode {
    return CategoryResponseMapper.ensureInitialized()
        .hashValue(this as CategoryResponse);
  }
}

extension CategoryResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CategoryResponse, $Out> {
  CategoryResponseCopyWith<$R, CategoryResponse, $Out>
      get $asCategoryResponse => $base
          .as((v, t, t2) => _CategoryResponseCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CategoryResponseCopyWith<$R, $In extends CategoryResponse, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({int? id, String? title, int? userId, bool? hideGlobally});
  CategoryResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _CategoryResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CategoryResponse, $Out>
    implements CategoryResponseCopyWith<$R, CategoryResponse, $Out> {
  _CategoryResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CategoryResponse> $mapper =
      CategoryResponseMapper.ensureInitialized();
  @override
  $R call(
          {int? id,
          String? title,
          int? userId,
          Object? hideGlobally = $none}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (title != null) #title: title,
        if (userId != null) #userId: userId,
        if (hideGlobally != $none) #hideGlobally: hideGlobally
      }));
  @override
  CategoryResponse $make(CopyWithData data) => CategoryResponse(
      id: data.get(#id, or: $value.id),
      title: data.get(#title, or: $value.title),
      userId: data.get(#userId, or: $value.userId),
      hideGlobally: data.get(#hideGlobally, or: $value.hideGlobally));

  @override
  CategoryResponseCopyWith<$R2, CategoryResponse, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _CategoryResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
