// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_sender_preference_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetEmailSenderPreferenceModelCollection on Isar {
  IsarCollection<EmailSenderPreferenceModel> get emailSenderPreferenceModels =>
      this.collection();
}

const EmailSenderPreferenceModelSchema = CollectionSchema(
  name: r'EmailSenderPreferenceModel',
  id: 7816671628470804629,
  properties: {
    r'averageConfidence': PropertySchema(
      id: 0,
      name: r'averageConfidence',
      type: IsarType.double,
    ),
    r'createdAt': PropertySchema(
      id: 1,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'isRecognizedMerchant': PropertySchema(
      id: 2,
      name: r'isRecognizedMerchant',
      type: IsarType.bool,
    ),
    r'lastScannedDate': PropertySchema(
      id: 3,
      name: r'lastScannedDate',
      type: IsarType.dateTime,
    ),
    r'scanEnabled': PropertySchema(
      id: 4,
      name: r'scanEnabled',
      type: IsarType.bool,
    ),
    r'senderDisplayName': PropertySchema(
      id: 5,
      name: r'senderDisplayName',
      type: IsarType.string,
    ),
    r'senderDomain': PropertySchema(
      id: 6,
      name: r'senderDomain',
      type: IsarType.string,
    ),
    r'senderEmail': PropertySchema(
      id: 7,
      name: r'senderEmail',
      type: IsarType.string,
    ),
    r'totalEmailsProcessed': PropertySchema(
      id: 8,
      name: r'totalEmailsProcessed',
      type: IsarType.long,
    ),
    r'totalTransactionsExtracted': PropertySchema(
      id: 9,
      name: r'totalTransactionsExtracted',
      type: IsarType.long,
    ),
    r'updatedAt': PropertySchema(
      id: 10,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
    r'userNotes': PropertySchema(
      id: 11,
      name: r'userNotes',
      type: IsarType.string,
    )
  },
  estimateSize: _emailSenderPreferenceModelEstimateSize,
  serialize: _emailSenderPreferenceModelSerialize,
  deserialize: _emailSenderPreferenceModelDeserialize,
  deserializeProp: _emailSenderPreferenceModelDeserializeProp,
  idName: r'id',
  indexes: {
    r'senderEmail': IndexSchema(
      id: -9111757750859751913,
      name: r'senderEmail',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'senderEmail',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'senderDomain': IndexSchema(
      id: -2416026876781213129,
      name: r'senderDomain',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'senderDomain',
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
  getId: _emailSenderPreferenceModelGetId,
  getLinks: _emailSenderPreferenceModelGetLinks,
  attach: _emailSenderPreferenceModelAttach,
  version: '3.1.0+1',
);

int _emailSenderPreferenceModelEstimateSize(
  EmailSenderPreferenceModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.senderDisplayName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.senderDomain.length * 3;
  bytesCount += 3 + object.senderEmail.length * 3;
  {
    final value = object.userNotes;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _emailSenderPreferenceModelSerialize(
  EmailSenderPreferenceModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.averageConfidence);
  writer.writeDateTime(offsets[1], object.createdAt);
  writer.writeBool(offsets[2], object.isRecognizedMerchant);
  writer.writeDateTime(offsets[3], object.lastScannedDate);
  writer.writeBool(offsets[4], object.scanEnabled);
  writer.writeString(offsets[5], object.senderDisplayName);
  writer.writeString(offsets[6], object.senderDomain);
  writer.writeString(offsets[7], object.senderEmail);
  writer.writeLong(offsets[8], object.totalEmailsProcessed);
  writer.writeLong(offsets[9], object.totalTransactionsExtracted);
  writer.writeDateTime(offsets[10], object.updatedAt);
  writer.writeString(offsets[11], object.userNotes);
}

EmailSenderPreferenceModel _emailSenderPreferenceModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = EmailSenderPreferenceModel();
  object.averageConfidence = reader.readDoubleOrNull(offsets[0]);
  object.createdAt = reader.readDateTime(offsets[1]);
  object.id = id;
  object.isRecognizedMerchant = reader.readBool(offsets[2]);
  object.lastScannedDate = reader.readDateTimeOrNull(offsets[3]);
  object.scanEnabled = reader.readBool(offsets[4]);
  object.senderDisplayName = reader.readStringOrNull(offsets[5]);
  object.senderDomain = reader.readString(offsets[6]);
  object.senderEmail = reader.readString(offsets[7]);
  object.totalEmailsProcessed = reader.readLong(offsets[8]);
  object.totalTransactionsExtracted = reader.readLong(offsets[9]);
  object.updatedAt = reader.readDateTimeOrNull(offsets[10]);
  object.userNotes = reader.readStringOrNull(offsets[11]);
  return object;
}

P _emailSenderPreferenceModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDoubleOrNull(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readLong(offset)) as P;
    case 9:
      return (reader.readLong(offset)) as P;
    case 10:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _emailSenderPreferenceModelGetId(EmailSenderPreferenceModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _emailSenderPreferenceModelGetLinks(
    EmailSenderPreferenceModel object) {
  return [];
}

void _emailSenderPreferenceModelAttach(
    IsarCollection<dynamic> col, Id id, EmailSenderPreferenceModel object) {
  object.id = id;
}

extension EmailSenderPreferenceModelByIndex
    on IsarCollection<EmailSenderPreferenceModel> {
  Future<EmailSenderPreferenceModel?> getBySenderEmail(String senderEmail) {
    return getByIndex(r'senderEmail', [senderEmail]);
  }

  EmailSenderPreferenceModel? getBySenderEmailSync(String senderEmail) {
    return getByIndexSync(r'senderEmail', [senderEmail]);
  }

  Future<bool> deleteBySenderEmail(String senderEmail) {
    return deleteByIndex(r'senderEmail', [senderEmail]);
  }

  bool deleteBySenderEmailSync(String senderEmail) {
    return deleteByIndexSync(r'senderEmail', [senderEmail]);
  }

  Future<List<EmailSenderPreferenceModel?>> getAllBySenderEmail(
      List<String> senderEmailValues) {
    final values = senderEmailValues.map((e) => [e]).toList();
    return getAllByIndex(r'senderEmail', values);
  }

  List<EmailSenderPreferenceModel?> getAllBySenderEmailSync(
      List<String> senderEmailValues) {
    final values = senderEmailValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'senderEmail', values);
  }

  Future<int> deleteAllBySenderEmail(List<String> senderEmailValues) {
    final values = senderEmailValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'senderEmail', values);
  }

  int deleteAllBySenderEmailSync(List<String> senderEmailValues) {
    final values = senderEmailValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'senderEmail', values);
  }

  Future<Id> putBySenderEmail(EmailSenderPreferenceModel object) {
    return putByIndex(r'senderEmail', object);
  }

  Id putBySenderEmailSync(EmailSenderPreferenceModel object,
      {bool saveLinks = true}) {
    return putByIndexSync(r'senderEmail', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllBySenderEmail(
      List<EmailSenderPreferenceModel> objects) {
    return putAllByIndex(r'senderEmail', objects);
  }

  List<Id> putAllBySenderEmailSync(List<EmailSenderPreferenceModel> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'senderEmail', objects, saveLinks: saveLinks);
  }
}

extension EmailSenderPreferenceModelQueryWhereSort on QueryBuilder<
    EmailSenderPreferenceModel, EmailSenderPreferenceModel, QWhere> {
  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterWhere> anyCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'createdAt'),
      );
    });
  }
}

extension EmailSenderPreferenceModelQueryWhere on QueryBuilder<
    EmailSenderPreferenceModel, EmailSenderPreferenceModel, QWhereClause> {
  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
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

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterWhereClause> idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterWhereClause> idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
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

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterWhereClause> senderEmailEqualTo(String senderEmail) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'senderEmail',
        value: [senderEmail],
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterWhereClause> senderEmailNotEqualTo(String senderEmail) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'senderEmail',
              lower: [],
              upper: [senderEmail],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'senderEmail',
              lower: [senderEmail],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'senderEmail',
              lower: [senderEmail],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'senderEmail',
              lower: [],
              upper: [senderEmail],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterWhereClause> senderDomainEqualTo(String senderDomain) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'senderDomain',
        value: [senderDomain],
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterWhereClause> senderDomainNotEqualTo(String senderDomain) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'senderDomain',
              lower: [],
              upper: [senderDomain],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'senderDomain',
              lower: [senderDomain],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'senderDomain',
              lower: [senderDomain],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'senderDomain',
              lower: [],
              upper: [senderDomain],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterWhereClause> createdAtEqualTo(DateTime createdAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'createdAt',
        value: [createdAt],
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
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

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
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

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
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

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
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

extension EmailSenderPreferenceModelQueryFilter on QueryBuilder<
    EmailSenderPreferenceModel, EmailSenderPreferenceModel, QFilterCondition> {
  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterFilterCondition> averageConfidenceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'averageConfidence',
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterFilterCondition> averageConfidenceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'averageConfidence',
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterFilterCondition> averageConfidenceEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'averageConfidence',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterFilterCondition> averageConfidenceGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'averageConfidence',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterFilterCondition> averageConfidenceLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'averageConfidence',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterFilterCondition> averageConfidenceBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'averageConfidence',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterFilterCondition> createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
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

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
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

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
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

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
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

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
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

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
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

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterFilterCondition> isRecognizedMerchantEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isRecognizedMerchant',
        value: value,
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterFilterCondition> lastScannedDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastScannedDate',
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterFilterCondition> lastScannedDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastScannedDate',
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterFilterCondition> lastScannedDateEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastScannedDate',
        value: value,
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterFilterCondition> lastScannedDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastScannedDate',
        value: value,
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterFilterCondition> lastScannedDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastScannedDate',
        value: value,
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterFilterCondition> lastScannedDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastScannedDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterFilterCondition> scanEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'scanEnabled',
        value: value,
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterFilterCondition> senderDisplayNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'senderDisplayName',
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterFilterCondition> senderDisplayNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'senderDisplayName',
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterFilterCondition> senderDisplayNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'senderDisplayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterFilterCondition> senderDisplayNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'senderDisplayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterFilterCondition> senderDisplayNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'senderDisplayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterFilterCondition> senderDisplayNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'senderDisplayName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterFilterCondition> senderDisplayNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'senderDisplayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterFilterCondition> senderDisplayNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'senderDisplayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
          QAfterFilterCondition>
      senderDisplayNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'senderDisplayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
          QAfterFilterCondition>
      senderDisplayNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'senderDisplayName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterFilterCondition> senderDisplayNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'senderDisplayName',
        value: '',
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterFilterCondition> senderDisplayNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'senderDisplayName',
        value: '',
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterFilterCondition> senderDomainEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'senderDomain',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterFilterCondition> senderDomainGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'senderDomain',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterFilterCondition> senderDomainLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'senderDomain',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterFilterCondition> senderDomainBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'senderDomain',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterFilterCondition> senderDomainStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'senderDomain',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterFilterCondition> senderDomainEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'senderDomain',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
          QAfterFilterCondition>
      senderDomainContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'senderDomain',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
          QAfterFilterCondition>
      senderDomainMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'senderDomain',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterFilterCondition> senderDomainIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'senderDomain',
        value: '',
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterFilterCondition> senderDomainIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'senderDomain',
        value: '',
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterFilterCondition> senderEmailEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'senderEmail',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterFilterCondition> senderEmailGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'senderEmail',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterFilterCondition> senderEmailLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'senderEmail',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterFilterCondition> senderEmailBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'senderEmail',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterFilterCondition> senderEmailStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'senderEmail',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterFilterCondition> senderEmailEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'senderEmail',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
          QAfterFilterCondition>
      senderEmailContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'senderEmail',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
          QAfterFilterCondition>
      senderEmailMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'senderEmail',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterFilterCondition> senderEmailIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'senderEmail',
        value: '',
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterFilterCondition> senderEmailIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'senderEmail',
        value: '',
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterFilterCondition> totalEmailsProcessedEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalEmailsProcessed',
        value: value,
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterFilterCondition> totalEmailsProcessedGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalEmailsProcessed',
        value: value,
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterFilterCondition> totalEmailsProcessedLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalEmailsProcessed',
        value: value,
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterFilterCondition> totalEmailsProcessedBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalEmailsProcessed',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterFilterCondition> totalTransactionsExtractedEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalTransactionsExtracted',
        value: value,
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterFilterCondition> totalTransactionsExtractedGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalTransactionsExtracted',
        value: value,
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterFilterCondition> totalTransactionsExtractedLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalTransactionsExtracted',
        value: value,
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterFilterCondition> totalTransactionsExtractedBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalTransactionsExtracted',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterFilterCondition> updatedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'updatedAt',
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterFilterCondition> updatedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'updatedAt',
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterFilterCondition> updatedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterFilterCondition> updatedAtGreaterThan(
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

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterFilterCondition> updatedAtLessThan(
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

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterFilterCondition> updatedAtBetween(
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

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterFilterCondition> userNotesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'userNotes',
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterFilterCondition> userNotesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'userNotes',
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterFilterCondition> userNotesEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userNotes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterFilterCondition> userNotesGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'userNotes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterFilterCondition> userNotesLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'userNotes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterFilterCondition> userNotesBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'userNotes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterFilterCondition> userNotesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'userNotes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterFilterCondition> userNotesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'userNotes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
          QAfterFilterCondition>
      userNotesContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'userNotes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
          QAfterFilterCondition>
      userNotesMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'userNotes',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterFilterCondition> userNotesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userNotes',
        value: '',
      ));
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterFilterCondition> userNotesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'userNotes',
        value: '',
      ));
    });
  }
}

extension EmailSenderPreferenceModelQueryObject on QueryBuilder<
    EmailSenderPreferenceModel, EmailSenderPreferenceModel, QFilterCondition> {}

extension EmailSenderPreferenceModelQueryLinks on QueryBuilder<
    EmailSenderPreferenceModel, EmailSenderPreferenceModel, QFilterCondition> {}

extension EmailSenderPreferenceModelQuerySortBy on QueryBuilder<
    EmailSenderPreferenceModel, EmailSenderPreferenceModel, QSortBy> {
  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterSortBy> sortByAverageConfidence() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'averageConfidence', Sort.asc);
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterSortBy> sortByAverageConfidenceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'averageConfidence', Sort.desc);
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterSortBy> sortByIsRecognizedMerchant() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRecognizedMerchant', Sort.asc);
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterSortBy> sortByIsRecognizedMerchantDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRecognizedMerchant', Sort.desc);
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterSortBy> sortByLastScannedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastScannedDate', Sort.asc);
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterSortBy> sortByLastScannedDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastScannedDate', Sort.desc);
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterSortBy> sortByScanEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scanEnabled', Sort.asc);
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterSortBy> sortByScanEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scanEnabled', Sort.desc);
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterSortBy> sortBySenderDisplayName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senderDisplayName', Sort.asc);
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterSortBy> sortBySenderDisplayNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senderDisplayName', Sort.desc);
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterSortBy> sortBySenderDomain() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senderDomain', Sort.asc);
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterSortBy> sortBySenderDomainDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senderDomain', Sort.desc);
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterSortBy> sortBySenderEmail() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senderEmail', Sort.asc);
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterSortBy> sortBySenderEmailDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senderEmail', Sort.desc);
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterSortBy> sortByTotalEmailsProcessed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalEmailsProcessed', Sort.asc);
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterSortBy> sortByTotalEmailsProcessedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalEmailsProcessed', Sort.desc);
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterSortBy> sortByTotalTransactionsExtracted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalTransactionsExtracted', Sort.asc);
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterSortBy> sortByTotalTransactionsExtractedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalTransactionsExtracted', Sort.desc);
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterSortBy> sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterSortBy> sortByUserNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userNotes', Sort.asc);
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterSortBy> sortByUserNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userNotes', Sort.desc);
    });
  }
}

extension EmailSenderPreferenceModelQuerySortThenBy on QueryBuilder<
    EmailSenderPreferenceModel, EmailSenderPreferenceModel, QSortThenBy> {
  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterSortBy> thenByAverageConfidence() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'averageConfidence', Sort.asc);
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterSortBy> thenByAverageConfidenceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'averageConfidence', Sort.desc);
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterSortBy> thenByIsRecognizedMerchant() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRecognizedMerchant', Sort.asc);
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterSortBy> thenByIsRecognizedMerchantDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRecognizedMerchant', Sort.desc);
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterSortBy> thenByLastScannedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastScannedDate', Sort.asc);
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterSortBy> thenByLastScannedDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastScannedDate', Sort.desc);
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterSortBy> thenByScanEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scanEnabled', Sort.asc);
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterSortBy> thenByScanEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scanEnabled', Sort.desc);
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterSortBy> thenBySenderDisplayName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senderDisplayName', Sort.asc);
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterSortBy> thenBySenderDisplayNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senderDisplayName', Sort.desc);
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterSortBy> thenBySenderDomain() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senderDomain', Sort.asc);
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterSortBy> thenBySenderDomainDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senderDomain', Sort.desc);
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterSortBy> thenBySenderEmail() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senderEmail', Sort.asc);
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterSortBy> thenBySenderEmailDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senderEmail', Sort.desc);
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterSortBy> thenByTotalEmailsProcessed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalEmailsProcessed', Sort.asc);
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterSortBy> thenByTotalEmailsProcessedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalEmailsProcessed', Sort.desc);
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterSortBy> thenByTotalTransactionsExtracted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalTransactionsExtracted', Sort.asc);
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterSortBy> thenByTotalTransactionsExtractedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalTransactionsExtracted', Sort.desc);
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterSortBy> thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterSortBy> thenByUserNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userNotes', Sort.asc);
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QAfterSortBy> thenByUserNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userNotes', Sort.desc);
    });
  }
}

extension EmailSenderPreferenceModelQueryWhereDistinct on QueryBuilder<
    EmailSenderPreferenceModel, EmailSenderPreferenceModel, QDistinct> {
  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QDistinct> distinctByAverageConfidence() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'averageConfidence');
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QDistinct> distinctByIsRecognizedMerchant() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isRecognizedMerchant');
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QDistinct> distinctByLastScannedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastScannedDate');
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QDistinct> distinctByScanEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'scanEnabled');
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QDistinct> distinctBySenderDisplayName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'senderDisplayName',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QDistinct> distinctBySenderDomain({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'senderDomain', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QDistinct> distinctBySenderEmail({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'senderEmail', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QDistinct> distinctByTotalEmailsProcessed() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalEmailsProcessed');
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QDistinct> distinctByTotalTransactionsExtracted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalTransactionsExtracted');
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, EmailSenderPreferenceModel,
      QDistinct> distinctByUserNotes({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userNotes', caseSensitive: caseSensitive);
    });
  }
}

extension EmailSenderPreferenceModelQueryProperty on QueryBuilder<
    EmailSenderPreferenceModel, EmailSenderPreferenceModel, QQueryProperty> {
  QueryBuilder<EmailSenderPreferenceModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, double?, QQueryOperations>
      averageConfidenceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'averageConfidence');
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, DateTime, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, bool, QQueryOperations>
      isRecognizedMerchantProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isRecognizedMerchant');
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, DateTime?, QQueryOperations>
      lastScannedDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastScannedDate');
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, bool, QQueryOperations>
      scanEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'scanEnabled');
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, String?, QQueryOperations>
      senderDisplayNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'senderDisplayName');
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, String, QQueryOperations>
      senderDomainProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'senderDomain');
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, String, QQueryOperations>
      senderEmailProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'senderEmail');
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, int, QQueryOperations>
      totalEmailsProcessedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalEmailsProcessed');
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, int, QQueryOperations>
      totalTransactionsExtractedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalTransactionsExtracted');
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, DateTime?, QQueryOperations>
      updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }

  QueryBuilder<EmailSenderPreferenceModel, String?, QQueryOperations>
      userNotesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userNotes');
    });
  }
}
