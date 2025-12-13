// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extraction_metadata_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetExtractionMetadataModelCollection on Isar {
  IsarCollection<ExtractionMetadataModel> get extractionMetadataModels =>
      this.collection();
}

const ExtractionMetadataModelSchema = CollectionSchema(
  name: r'ExtractionMetadataModel',
  id: -8927135143434382525,
  properties: {
    r'amountConfidence': PropertySchema(
      id: 0,
      name: r'amountConfidence',
      type: IsarType.byte,
      enumMap: _ExtractionMetadataModelamountConfidenceEnumValueMap,
    ),
    r'dateConfidence': PropertySchema(
      id: 1,
      name: r'dateConfidence',
      type: IsarType.byte,
      enumMap: _ExtractionMetadataModeldateConfidenceEnumValueMap,
    ),
    r'emailSender': PropertySchema(
      id: 2,
      name: r'emailSender',
      type: IsarType.string,
    ),
    r'emailSubject': PropertySchema(
      id: 3,
      name: r'emailSubject',
      type: IsarType.string,
    ),
    r'extractedAt': PropertySchema(
      id: 4,
      name: r'extractedAt',
      type: IsarType.dateTime,
    ),
    r'extractionMethod': PropertySchema(
      id: 5,
      name: r'extractionMethod',
      type: IsarType.string,
    ),
    r'hasLineItems': PropertySchema(
      id: 6,
      name: r'hasLineItems',
      type: IsarType.bool,
    ),
    r'lineItemCount': PropertySchema(
      id: 7,
      name: r'lineItemCount',
      type: IsarType.long,
    ),
    r'merchantConfidence': PropertySchema(
      id: 8,
      name: r'merchantConfidence',
      type: IsarType.byte,
      enumMap: _ExtractionMetadataModelmerchantConfidenceEnumValueMap,
    ),
    r'notes': PropertySchema(
      id: 9,
      name: r'notes',
      type: IsarType.string,
    ),
    r'overallConfidence': PropertySchema(
      id: 10,
      name: r'overallConfidence',
      type: IsarType.byte,
      enumMap: _ExtractionMetadataModeloverallConfidenceEnumValueMap,
    ),
    r'transactionId': PropertySchema(
      id: 11,
      name: r'transactionId',
      type: IsarType.long,
    ),
    r'userVerified': PropertySchema(
      id: 12,
      name: r'userVerified',
      type: IsarType.bool,
    )
  },
  estimateSize: _extractionMetadataModelEstimateSize,
  serialize: _extractionMetadataModelSerialize,
  deserialize: _extractionMetadataModelDeserialize,
  deserializeProp: _extractionMetadataModelDeserializeProp,
  idName: r'id',
  indexes: {
    r'transactionId': IndexSchema(
      id: 8561542235958051982,
      name: r'transactionId',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'transactionId',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'extractedAt': IndexSchema(
      id: -5952822171797589976,
      name: r'extractedAt',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'extractedAt',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _extractionMetadataModelGetId,
  getLinks: _extractionMetadataModelGetLinks,
  attach: _extractionMetadataModelAttach,
  version: '3.1.0+1',
);

int _extractionMetadataModelEstimateSize(
  ExtractionMetadataModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.emailSender;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.emailSubject;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.extractionMethod;
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
  return bytesCount;
}

void _extractionMetadataModelSerialize(
  ExtractionMetadataModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeByte(offsets[0], object.amountConfidence.index);
  writer.writeByte(offsets[1], object.dateConfidence.index);
  writer.writeString(offsets[2], object.emailSender);
  writer.writeString(offsets[3], object.emailSubject);
  writer.writeDateTime(offsets[4], object.extractedAt);
  writer.writeString(offsets[5], object.extractionMethod);
  writer.writeBool(offsets[6], object.hasLineItems);
  writer.writeLong(offsets[7], object.lineItemCount);
  writer.writeByte(offsets[8], object.merchantConfidence.index);
  writer.writeString(offsets[9], object.notes);
  writer.writeByte(offsets[10], object.overallConfidence.index);
  writer.writeLong(offsets[11], object.transactionId);
  writer.writeBool(offsets[12], object.userVerified);
}

ExtractionMetadataModel _extractionMetadataModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ExtractionMetadataModel();
  object.amountConfidence =
      _ExtractionMetadataModelamountConfidenceValueEnumMap[
              reader.readByteOrNull(offsets[0])] ??
          ConfidenceLevel.high;
  object.dateConfidence = _ExtractionMetadataModeldateConfidenceValueEnumMap[
          reader.readByteOrNull(offsets[1])] ??
      ConfidenceLevel.high;
  object.emailSender = reader.readStringOrNull(offsets[2]);
  object.emailSubject = reader.readStringOrNull(offsets[3]);
  object.extractedAt = reader.readDateTime(offsets[4]);
  object.extractionMethod = reader.readStringOrNull(offsets[5]);
  object.hasLineItems = reader.readBool(offsets[6]);
  object.id = id;
  object.lineItemCount = reader.readLong(offsets[7]);
  object.merchantConfidence =
      _ExtractionMetadataModelmerchantConfidenceValueEnumMap[
              reader.readByteOrNull(offsets[8])] ??
          ConfidenceLevel.high;
  object.notes = reader.readStringOrNull(offsets[9]);
  object.overallConfidence =
      _ExtractionMetadataModeloverallConfidenceValueEnumMap[
              reader.readByteOrNull(offsets[10])] ??
          ConfidenceLevel.high;
  object.transactionId = reader.readLong(offsets[11]);
  object.userVerified = reader.readBool(offsets[12]);
  return object;
}

P _extractionMetadataModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (_ExtractionMetadataModelamountConfidenceValueEnumMap[
              reader.readByteOrNull(offset)] ??
          ConfidenceLevel.high) as P;
    case 1:
      return (_ExtractionMetadataModeldateConfidenceValueEnumMap[
              reader.readByteOrNull(offset)] ??
          ConfidenceLevel.high) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readDateTime(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readBool(offset)) as P;
    case 7:
      return (reader.readLong(offset)) as P;
    case 8:
      return (_ExtractionMetadataModelmerchantConfidenceValueEnumMap[
              reader.readByteOrNull(offset)] ??
          ConfidenceLevel.high) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (_ExtractionMetadataModeloverallConfidenceValueEnumMap[
              reader.readByteOrNull(offset)] ??
          ConfidenceLevel.high) as P;
    case 11:
      return (reader.readLong(offset)) as P;
    case 12:
      return (reader.readBool(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _ExtractionMetadataModelamountConfidenceEnumValueMap = {
  'high': 0,
  'medium': 1,
  'low': 2,
};
const _ExtractionMetadataModelamountConfidenceValueEnumMap = {
  0: ConfidenceLevel.high,
  1: ConfidenceLevel.medium,
  2: ConfidenceLevel.low,
};
const _ExtractionMetadataModeldateConfidenceEnumValueMap = {
  'high': 0,
  'medium': 1,
  'low': 2,
};
const _ExtractionMetadataModeldateConfidenceValueEnumMap = {
  0: ConfidenceLevel.high,
  1: ConfidenceLevel.medium,
  2: ConfidenceLevel.low,
};
const _ExtractionMetadataModelmerchantConfidenceEnumValueMap = {
  'high': 0,
  'medium': 1,
  'low': 2,
};
const _ExtractionMetadataModelmerchantConfidenceValueEnumMap = {
  0: ConfidenceLevel.high,
  1: ConfidenceLevel.medium,
  2: ConfidenceLevel.low,
};
const _ExtractionMetadataModeloverallConfidenceEnumValueMap = {
  'high': 0,
  'medium': 1,
  'low': 2,
};
const _ExtractionMetadataModeloverallConfidenceValueEnumMap = {
  0: ConfidenceLevel.high,
  1: ConfidenceLevel.medium,
  2: ConfidenceLevel.low,
};

Id _extractionMetadataModelGetId(ExtractionMetadataModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _extractionMetadataModelGetLinks(
    ExtractionMetadataModel object) {
  return [];
}

void _extractionMetadataModelAttach(
    IsarCollection<dynamic> col, Id id, ExtractionMetadataModel object) {
  object.id = id;
}

extension ExtractionMetadataModelByIndex
    on IsarCollection<ExtractionMetadataModel> {
  Future<ExtractionMetadataModel?> getByTransactionId(int transactionId) {
    return getByIndex(r'transactionId', [transactionId]);
  }

  ExtractionMetadataModel? getByTransactionIdSync(int transactionId) {
    return getByIndexSync(r'transactionId', [transactionId]);
  }

  Future<bool> deleteByTransactionId(int transactionId) {
    return deleteByIndex(r'transactionId', [transactionId]);
  }

  bool deleteByTransactionIdSync(int transactionId) {
    return deleteByIndexSync(r'transactionId', [transactionId]);
  }

  Future<List<ExtractionMetadataModel?>> getAllByTransactionId(
      List<int> transactionIdValues) {
    final values = transactionIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'transactionId', values);
  }

  List<ExtractionMetadataModel?> getAllByTransactionIdSync(
      List<int> transactionIdValues) {
    final values = transactionIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'transactionId', values);
  }

  Future<int> deleteAllByTransactionId(List<int> transactionIdValues) {
    final values = transactionIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'transactionId', values);
  }

  int deleteAllByTransactionIdSync(List<int> transactionIdValues) {
    final values = transactionIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'transactionId', values);
  }

  Future<Id> putByTransactionId(ExtractionMetadataModel object) {
    return putByIndex(r'transactionId', object);
  }

  Id putByTransactionIdSync(ExtractionMetadataModel object,
      {bool saveLinks = true}) {
    return putByIndexSync(r'transactionId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByTransactionId(
      List<ExtractionMetadataModel> objects) {
    return putAllByIndex(r'transactionId', objects);
  }

  List<Id> putAllByTransactionIdSync(List<ExtractionMetadataModel> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'transactionId', objects, saveLinks: saveLinks);
  }
}

extension ExtractionMetadataModelQueryWhereSort
    on QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel, QWhere> {
  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel, QAfterWhere>
      anyTransactionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'transactionId'),
      );
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel, QAfterWhere>
      anyExtractedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'extractedAt'),
      );
    });
  }
}

extension ExtractionMetadataModelQueryWhere on QueryBuilder<
    ExtractionMetadataModel, ExtractionMetadataModel, QWhereClause> {
  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
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

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterWhereClause> idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterWhereClause> idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
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

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterWhereClause> transactionIdEqualTo(int transactionId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'transactionId',
        value: [transactionId],
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterWhereClause> transactionIdNotEqualTo(int transactionId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'transactionId',
              lower: [],
              upper: [transactionId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'transactionId',
              lower: [transactionId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'transactionId',
              lower: [transactionId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'transactionId',
              lower: [],
              upper: [transactionId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterWhereClause> transactionIdGreaterThan(
    int transactionId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'transactionId',
        lower: [transactionId],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterWhereClause> transactionIdLessThan(
    int transactionId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'transactionId',
        lower: [],
        upper: [transactionId],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterWhereClause> transactionIdBetween(
    int lowerTransactionId,
    int upperTransactionId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'transactionId',
        lower: [lowerTransactionId],
        includeLower: includeLower,
        upper: [upperTransactionId],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterWhereClause> extractedAtEqualTo(DateTime extractedAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'extractedAt',
        value: [extractedAt],
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterWhereClause> extractedAtNotEqualTo(DateTime extractedAt) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'extractedAt',
              lower: [],
              upper: [extractedAt],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'extractedAt',
              lower: [extractedAt],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'extractedAt',
              lower: [extractedAt],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'extractedAt',
              lower: [],
              upper: [extractedAt],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterWhereClause> extractedAtGreaterThan(
    DateTime extractedAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'extractedAt',
        lower: [extractedAt],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterWhereClause> extractedAtLessThan(
    DateTime extractedAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'extractedAt',
        lower: [],
        upper: [extractedAt],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterWhereClause> extractedAtBetween(
    DateTime lowerExtractedAt,
    DateTime upperExtractedAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'extractedAt',
        lower: [lowerExtractedAt],
        includeLower: includeLower,
        upper: [upperExtractedAt],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ExtractionMetadataModelQueryFilter on QueryBuilder<
    ExtractionMetadataModel, ExtractionMetadataModel, QFilterCondition> {
  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterFilterCondition> amountConfidenceEqualTo(ConfidenceLevel value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'amountConfidence',
        value: value,
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterFilterCondition> amountConfidenceGreaterThan(
    ConfidenceLevel value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'amountConfidence',
        value: value,
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterFilterCondition> amountConfidenceLessThan(
    ConfidenceLevel value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'amountConfidence',
        value: value,
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterFilterCondition> amountConfidenceBetween(
    ConfidenceLevel lower,
    ConfidenceLevel upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'amountConfidence',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterFilterCondition> dateConfidenceEqualTo(ConfidenceLevel value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateConfidence',
        value: value,
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterFilterCondition> dateConfidenceGreaterThan(
    ConfidenceLevel value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dateConfidence',
        value: value,
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterFilterCondition> dateConfidenceLessThan(
    ConfidenceLevel value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dateConfidence',
        value: value,
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterFilterCondition> dateConfidenceBetween(
    ConfidenceLevel lower,
    ConfidenceLevel upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dateConfidence',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterFilterCondition> emailSenderIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'emailSender',
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterFilterCondition> emailSenderIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'emailSender',
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterFilterCondition> emailSenderEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'emailSender',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterFilterCondition> emailSenderGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'emailSender',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterFilterCondition> emailSenderLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'emailSender',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterFilterCondition> emailSenderBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'emailSender',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterFilterCondition> emailSenderStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'emailSender',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterFilterCondition> emailSenderEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'emailSender',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
          QAfterFilterCondition>
      emailSenderContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'emailSender',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
          QAfterFilterCondition>
      emailSenderMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'emailSender',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterFilterCondition> emailSenderIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'emailSender',
        value: '',
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterFilterCondition> emailSenderIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'emailSender',
        value: '',
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterFilterCondition> emailSubjectIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'emailSubject',
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterFilterCondition> emailSubjectIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'emailSubject',
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterFilterCondition> emailSubjectEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'emailSubject',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterFilterCondition> emailSubjectGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'emailSubject',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterFilterCondition> emailSubjectLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'emailSubject',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterFilterCondition> emailSubjectBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'emailSubject',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterFilterCondition> emailSubjectStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'emailSubject',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterFilterCondition> emailSubjectEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'emailSubject',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
          QAfterFilterCondition>
      emailSubjectContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'emailSubject',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
          QAfterFilterCondition>
      emailSubjectMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'emailSubject',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterFilterCondition> emailSubjectIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'emailSubject',
        value: '',
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterFilterCondition> emailSubjectIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'emailSubject',
        value: '',
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterFilterCondition> extractedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'extractedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterFilterCondition> extractedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'extractedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterFilterCondition> extractedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'extractedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterFilterCondition> extractedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'extractedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterFilterCondition> extractionMethodIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'extractionMethod',
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterFilterCondition> extractionMethodIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'extractionMethod',
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterFilterCondition> extractionMethodEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'extractionMethod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterFilterCondition> extractionMethodGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'extractionMethod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterFilterCondition> extractionMethodLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'extractionMethod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterFilterCondition> extractionMethodBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'extractionMethod',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterFilterCondition> extractionMethodStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'extractionMethod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterFilterCondition> extractionMethodEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'extractionMethod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
          QAfterFilterCondition>
      extractionMethodContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'extractionMethod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
          QAfterFilterCondition>
      extractionMethodMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'extractionMethod',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterFilterCondition> extractionMethodIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'extractionMethod',
        value: '',
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterFilterCondition> extractionMethodIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'extractionMethod',
        value: '',
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterFilterCondition> hasLineItemsEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hasLineItems',
        value: value,
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
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

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
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

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
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

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterFilterCondition> lineItemCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lineItemCount',
        value: value,
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterFilterCondition> lineItemCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lineItemCount',
        value: value,
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterFilterCondition> lineItemCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lineItemCount',
        value: value,
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterFilterCondition> lineItemCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lineItemCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterFilterCondition> merchantConfidenceEqualTo(ConfidenceLevel value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'merchantConfidence',
        value: value,
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterFilterCondition> merchantConfidenceGreaterThan(
    ConfidenceLevel value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'merchantConfidence',
        value: value,
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterFilterCondition> merchantConfidenceLessThan(
    ConfidenceLevel value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'merchantConfidence',
        value: value,
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterFilterCondition> merchantConfidenceBetween(
    ConfidenceLevel lower,
    ConfidenceLevel upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'merchantConfidence',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterFilterCondition> notesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'notes',
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterFilterCondition> notesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'notes',
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterFilterCondition> notesEqualTo(
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

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterFilterCondition> notesGreaterThan(
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

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterFilterCondition> notesLessThan(
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

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterFilterCondition> notesBetween(
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

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterFilterCondition> notesStartsWith(
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

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterFilterCondition> notesEndsWith(
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

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
          QAfterFilterCondition>
      notesContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
          QAfterFilterCondition>
      notesMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'notes',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterFilterCondition> notesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterFilterCondition> notesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterFilterCondition> overallConfidenceEqualTo(ConfidenceLevel value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'overallConfidence',
        value: value,
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterFilterCondition> overallConfidenceGreaterThan(
    ConfidenceLevel value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'overallConfidence',
        value: value,
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterFilterCondition> overallConfidenceLessThan(
    ConfidenceLevel value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'overallConfidence',
        value: value,
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterFilterCondition> overallConfidenceBetween(
    ConfidenceLevel lower,
    ConfidenceLevel upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'overallConfidence',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterFilterCondition> transactionIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'transactionId',
        value: value,
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterFilterCondition> transactionIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'transactionId',
        value: value,
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterFilterCondition> transactionIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'transactionId',
        value: value,
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterFilterCondition> transactionIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'transactionId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel,
      QAfterFilterCondition> userVerifiedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userVerified',
        value: value,
      ));
    });
  }
}

extension ExtractionMetadataModelQueryObject on QueryBuilder<
    ExtractionMetadataModel, ExtractionMetadataModel, QFilterCondition> {}

extension ExtractionMetadataModelQueryLinks on QueryBuilder<
    ExtractionMetadataModel, ExtractionMetadataModel, QFilterCondition> {}

extension ExtractionMetadataModelQuerySortBy
    on QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel, QSortBy> {
  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel, QAfterSortBy>
      sortByAmountConfidence() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amountConfidence', Sort.asc);
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel, QAfterSortBy>
      sortByAmountConfidenceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amountConfidence', Sort.desc);
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel, QAfterSortBy>
      sortByDateConfidence() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateConfidence', Sort.asc);
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel, QAfterSortBy>
      sortByDateConfidenceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateConfidence', Sort.desc);
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel, QAfterSortBy>
      sortByEmailSender() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emailSender', Sort.asc);
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel, QAfterSortBy>
      sortByEmailSenderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emailSender', Sort.desc);
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel, QAfterSortBy>
      sortByEmailSubject() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emailSubject', Sort.asc);
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel, QAfterSortBy>
      sortByEmailSubjectDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emailSubject', Sort.desc);
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel, QAfterSortBy>
      sortByExtractedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'extractedAt', Sort.asc);
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel, QAfterSortBy>
      sortByExtractedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'extractedAt', Sort.desc);
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel, QAfterSortBy>
      sortByExtractionMethod() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'extractionMethod', Sort.asc);
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel, QAfterSortBy>
      sortByExtractionMethodDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'extractionMethod', Sort.desc);
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel, QAfterSortBy>
      sortByHasLineItems() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasLineItems', Sort.asc);
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel, QAfterSortBy>
      sortByHasLineItemsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasLineItems', Sort.desc);
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel, QAfterSortBy>
      sortByLineItemCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lineItemCount', Sort.asc);
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel, QAfterSortBy>
      sortByLineItemCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lineItemCount', Sort.desc);
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel, QAfterSortBy>
      sortByMerchantConfidence() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'merchantConfidence', Sort.asc);
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel, QAfterSortBy>
      sortByMerchantConfidenceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'merchantConfidence', Sort.desc);
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel, QAfterSortBy>
      sortByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel, QAfterSortBy>
      sortByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel, QAfterSortBy>
      sortByOverallConfidence() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'overallConfidence', Sort.asc);
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel, QAfterSortBy>
      sortByOverallConfidenceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'overallConfidence', Sort.desc);
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel, QAfterSortBy>
      sortByTransactionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transactionId', Sort.asc);
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel, QAfterSortBy>
      sortByTransactionIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transactionId', Sort.desc);
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel, QAfterSortBy>
      sortByUserVerified() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userVerified', Sort.asc);
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel, QAfterSortBy>
      sortByUserVerifiedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userVerified', Sort.desc);
    });
  }
}

extension ExtractionMetadataModelQuerySortThenBy on QueryBuilder<
    ExtractionMetadataModel, ExtractionMetadataModel, QSortThenBy> {
  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel, QAfterSortBy>
      thenByAmountConfidence() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amountConfidence', Sort.asc);
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel, QAfterSortBy>
      thenByAmountConfidenceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amountConfidence', Sort.desc);
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel, QAfterSortBy>
      thenByDateConfidence() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateConfidence', Sort.asc);
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel, QAfterSortBy>
      thenByDateConfidenceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateConfidence', Sort.desc);
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel, QAfterSortBy>
      thenByEmailSender() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emailSender', Sort.asc);
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel, QAfterSortBy>
      thenByEmailSenderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emailSender', Sort.desc);
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel, QAfterSortBy>
      thenByEmailSubject() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emailSubject', Sort.asc);
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel, QAfterSortBy>
      thenByEmailSubjectDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emailSubject', Sort.desc);
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel, QAfterSortBy>
      thenByExtractedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'extractedAt', Sort.asc);
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel, QAfterSortBy>
      thenByExtractedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'extractedAt', Sort.desc);
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel, QAfterSortBy>
      thenByExtractionMethod() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'extractionMethod', Sort.asc);
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel, QAfterSortBy>
      thenByExtractionMethodDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'extractionMethod', Sort.desc);
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel, QAfterSortBy>
      thenByHasLineItems() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasLineItems', Sort.asc);
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel, QAfterSortBy>
      thenByHasLineItemsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasLineItems', Sort.desc);
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel, QAfterSortBy>
      thenByLineItemCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lineItemCount', Sort.asc);
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel, QAfterSortBy>
      thenByLineItemCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lineItemCount', Sort.desc);
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel, QAfterSortBy>
      thenByMerchantConfidence() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'merchantConfidence', Sort.asc);
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel, QAfterSortBy>
      thenByMerchantConfidenceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'merchantConfidence', Sort.desc);
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel, QAfterSortBy>
      thenByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel, QAfterSortBy>
      thenByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel, QAfterSortBy>
      thenByOverallConfidence() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'overallConfidence', Sort.asc);
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel, QAfterSortBy>
      thenByOverallConfidenceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'overallConfidence', Sort.desc);
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel, QAfterSortBy>
      thenByTransactionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transactionId', Sort.asc);
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel, QAfterSortBy>
      thenByTransactionIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transactionId', Sort.desc);
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel, QAfterSortBy>
      thenByUserVerified() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userVerified', Sort.asc);
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel, QAfterSortBy>
      thenByUserVerifiedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userVerified', Sort.desc);
    });
  }
}

extension ExtractionMetadataModelQueryWhereDistinct on QueryBuilder<
    ExtractionMetadataModel, ExtractionMetadataModel, QDistinct> {
  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel, QDistinct>
      distinctByAmountConfidence() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'amountConfidence');
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel, QDistinct>
      distinctByDateConfidence() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dateConfidence');
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel, QDistinct>
      distinctByEmailSender({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'emailSender', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel, QDistinct>
      distinctByEmailSubject({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'emailSubject', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel, QDistinct>
      distinctByExtractedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'extractedAt');
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel, QDistinct>
      distinctByExtractionMethod({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'extractionMethod',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel, QDistinct>
      distinctByHasLineItems() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hasLineItems');
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel, QDistinct>
      distinctByLineItemCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lineItemCount');
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel, QDistinct>
      distinctByMerchantConfidence() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'merchantConfidence');
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel, QDistinct>
      distinctByNotes({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notes', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel, QDistinct>
      distinctByOverallConfidence() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'overallConfidence');
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel, QDistinct>
      distinctByTransactionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'transactionId');
    });
  }

  QueryBuilder<ExtractionMetadataModel, ExtractionMetadataModel, QDistinct>
      distinctByUserVerified() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userVerified');
    });
  }
}

extension ExtractionMetadataModelQueryProperty on QueryBuilder<
    ExtractionMetadataModel, ExtractionMetadataModel, QQueryProperty> {
  QueryBuilder<ExtractionMetadataModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ExtractionMetadataModel, ConfidenceLevel, QQueryOperations>
      amountConfidenceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'amountConfidence');
    });
  }

  QueryBuilder<ExtractionMetadataModel, ConfidenceLevel, QQueryOperations>
      dateConfidenceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dateConfidence');
    });
  }

  QueryBuilder<ExtractionMetadataModel, String?, QQueryOperations>
      emailSenderProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'emailSender');
    });
  }

  QueryBuilder<ExtractionMetadataModel, String?, QQueryOperations>
      emailSubjectProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'emailSubject');
    });
  }

  QueryBuilder<ExtractionMetadataModel, DateTime, QQueryOperations>
      extractedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'extractedAt');
    });
  }

  QueryBuilder<ExtractionMetadataModel, String?, QQueryOperations>
      extractionMethodProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'extractionMethod');
    });
  }

  QueryBuilder<ExtractionMetadataModel, bool, QQueryOperations>
      hasLineItemsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hasLineItems');
    });
  }

  QueryBuilder<ExtractionMetadataModel, int, QQueryOperations>
      lineItemCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lineItemCount');
    });
  }

  QueryBuilder<ExtractionMetadataModel, ConfidenceLevel, QQueryOperations>
      merchantConfidenceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'merchantConfidence');
    });
  }

  QueryBuilder<ExtractionMetadataModel, String?, QQueryOperations>
      notesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notes');
    });
  }

  QueryBuilder<ExtractionMetadataModel, ConfidenceLevel, QQueryOperations>
      overallConfidenceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'overallConfidence');
    });
  }

  QueryBuilder<ExtractionMetadataModel, int, QQueryOperations>
      transactionIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'transactionId');
    });
  }

  QueryBuilder<ExtractionMetadataModel, bool, QQueryOperations>
      userVerifiedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userVerified');
    });
  }
}
