// lib/core/mappers/bigint_mapper.dart
import 'package:dart_mappable/dart_mappable.dart';

class BigIntMapper extends SimpleMapper<BigInt> {
  const BigIntMapper();

  @override
  BigInt decode(dynamic value) {
    if (value is String) {
      return BigInt.parse(value);
    } else if (value is int) {
      return BigInt.from(value);
    } else {
      return BigInt.from(0);
    }
  }

  @override
  dynamic encode(BigInt self) {
    return self.toString();
  }
}