// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_normalization_rule_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMerchantNormalizationRuleModelCollection on Isar {
  IsarCollection<MerchantNormalizationRuleModel>
      get merchantNormalizationRuleModels => this.collection();
}

const MerchantNormalizationRuleModelSchema = CollectionSchema(
  name: r'MerchantNormalizationRuleModel',
  id: 424475722532074916,
  properties: {
    r'confidence': PropertySchema(
      id: 0,
      name: r'confidence',
      type: IsarType.long,
    ),
    r'createdAt': PropertySchema(
      id: 1,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'isSystemRule': PropertySchema(
      id: 2,
      name: r'isSystemRule',
      type: IsarType.bool,
    ),
    r'isUserDefined': PropertySchema(
      id: 3,
      name: r'isUserDefined',
      type: IsarType.bool,
    ),
    r'lastUsedAt': PropertySchema(
      id: 4,
      name: r'lastUsedAt',
      type: IsarType.dateTime,
    ),
    r'matchType': PropertySchema(
      id: 5,
      name: r'matchType',
      type: IsarType.byte,
      enumMap: _MerchantNormalizationRuleModelmatchTypeEnumValueMap,
    ),
    r'normalizedName': PropertySchema(
      id: 6,
      name: r'normalizedName',
      type: IsarType.string,
    ),
    r'rawName': PropertySchema(
      id: 7,
      name: r'rawName',
      type: IsarType.string,
    ),
    r'usageCount': PropertySchema(
      id: 8,
      name: r'usageCount',
      type: IsarType.long,
    )
  },
  estimateSize: _merchantNormalizationRuleModelEstimateSize,
  serialize: _merchantNormalizationRuleModelSerialize,
  deserialize: _merchantNormalizationRuleModelDeserialize,
  deserializeProp: _merchantNormalizationRuleModelDeserializeProp,
  idName: r'id',
  indexes: {
    r'rawName': IndexSchema(
      id: 8117133376363797947,
      name: r'rawName',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'rawName',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'createdAt': IndexSchema(
      id: -3433535483987302584,
      name: r'createdAt',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'createdAt',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _merchantNormalizationRuleModelGetId,
  getLinks: _merchantNormalizationRuleModelGetLinks,
  attach: _merchantNormalizationRuleModelAttach,
  version: '3.1.0+1',
);

int _merchantNormalizationRuleModelEstimateSize(
  MerchantNormalizationRuleModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.normalizedName.length * 3;
  bytesCount += 3 + object.rawName.length * 3;
  return bytesCount;
}

void _merchantNormalizationRuleModelSerialize(
  MerchantNormalizationRuleModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.confidence);
  writer.writeDateTime(offsets[1], object.createdAt);
  writer.writeBool(offsets[2], object.isSystemRule);
  writer.writeBool(offsets[3], object.isUserDefined);
  writer.writeDateTime(offsets[4], object.lastUsedAt);
  writer.writeByte(offsets[5], object.matchType.index);
  writer.writeString(offsets[6], object.normalizedName);
  writer.writeString(offsets[7], object.rawName);
  writer.writeLong(offsets[8], object.usageCount);
}

MerchantNormalizationRuleModel _merchantNormalizationRuleModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MerchantNormalizationRuleModel();
  object.confidence = reader.readLong(offsets[0]);
  object.createdAt = reader.readDateTime(offsets[1]);
  object.id = id;
  object.isSystemRule = reader.readBool(offsets[2]);
  object.isUserDefined = reader.readBool(offsets[3]);
  object.lastUsedAt = reader.readDateTimeOrNull(offsets[4]);
  object.matchType = _MerchantNormalizationRuleModelmatchTypeValueEnumMap[
          reader.readByteOrNull(offsets[5])] ??
      MatchType.exact;
  object.normalizedName = reader.readString(offsets[6]);
  object.rawName = reader.readString(offsets[7]);
  object.usageCount = reader.readLong(offsets[8]);
  return object;
}

P _merchantNormalizationRuleModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 5:
      return (_MerchantNormalizationRuleModelmatchTypeValueEnumMap[
              reader.readByteOrNull(offset)] ??
          MatchType.exact) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _MerchantNormalizationRuleModelmatchTypeEnumValueMap = {
  'exact': 0,
  'contains': 1,
  'startsWith': 2,
  'regex': 3,
};
const _MerchantNormalizationRuleModelmatchTypeValueEnumMap = {
  0: MatchType.exact,
  1: MatchType.contains,
  2: MatchType.startsWith,
  3: MatchType.regex,
};

Id _merchantNormalizationRuleModelGetId(MerchantNormalizationRuleModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _merchantNormalizationRuleModelGetLinks(
    MerchantNormalizationRuleModel object) {
  return [];
}

void _merchantNormalizationRuleModelAttach(
    IsarCollection<dynamic> col, Id id, MerchantNormalizationRuleModel object) {
  object.id = id;
}

extension MerchantNormalizationRuleModelQueryWhereSort on QueryBuilder<
    MerchantNormalizationRuleModel, MerchantNormalizationRuleModel, QWhere> {
  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterWhere> anyCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'createdAt'),
      );
    });
  }
}

extension MerchantNormalizationRuleModelQueryWhere on QueryBuilder<
    MerchantNormalizationRuleModel,
    MerchantNormalizationRuleModel,
    QWhereClause> {
  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterWhereClause> idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterWhereClause> idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterWhereClause> rawNameEqualTo(String rawName) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'rawName',
        value: [rawName],
      ));
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterWhereClause> rawNameNotEqualTo(String rawName) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'rawName',
              lower: [],
              upper: [rawName],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'rawName',
              lower: [rawName],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'rawName',
              lower: [rawName],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'rawName',
              lower: [],
              upper: [rawName],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterWhereClause> createdAtEqualTo(DateTime createdAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'createdAt',
        value: [createdAt],
      ));
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterWhereClause> createdAtNotEqualTo(DateTime createdAt) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [],
              upper: [createdAt],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [createdAt],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [createdAt],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [],
              upper: [createdAt],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterWhereClause> createdAtGreaterThan(
    DateTime createdAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [createdAt],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterWhereClause> createdAtLessThan(
    DateTime createdAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [],
        upper: [createdAt],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterWhereClause> createdAtBetween(
    DateTime lowerCreatedAt,
    DateTime upperCreatedAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [lowerCreatedAt],
        includeLower: includeLower,
        upper: [upperCreatedAt],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension MerchantNormalizationRuleModelQueryFilter on QueryBuilder<
    MerchantNormalizationRuleModel,
    MerchantNormalizationRuleModel,
    QFilterCondition> {
  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterFilterCondition> confidenceEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'confidence',
        value: value,
      ));
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterFilterCondition> confidenceGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'confidence',
        value: value,
      ));
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterFilterCondition> confidenceLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'confidence',
        value: value,
      ));
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterFilterCondition> confidenceBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'confidence',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterFilterCondition> createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterFilterCondition> createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterFilterCondition> createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterFilterCondition> createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterFilterCondition> isSystemRuleEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isSystemRule',
        value: value,
      ));
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterFilterCondition> isUserDefinedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isUserDefined',
        value: value,
      ));
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterFilterCondition> lastUsedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastUsedAt',
      ));
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterFilterCondition> lastUsedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastUsedAt',
      ));
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterFilterCondition> lastUsedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastUsedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterFilterCondition> lastUsedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastUsedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterFilterCondition> lastUsedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastUsedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterFilterCondition> lastUsedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastUsedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterFilterCondition> matchTypeEqualTo(MatchType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'matchType',
        value: value,
      ));
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterFilterCondition> matchTypeGreaterThan(
    MatchType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'matchType',
        value: value,
      ));
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterFilterCondition> matchTypeLessThan(
    MatchType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'matchType',
        value: value,
      ));
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterFilterCondition> matchTypeBetween(
    MatchType lower,
    MatchType upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'matchType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterFilterCondition> normalizedNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'normalizedName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterFilterCondition> normalizedNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'normalizedName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterFilterCondition> normalizedNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'normalizedName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterFilterCondition> normalizedNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'normalizedName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterFilterCondition> normalizedNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'normalizedName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterFilterCondition> normalizedNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'normalizedName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
          QAfterFilterCondition>
      normalizedNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'normalizedName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
          QAfterFilterCondition>
      normalizedNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'normalizedName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterFilterCondition> normalizedNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'normalizedName',
        value: '',
      ));
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterFilterCondition> normalizedNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'normalizedName',
        value: '',
      ));
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterFilterCondition> rawNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rawName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterFilterCondition> rawNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'rawName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterFilterCondition> rawNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'rawName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterFilterCondition> rawNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'rawName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterFilterCondition> rawNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'rawName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterFilterCondition> rawNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'rawName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
          QAfterFilterCondition>
      rawNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'rawName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
          QAfterFilterCondition>
      rawNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'rawName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterFilterCondition> rawNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rawName',
        value: '',
      ));
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterFilterCondition> rawNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'rawName',
        value: '',
      ));
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterFilterCondition> usageCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'usageCount',
        value: value,
      ));
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterFilterCondition> usageCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'usageCount',
        value: value,
      ));
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterFilterCondition> usageCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'usageCount',
        value: value,
      ));
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterFilterCondition> usageCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'usageCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension MerchantNormalizationRuleModelQueryObject on QueryBuilder<
    MerchantNormalizationRuleModel,
    MerchantNormalizationRuleModel,
    QFilterCondition> {}

extension MerchantNormalizationRuleModelQueryLinks on QueryBuilder<
    MerchantNormalizationRuleModel,
    MerchantNormalizationRuleModel,
    QFilterCondition> {}

extension MerchantNormalizationRuleModelQuerySortBy on QueryBuilder<
    MerchantNormalizationRuleModel, MerchantNormalizationRuleModel, QSortBy> {
  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterSortBy> sortByConfidence() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'confidence', Sort.asc);
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterSortBy> sortByConfidenceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'confidence', Sort.desc);
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterSortBy> sortByIsSystemRule() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSystemRule', Sort.asc);
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterSortBy> sortByIsSystemRuleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSystemRule', Sort.desc);
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterSortBy> sortByIsUserDefined() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isUserDefined', Sort.asc);
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterSortBy> sortByIsUserDefinedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isUserDefined', Sort.desc);
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterSortBy> sortByLastUsedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUsedAt', Sort.asc);
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterSortBy> sortByLastUsedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUsedAt', Sort.desc);
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterSortBy> sortByMatchType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'matchType', Sort.asc);
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterSortBy> sortByMatchTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'matchType', Sort.desc);
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterSortBy> sortByNormalizedName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'normalizedName', Sort.asc);
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterSortBy> sortByNormalizedNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'normalizedName', Sort.desc);
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterSortBy> sortByRawName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rawName', Sort.asc);
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterSortBy> sortByRawNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rawName', Sort.desc);
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterSortBy> sortByUsageCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'usageCount', Sort.asc);
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterSortBy> sortByUsageCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'usageCount', Sort.desc);
    });
  }
}

extension MerchantNormalizationRuleModelQuerySortThenBy on QueryBuilder<
    MerchantNormalizationRuleModel,
    MerchantNormalizationRuleModel,
    QSortThenBy> {
  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterSortBy> thenByConfidence() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'confidence', Sort.asc);
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterSortBy> thenByConfidenceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'confidence', Sort.desc);
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterSortBy> thenByIsSystemRule() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSystemRule', Sort.asc);
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterSortBy> thenByIsSystemRuleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSystemRule', Sort.desc);
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterSortBy> thenByIsUserDefined() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isUserDefined', Sort.asc);
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterSortBy> thenByIsUserDefinedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isUserDefined', Sort.desc);
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterSortBy> thenByLastUsedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUsedAt', Sort.asc);
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterSortBy> thenByLastUsedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUsedAt', Sort.desc);
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterSortBy> thenByMatchType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'matchType', Sort.asc);
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterSortBy> thenByMatchTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'matchType', Sort.desc);
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterSortBy> thenByNormalizedName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'normalizedName', Sort.asc);
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterSortBy> thenByNormalizedNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'normalizedName', Sort.desc);
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterSortBy> thenByRawName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rawName', Sort.asc);
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterSortBy> thenByRawNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rawName', Sort.desc);
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterSortBy> thenByUsageCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'usageCount', Sort.asc);
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QAfterSortBy> thenByUsageCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'usageCount', Sort.desc);
    });
  }
}

extension MerchantNormalizationRuleModelQueryWhereDistinct on QueryBuilder<
    MerchantNormalizationRuleModel, MerchantNormalizationRuleModel, QDistinct> {
  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QDistinct> distinctByConfidence() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'confidence');
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QDistinct> distinctByIsSystemRule() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isSystemRule');
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QDistinct> distinctByIsUserDefined() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isUserDefined');
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QDistinct> distinctByLastUsedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastUsedAt');
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QDistinct> distinctByMatchType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'matchType');
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QDistinct> distinctByNormalizedName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'normalizedName',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QDistinct> distinctByRawName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rawName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MerchantNormalizationRuleModel,
      QDistinct> distinctByUsageCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'usageCount');
    });
  }
}

extension MerchantNormalizationRuleModelQueryProperty on QueryBuilder<
    MerchantNormalizationRuleModel,
    MerchantNormalizationRuleModel,
    QQueryProperty> {
  QueryBuilder<MerchantNormalizationRuleModel, int, QQueryOperations>
      idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, int, QQueryOperations>
      confidenceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'confidence');
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, DateTime, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, bool, QQueryOperations>
      isSystemRuleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isSystemRule');
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, bool, QQueryOperations>
      isUserDefinedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isUserDefined');
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, DateTime?, QQueryOperations>
      lastUsedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastUsedAt');
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, MatchType, QQueryOperations>
      matchTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'matchType');
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, String, QQueryOperations>
      normalizedNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'normalizedName');
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, String, QQueryOperations>
      rawNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rawName');
    });
  }

  QueryBuilder<MerchantNormalizationRuleModel, int, QQueryOperations>
      usageCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'usageCount');
    });
  }
}
