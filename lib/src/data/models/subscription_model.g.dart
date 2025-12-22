// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSubscriptionModelCollection on Isar {
  IsarCollection<SubscriptionModel> get subscriptionModels => this.collection();
}

const SubscriptionModelSchema = CollectionSchema(
  name: r'SubscriptionModel',
  id: 1910962846492805114,
  properties: {
    r'amount': PropertySchema(
      id: 0,
      name: r'amount',
      type: IsarType.double,
    ),
    r'averageDaysBetweenCharges': PropertySchema(
      id: 1,
      name: r'averageDaysBetweenCharges',
      type: IsarType.double,
    ),
    r'category': PropertySchema(
      id: 2,
      name: r'category',
      type: IsarType.string,
    ),
    r'categoryId': PropertySchema(
      id: 3,
      name: r'categoryId',
      type: IsarType.long,
    ),
    r'chargeCount': PropertySchema(
      id: 4,
      name: r'chargeCount',
      type: IsarType.long,
    ),
    r'createdAt': PropertySchema(
      id: 5,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'currency': PropertySchema(
      id: 6,
      name: r'currency',
      type: IsarType.string,
    ),
    r'cycleHistoryJson': PropertySchema(
      id: 7,
      name: r'cycleHistoryJson',
      type: IsarType.string,
    ),
    r'detectionSource': PropertySchema(
      id: 8,
      name: r'detectionSource',
      type: IsarType.byte,
      enumMap: _SubscriptionModeldetectionSourceEnumValueMap,
    ),
    r'firstSeenDate': PropertySchema(
      id: 9,
      name: r'firstSeenDate',
      type: IsarType.dateTime,
    ),
    r'frequency': PropertySchema(
      id: 10,
      name: r'frequency',
      type: IsarType.byte,
      enumMap: _SubscriptionModelfrequencyEnumValueMap,
    ),
    r'frequencyConsistency': PropertySchema(
      id: 11,
      name: r'frequencyConsistency',
      type: IsarType.long,
    ),
    r'isTrial': PropertySchema(
      id: 12,
      name: r'isTrial',
      type: IsarType.bool,
    ),
    r'isZombie': PropertySchema(
      id: 13,
      name: r'isZombie',
      type: IsarType.bool,
    ),
    r'lastChargedDate': PropertySchema(
      id: 14,
      name: r'lastChargedDate',
      type: IsarType.dateTime,
    ),
    r'lastPriceHikePercent': PropertySchema(
      id: 15,
      name: r'lastPriceHikePercent',
      type: IsarType.double,
    ),
    r'lifecycleState': PropertySchema(
      id: 16,
      name: r'lifecycleState',
      type: IsarType.byte,
      enumMap: _SubscriptionModellifecycleStateEnumValueMap,
    ),
    r'nextRenewalDate': PropertySchema(
      id: 17,
      name: r'nextRenewalDate',
      type: IsarType.dateTime,
    ),
    r'notes': PropertySchema(
      id: 18,
      name: r'notes',
      type: IsarType.string,
    ),
    r'priceHistoryJson': PropertySchema(
      id: 19,
      name: r'priceHistoryJson',
      type: IsarType.string,
    ),
    r'serviceName': PropertySchema(
      id: 20,
      name: r'serviceName',
      type: IsarType.string,
    ),
    r'trialEndDate': PropertySchema(
      id: 21,
      name: r'trialEndDate',
      type: IsarType.dateTime,
    ),
    r'updatedAt': PropertySchema(
      id: 22,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
    r'userConfirmed': PropertySchema(
      id: 23,
      name: r'userConfirmed',
      type: IsarType.bool,
    ),
    r'zombieReason': PropertySchema(
      id: 24,
      name: r'zombieReason',
      type: IsarType.string,
    )
  },
  estimateSize: _subscriptionModelEstimateSize,
  serialize: _subscriptionModelSerialize,
  deserialize: _subscriptionModelDeserialize,
  deserializeProp: _subscriptionModelDeserializeProp,
  idName: r'id',
  indexes: {
    r'serviceName': IndexSchema(
      id: 835766691952713873,
      name: r'serviceName',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'serviceName',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'firstSeenDate': IndexSchema(
      id: 8204232639452279998,
      name: r'firstSeenDate',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'firstSeenDate',
          type: IndexType.value,
          caseSensitive: false,
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
  getId: _subscriptionModelGetId,
  getLinks: _subscriptionModelGetLinks,
  attach: _subscriptionModelAttach,
  version: '3.1.0+1',
);

int _subscriptionModelEstimateSize(
  SubscriptionModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.category;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.currency.length * 3;
  {
    final value = object.cycleHistoryJson;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.notes;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.priceHistoryJson;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.serviceName.length * 3;
  {
    final value = object.zombieReason;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _subscriptionModelSerialize(
  SubscriptionModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.amount);
  writer.writeDouble(offsets[1], object.averageDaysBetweenCharges);
  writer.writeString(offsets[2], object.category);
  writer.writeLong(offsets[3], object.categoryId);
  writer.writeLong(offsets[4], object.chargeCount);
  writer.writeDateTime(offsets[5], object.createdAt);
  writer.writeString(offsets[6], object.currency);
  writer.writeString(offsets[7], object.cycleHistoryJson);
  writer.writeByte(offsets[8], object.detectionSource.index);
  writer.writeDateTime(offsets[9], object.firstSeenDate);
  writer.writeByte(offsets[10], object.frequency.index);
  writer.writeLong(offsets[11], object.frequencyConsistency);
  writer.writeBool(offsets[12], object.isTrial);
  writer.writeBool(offsets[13], object.isZombie);
  writer.writeDateTime(offsets[14], object.lastChargedDate);
  writer.writeDouble(offsets[15], object.lastPriceHikePercent);
  writer.writeByte(offsets[16], object.lifecycleState.index);
  writer.writeDateTime(offsets[17], object.nextRenewalDate);
  writer.writeString(offsets[18], object.notes);
  writer.writeString(offsets[19], object.priceHistoryJson);
  writer.writeString(offsets[20], object.serviceName);
  writer.writeDateTime(offsets[21], object.trialEndDate);
  writer.writeDateTime(offsets[22], object.updatedAt);
  writer.writeBool(offsets[23], object.userConfirmed);
  writer.writeString(offsets[24], object.zombieReason);
}

SubscriptionModel _subscriptionModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SubscriptionModel();
  object.amount = reader.readDouble(offsets[0]);
  object.averageDaysBetweenCharges = reader.readDoubleOrNull(offsets[1]);
  object.category = reader.readStringOrNull(offsets[2]);
  object.categoryId = reader.readLongOrNull(offsets[3]);
  object.chargeCount = reader.readLong(offsets[4]);
  object.createdAt = reader.readDateTime(offsets[5]);
  object.currency = reader.readString(offsets[6]);
  object.cycleHistoryJson = reader.readStringOrNull(offsets[7]);
  object.detectionSource = _SubscriptionModeldetectionSourceValueEnumMap[
          reader.readByteOrNull(offsets[8])] ??
      SubscriptionDetectionSource.email;
  object.firstSeenDate = reader.readDateTime(offsets[9]);
  object.frequency = _SubscriptionModelfrequencyValueEnumMap[
          reader.readByteOrNull(offsets[10])] ??
      SubscriptionFrequency.weekly;
  object.frequencyConsistency = reader.readLong(offsets[11]);
  object.id = id;
  object.isTrial = reader.readBool(offsets[12]);
  object.isZombie = reader.readBool(offsets[13]);
  object.lastChargedDate = reader.readDateTimeOrNull(offsets[14]);
  object.lastPriceHikePercent = reader.readDoubleOrNull(offsets[15]);
  object.lifecycleState = _SubscriptionModellifecycleStateValueEnumMap[
          reader.readByteOrNull(offsets[16])] ??
      SubscriptionLifecycleState.active;
  object.nextRenewalDate = reader.readDateTime(offsets[17]);
  object.notes = reader.readStringOrNull(offsets[18]);
  object.priceHistoryJson = reader.readStringOrNull(offsets[19]);
  object.serviceName = reader.readString(offsets[20]);
  object.trialEndDate = reader.readDateTimeOrNull(offsets[21]);
  object.updatedAt = reader.readDateTimeOrNull(offsets[22]);
  object.userConfirmed = reader.readBool(offsets[23]);
  object.zombieReason = reader.readStringOrNull(offsets[24]);
  return object;
}

P _subscriptionModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readDoubleOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readDateTime(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (_SubscriptionModeldetectionSourceValueEnumMap[
              reader.readByteOrNull(offset)] ??
          SubscriptionDetectionSource.email) as P;
    case 9:
      return (reader.readDateTime(offset)) as P;
    case 10:
      return (_SubscriptionModelfrequencyValueEnumMap[
              reader.readByteOrNull(offset)] ??
          SubscriptionFrequency.weekly) as P;
    case 11:
      return (reader.readLong(offset)) as P;
    case 12:
      return (reader.readBool(offset)) as P;
    case 13:
      return (reader.readBool(offset)) as P;
    case 14:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 15:
      return (reader.readDoubleOrNull(offset)) as P;
    case 16:
      return (_SubscriptionModellifecycleStateValueEnumMap[
              reader.readByteOrNull(offset)] ??
          SubscriptionLifecycleState.active) as P;
    case 17:
      return (reader.readDateTime(offset)) as P;
    case 18:
      return (reader.readStringOrNull(offset)) as P;
    case 19:
      return (reader.readStringOrNull(offset)) as P;
    case 20:
      return (reader.readString(offset)) as P;
    case 21:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 22:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 23:
      return (reader.readBool(offset)) as P;
    case 24:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _SubscriptionModeldetectionSourceEnumValueMap = {
  'email': 0,
  'manual': 1,
  'pattern': 2,
  'keyword': 3,
};
const _SubscriptionModeldetectionSourceValueEnumMap = {
  0: SubscriptionDetectionSource.email,
  1: SubscriptionDetectionSource.manual,
  2: SubscriptionDetectionSource.pattern,
  3: SubscriptionDetectionSource.keyword,
};
const _SubscriptionModelfrequencyEnumValueMap = {
  'weekly': 0,
  'biweekly': 1,
  'monthly': 2,
  'quarterly': 3,
  'semiannual': 4,
  'yearly': 5,
  'unknown': 6,
};
const _SubscriptionModelfrequencyValueEnumMap = {
  0: SubscriptionFrequency.weekly,
  1: SubscriptionFrequency.biweekly,
  2: SubscriptionFrequency.monthly,
  3: SubscriptionFrequency.quarterly,
  4: SubscriptionFrequency.semiannual,
  5: SubscriptionFrequency.yearly,
  6: SubscriptionFrequency.unknown,
};
const _SubscriptionModellifecycleStateEnumValueMap = {
  'active': 0,
  'trial': 1,
  'paused': 2,
  'ended': 3,
  'cancelled': 4,
};
const _SubscriptionModellifecycleStateValueEnumMap = {
  0: SubscriptionLifecycleState.active,
  1: SubscriptionLifecycleState.trial,
  2: SubscriptionLifecycleState.paused,
  3: SubscriptionLifecycleState.ended,
  4: SubscriptionLifecycleState.cancelled,
};

Id _subscriptionModelGetId(SubscriptionModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _subscriptionModelGetLinks(
    SubscriptionModel object) {
  return [];
}

void _subscriptionModelAttach(
    IsarCollection<dynamic> col, Id id, SubscriptionModel object) {
  object.id = id;
}

extension SubscriptionModelQueryWhereSort
    on QueryBuilder<SubscriptionModel, SubscriptionModel, QWhere> {
  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterWhere>
      anyFirstSeenDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'firstSeenDate'),
      );
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterWhere>
      anyCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'createdAt'),
      );
    });
  }
}

extension SubscriptionModelQueryWhere
    on QueryBuilder<SubscriptionModel, SubscriptionModel, QWhereClause> {
  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterWhereClause>
      idNotEqualTo(Id id) {
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

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterWhereClause>
      idBetween(
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

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterWhereClause>
      serviceNameEqualTo(String serviceName) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'serviceName',
        value: [serviceName],
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterWhereClause>
      serviceNameNotEqualTo(String serviceName) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'serviceName',
              lower: [],
              upper: [serviceName],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'serviceName',
              lower: [serviceName],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'serviceName',
              lower: [serviceName],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'serviceName',
              lower: [],
              upper: [serviceName],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterWhereClause>
      firstSeenDateEqualTo(DateTime firstSeenDate) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'firstSeenDate',
        value: [firstSeenDate],
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterWhereClause>
      firstSeenDateNotEqualTo(DateTime firstSeenDate) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'firstSeenDate',
              lower: [],
              upper: [firstSeenDate],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'firstSeenDate',
              lower: [firstSeenDate],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'firstSeenDate',
              lower: [firstSeenDate],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'firstSeenDate',
              lower: [],
              upper: [firstSeenDate],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterWhereClause>
      firstSeenDateGreaterThan(
    DateTime firstSeenDate, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'firstSeenDate',
        lower: [firstSeenDate],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterWhereClause>
      firstSeenDateLessThan(
    DateTime firstSeenDate, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'firstSeenDate',
        lower: [],
        upper: [firstSeenDate],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterWhereClause>
      firstSeenDateBetween(
    DateTime lowerFirstSeenDate,
    DateTime upperFirstSeenDate, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'firstSeenDate',
        lower: [lowerFirstSeenDate],
        includeLower: includeLower,
        upper: [upperFirstSeenDate],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterWhereClause>
      createdAtEqualTo(DateTime createdAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'createdAt',
        value: [createdAt],
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterWhereClause>
      createdAtNotEqualTo(DateTime createdAt) {
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

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterWhereClause>
      createdAtGreaterThan(
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

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterWhereClause>
      createdAtLessThan(
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

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterWhereClause>
      createdAtBetween(
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

extension SubscriptionModelQueryFilter
    on QueryBuilder<SubscriptionModel, SubscriptionModel, QFilterCondition> {
  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      amountEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'amount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      amountGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'amount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      amountLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'amount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      amountBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'amount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      averageDaysBetweenChargesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'averageDaysBetweenCharges',
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      averageDaysBetweenChargesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'averageDaysBetweenCharges',
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      averageDaysBetweenChargesEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'averageDaysBetweenCharges',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      averageDaysBetweenChargesGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'averageDaysBetweenCharges',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      averageDaysBetweenChargesLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'averageDaysBetweenCharges',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      averageDaysBetweenChargesBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'averageDaysBetweenCharges',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      categoryIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'category',
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      categoryIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'category',
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      categoryEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      categoryGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      categoryLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      categoryBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'category',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      categoryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      categoryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      categoryContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      categoryMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'category',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      categoryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      categoryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      categoryIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'categoryId',
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      categoryIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'categoryId',
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      categoryIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'categoryId',
        value: value,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      categoryIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'categoryId',
        value: value,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      categoryIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'categoryId',
        value: value,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      categoryIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'categoryId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      chargeCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'chargeCount',
        value: value,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      chargeCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'chargeCount',
        value: value,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      chargeCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'chargeCount',
        value: value,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      chargeCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'chargeCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      createdAtGreaterThan(
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

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      createdAtLessThan(
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

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      createdAtBetween(
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

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      currencyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      currencyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'currency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      currencyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'currency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      currencyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'currency',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      currencyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'currency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      currencyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'currency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      currencyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'currency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      currencyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'currency',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      currencyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currency',
        value: '',
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      currencyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'currency',
        value: '',
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      cycleHistoryJsonIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'cycleHistoryJson',
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      cycleHistoryJsonIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'cycleHistoryJson',
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      cycleHistoryJsonEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cycleHistoryJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      cycleHistoryJsonGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cycleHistoryJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      cycleHistoryJsonLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cycleHistoryJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      cycleHistoryJsonBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cycleHistoryJson',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      cycleHistoryJsonStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'cycleHistoryJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      cycleHistoryJsonEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'cycleHistoryJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      cycleHistoryJsonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'cycleHistoryJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      cycleHistoryJsonMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'cycleHistoryJson',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      cycleHistoryJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cycleHistoryJson',
        value: '',
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      cycleHistoryJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'cycleHistoryJson',
        value: '',
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      detectionSourceEqualTo(SubscriptionDetectionSource value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'detectionSource',
        value: value,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      detectionSourceGreaterThan(
    SubscriptionDetectionSource value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'detectionSource',
        value: value,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      detectionSourceLessThan(
    SubscriptionDetectionSource value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'detectionSource',
        value: value,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      detectionSourceBetween(
    SubscriptionDetectionSource lower,
    SubscriptionDetectionSource upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'detectionSource',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      firstSeenDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'firstSeenDate',
        value: value,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      firstSeenDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'firstSeenDate',
        value: value,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      firstSeenDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'firstSeenDate',
        value: value,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      firstSeenDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'firstSeenDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      frequencyEqualTo(SubscriptionFrequency value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'frequency',
        value: value,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      frequencyGreaterThan(
    SubscriptionFrequency value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'frequency',
        value: value,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      frequencyLessThan(
    SubscriptionFrequency value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'frequency',
        value: value,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      frequencyBetween(
    SubscriptionFrequency lower,
    SubscriptionFrequency upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'frequency',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      frequencyConsistencyEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'frequencyConsistency',
        value: value,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      frequencyConsistencyGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'frequencyConsistency',
        value: value,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      frequencyConsistencyLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'frequencyConsistency',
        value: value,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      frequencyConsistencyBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'frequencyConsistency',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      isTrialEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isTrial',
        value: value,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      isZombieEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isZombie',
        value: value,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      lastChargedDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastChargedDate',
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      lastChargedDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastChargedDate',
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      lastChargedDateEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastChargedDate',
        value: value,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      lastChargedDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastChargedDate',
        value: value,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      lastChargedDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastChargedDate',
        value: value,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      lastChargedDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastChargedDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      lastPriceHikePercentIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastPriceHikePercent',
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      lastPriceHikePercentIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastPriceHikePercent',
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      lastPriceHikePercentEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastPriceHikePercent',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      lastPriceHikePercentGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastPriceHikePercent',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      lastPriceHikePercentLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastPriceHikePercent',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      lastPriceHikePercentBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastPriceHikePercent',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      lifecycleStateEqualTo(SubscriptionLifecycleState value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lifecycleState',
        value: value,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      lifecycleStateGreaterThan(
    SubscriptionLifecycleState value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lifecycleState',
        value: value,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      lifecycleStateLessThan(
    SubscriptionLifecycleState value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lifecycleState',
        value: value,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      lifecycleStateBetween(
    SubscriptionLifecycleState lower,
    SubscriptionLifecycleState upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lifecycleState',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      nextRenewalDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nextRenewalDate',
        value: value,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      nextRenewalDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nextRenewalDate',
        value: value,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      nextRenewalDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nextRenewalDate',
        value: value,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      nextRenewalDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nextRenewalDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      notesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'notes',
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      notesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'notes',
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      notesEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      notesGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      notesLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      notesBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'notes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      notesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      notesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      notesContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      notesMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'notes',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      notesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      notesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      priceHistoryJsonIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'priceHistoryJson',
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      priceHistoryJsonIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'priceHistoryJson',
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      priceHistoryJsonEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'priceHistoryJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      priceHistoryJsonGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'priceHistoryJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      priceHistoryJsonLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'priceHistoryJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      priceHistoryJsonBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'priceHistoryJson',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      priceHistoryJsonStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'priceHistoryJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      priceHistoryJsonEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'priceHistoryJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      priceHistoryJsonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'priceHistoryJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      priceHistoryJsonMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'priceHistoryJson',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      priceHistoryJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'priceHistoryJson',
        value: '',
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      priceHistoryJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'priceHistoryJson',
        value: '',
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      serviceNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'serviceName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      serviceNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'serviceName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      serviceNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'serviceName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      serviceNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'serviceName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      serviceNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'serviceName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      serviceNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'serviceName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      serviceNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'serviceName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      serviceNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'serviceName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      serviceNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'serviceName',
        value: '',
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      serviceNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'serviceName',
        value: '',
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      trialEndDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'trialEndDate',
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      trialEndDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'trialEndDate',
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      trialEndDateEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'trialEndDate',
        value: value,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      trialEndDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'trialEndDate',
        value: value,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      trialEndDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'trialEndDate',
        value: value,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      trialEndDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'trialEndDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      updatedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'updatedAt',
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      updatedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'updatedAt',
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      updatedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      updatedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      updatedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      updatedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      userConfirmedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userConfirmed',
        value: value,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      zombieReasonIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'zombieReason',
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      zombieReasonIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'zombieReason',
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      zombieReasonEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'zombieReason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      zombieReasonGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'zombieReason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      zombieReasonLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'zombieReason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      zombieReasonBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'zombieReason',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      zombieReasonStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'zombieReason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      zombieReasonEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'zombieReason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      zombieReasonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'zombieReason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      zombieReasonMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'zombieReason',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      zombieReasonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'zombieReason',
        value: '',
      ));
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterFilterCondition>
      zombieReasonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'zombieReason',
        value: '',
      ));
    });
  }
}

extension SubscriptionModelQueryObject
    on QueryBuilder<SubscriptionModel, SubscriptionModel, QFilterCondition> {}

extension SubscriptionModelQueryLinks
    on QueryBuilder<SubscriptionModel, SubscriptionModel, QFilterCondition> {}

extension SubscriptionModelQuerySortBy
    on QueryBuilder<SubscriptionModel, SubscriptionModel, QSortBy> {
  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      sortByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      sortByAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      sortByAverageDaysBetweenCharges() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'averageDaysBetweenCharges', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      sortByAverageDaysBetweenChargesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'averageDaysBetweenCharges', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      sortByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      sortByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      sortByCategoryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      sortByCategoryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      sortByChargeCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chargeCount', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      sortByChargeCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chargeCount', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      sortByCurrency() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currency', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      sortByCurrencyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currency', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      sortByCycleHistoryJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cycleHistoryJson', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      sortByCycleHistoryJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cycleHistoryJson', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      sortByDetectionSource() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'detectionSource', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      sortByDetectionSourceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'detectionSource', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      sortByFirstSeenDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firstSeenDate', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      sortByFirstSeenDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firstSeenDate', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      sortByFrequency() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frequency', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      sortByFrequencyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frequency', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      sortByFrequencyConsistency() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frequencyConsistency', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      sortByFrequencyConsistencyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frequencyConsistency', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      sortByIsTrial() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isTrial', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      sortByIsTrialDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isTrial', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      sortByIsZombie() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isZombie', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      sortByIsZombieDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isZombie', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      sortByLastChargedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastChargedDate', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      sortByLastChargedDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastChargedDate', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      sortByLastPriceHikePercent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastPriceHikePercent', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      sortByLastPriceHikePercentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastPriceHikePercent', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      sortByLifecycleState() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lifecycleState', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      sortByLifecycleStateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lifecycleState', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      sortByNextRenewalDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextRenewalDate', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      sortByNextRenewalDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextRenewalDate', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      sortByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      sortByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      sortByPriceHistoryJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priceHistoryJson', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      sortByPriceHistoryJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priceHistoryJson', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      sortByServiceName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serviceName', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      sortByServiceNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serviceName', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      sortByTrialEndDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trialEndDate', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      sortByTrialEndDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trialEndDate', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      sortByUserConfirmed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userConfirmed', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      sortByUserConfirmedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userConfirmed', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      sortByZombieReason() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'zombieReason', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      sortByZombieReasonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'zombieReason', Sort.desc);
    });
  }
}

extension SubscriptionModelQuerySortThenBy
    on QueryBuilder<SubscriptionModel, SubscriptionModel, QSortThenBy> {
  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      thenByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      thenByAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      thenByAverageDaysBetweenCharges() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'averageDaysBetweenCharges', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      thenByAverageDaysBetweenChargesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'averageDaysBetweenCharges', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      thenByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      thenByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      thenByCategoryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      thenByCategoryIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoryId', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      thenByChargeCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chargeCount', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      thenByChargeCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chargeCount', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      thenByCurrency() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currency', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      thenByCurrencyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currency', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      thenByCycleHistoryJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cycleHistoryJson', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      thenByCycleHistoryJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cycleHistoryJson', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      thenByDetectionSource() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'detectionSource', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      thenByDetectionSourceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'detectionSource', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      thenByFirstSeenDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firstSeenDate', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      thenByFirstSeenDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firstSeenDate', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      thenByFrequency() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frequency', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      thenByFrequencyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frequency', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      thenByFrequencyConsistency() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frequencyConsistency', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      thenByFrequencyConsistencyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frequencyConsistency', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      thenByIsTrial() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isTrial', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      thenByIsTrialDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isTrial', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      thenByIsZombie() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isZombie', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      thenByIsZombieDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isZombie', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      thenByLastChargedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastChargedDate', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      thenByLastChargedDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastChargedDate', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      thenByLastPriceHikePercent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastPriceHikePercent', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      thenByLastPriceHikePercentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastPriceHikePercent', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      thenByLifecycleState() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lifecycleState', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      thenByLifecycleStateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lifecycleState', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      thenByNextRenewalDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextRenewalDate', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      thenByNextRenewalDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextRenewalDate', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      thenByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      thenByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      thenByPriceHistoryJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priceHistoryJson', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      thenByPriceHistoryJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priceHistoryJson', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      thenByServiceName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serviceName', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      thenByServiceNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serviceName', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      thenByTrialEndDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trialEndDate', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      thenByTrialEndDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trialEndDate', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      thenByUserConfirmed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userConfirmed', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      thenByUserConfirmedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userConfirmed', Sort.desc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      thenByZombieReason() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'zombieReason', Sort.asc);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QAfterSortBy>
      thenByZombieReasonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'zombieReason', Sort.desc);
    });
  }
}

extension SubscriptionModelQueryWhereDistinct
    on QueryBuilder<SubscriptionModel, SubscriptionModel, QDistinct> {
  QueryBuilder<SubscriptionModel, SubscriptionModel, QDistinct>
      distinctByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'amount');
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QDistinct>
      distinctByAverageDaysBetweenCharges() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'averageDaysBetweenCharges');
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QDistinct>
      distinctByCategory({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'category', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QDistinct>
      distinctByCategoryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'categoryId');
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QDistinct>
      distinctByChargeCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'chargeCount');
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QDistinct>
      distinctByCurrency({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currency', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QDistinct>
      distinctByCycleHistoryJson({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cycleHistoryJson',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QDistinct>
      distinctByDetectionSource() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'detectionSource');
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QDistinct>
      distinctByFirstSeenDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'firstSeenDate');
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QDistinct>
      distinctByFrequency() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'frequency');
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QDistinct>
      distinctByFrequencyConsistency() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'frequencyConsistency');
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QDistinct>
      distinctByIsTrial() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isTrial');
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QDistinct>
      distinctByIsZombie() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isZombie');
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QDistinct>
      distinctByLastChargedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastChargedDate');
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QDistinct>
      distinctByLastPriceHikePercent() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastPriceHikePercent');
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QDistinct>
      distinctByLifecycleState() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lifecycleState');
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QDistinct>
      distinctByNextRenewalDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nextRenewalDate');
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QDistinct> distinctByNotes(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notes', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QDistinct>
      distinctByPriceHistoryJson({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'priceHistoryJson',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QDistinct>
      distinctByServiceName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'serviceName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QDistinct>
      distinctByTrialEndDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'trialEndDate');
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QDistinct>
      distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QDistinct>
      distinctByUserConfirmed() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userConfirmed');
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionModel, QDistinct>
      distinctByZombieReason({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'zombieReason', caseSensitive: caseSensitive);
    });
  }
}

extension SubscriptionModelQueryProperty
    on QueryBuilder<SubscriptionModel, SubscriptionModel, QQueryProperty> {
  QueryBuilder<SubscriptionModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<SubscriptionModel, double, QQueryOperations> amountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'amount');
    });
  }

  QueryBuilder<SubscriptionModel, double?, QQueryOperations>
      averageDaysBetweenChargesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'averageDaysBetweenCharges');
    });
  }

  QueryBuilder<SubscriptionModel, String?, QQueryOperations>
      categoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'category');
    });
  }

  QueryBuilder<SubscriptionModel, int?, QQueryOperations> categoryIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'categoryId');
    });
  }

  QueryBuilder<SubscriptionModel, int, QQueryOperations> chargeCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'chargeCount');
    });
  }

  QueryBuilder<SubscriptionModel, DateTime, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<SubscriptionModel, String, QQueryOperations> currencyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currency');
    });
  }

  QueryBuilder<SubscriptionModel, String?, QQueryOperations>
      cycleHistoryJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cycleHistoryJson');
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionDetectionSource, QQueryOperations>
      detectionSourceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'detectionSource');
    });
  }

  QueryBuilder<SubscriptionModel, DateTime, QQueryOperations>
      firstSeenDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'firstSeenDate');
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionFrequency, QQueryOperations>
      frequencyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'frequency');
    });
  }

  QueryBuilder<SubscriptionModel, int, QQueryOperations>
      frequencyConsistencyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'frequencyConsistency');
    });
  }

  QueryBuilder<SubscriptionModel, bool, QQueryOperations> isTrialProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isTrial');
    });
  }

  QueryBuilder<SubscriptionModel, bool, QQueryOperations> isZombieProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isZombie');
    });
  }

  QueryBuilder<SubscriptionModel, DateTime?, QQueryOperations>
      lastChargedDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastChargedDate');
    });
  }

  QueryBuilder<SubscriptionModel, double?, QQueryOperations>
      lastPriceHikePercentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastPriceHikePercent');
    });
  }

  QueryBuilder<SubscriptionModel, SubscriptionLifecycleState, QQueryOperations>
      lifecycleStateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lifecycleState');
    });
  }

  QueryBuilder<SubscriptionModel, DateTime, QQueryOperations>
      nextRenewalDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nextRenewalDate');
    });
  }

  QueryBuilder<SubscriptionModel, String?, QQueryOperations> notesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notes');
    });
  }

  QueryBuilder<SubscriptionModel, String?, QQueryOperations>
      priceHistoryJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'priceHistoryJson');
    });
  }

  QueryBuilder<SubscriptionModel, String, QQueryOperations>
      serviceNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'serviceName');
    });
  }

  QueryBuilder<SubscriptionModel, DateTime?, QQueryOperations>
      trialEndDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'trialEndDate');
    });
  }

  QueryBuilder<SubscriptionModel, DateTime?, QQueryOperations>
      updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }

  QueryBuilder<SubscriptionModel, bool, QQueryOperations>
      userConfirmedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userConfirmed');
    });
  }

  QueryBuilder<SubscriptionModel, String?, QQueryOperations>
      zombieReasonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'zombieReason');
    });
  }
}
