# Isar Enum and Byte-Stored Types - Quick Reference

## The Issue

In Isar, certain field types cannot be nullable because they are stored as bytes with fixed allocation:

- **Enums** (when using `@Enumerated`)
- **Embedded objects**
- **Custom byte types**

## The Error

```
Bytes must not be nullable.
```

This occurs when you try to make an enum field nullable:

```dart
// ❌ WRONG - Will cause build error
@Enumerated(EnumType.ordinal)
ConfidenceLevel? extractionConfidence;
```

## Solutions

### Option 1: Non-nullable with Default Value (Recommended)

```dart
// ✅ CORRECT
@Enumerated(EnumType.ordinal)
ConfidenceLevel extractionConfidence = ConfidenceLevel.low;
```

### Option 2: Non-nullable with `late` Keyword

```dart
// ✅ CORRECT - Must be initialized before first read
@Enumerated(EnumType.ordinal)
late ConfidenceLevel extractionConfidence;
```

### Option 3: Store as Nullable Primitive

If you truly need nullable semantics, store as int/string and map to enum:

```dart
// Store as nullable int
int? _extractionConfidenceValue;

// Getter/setter to map to enum
@ignore
ConfidenceLevel? get extractionConfidence {
  if (_extractionConfidenceValue == null) return null;
  return ConfidenceLevel.values[_extractionConfidenceValue!];
}

@ignore
set extractionConfidence(ConfidenceLevel? value) {
  _extractionConfidenceValue = value?.index;
}
```

## Our Implementation

In PennyPilot, we use **Option 1** for all enum fields:

### TransactionModel
```dart
@Enumerated(EnumType.ordinal)
ConfidenceLevel extractionConfidence = ConfidenceLevel.low;
```

### ExtractionMetadataModel
```dart
@Enumerated(EnumType.ordinal)
late ConfidenceLevel overallConfidence;

@Enumerated(EnumType.ordinal)
late ConfidenceLevel merchantConfidence;

@Enumerated(EnumType.ordinal)
late ConfidenceLevel amountConfidence;

@Enumerated(EnumType.ordinal)
late ConfidenceLevel dateConfidence;
```

### SubscriptionModel
```dart
@Enumerated(EnumType.ordinal)
late SubscriptionFrequency frequency;

@Enumerated(EnumType.ordinal)
late SubscriptionLifecycleState lifecycleState;

@Enumerated(EnumType.ordinal)
late SubscriptionDetectionSource detectionSource;
```

### ReceiptLineItemModel
```dart
@Enumerated(EnumType.ordinal)
late LineItemType type;
```

### MerchantNormalizationRuleModel
```dart
@Enumerated(EnumType.ordinal)
late MatchType matchType;
```

## Key Takeaways

1. **Enums in Isar cannot be nullable** when using `@Enumerated`
2. **Use default values** for optional semantics (e.g., `ConfidenceLevel.low`)
3. **Use `late`** when the value will be set during object creation
4. **Nullable primitives** are allowed (String?, int?, double?, DateTime?)
5. **Lists and embedded objects** follow similar rules

## Fixed Files

- ✅ `lib/src/data/models/transaction_model.dart`
- ✅ `lib/src/data/models/extraction_metadata_model.dart`
- ✅ `lib/src/data/models/subscription_model.dart`
- ✅ `lib/src/data/models/receipt_line_item_model.dart`
- ✅ `lib/src/data/models/merchant_normalization_rule_model.dart`
- ✅ `lib/src/data/local/database_service.dart`

All enum fields are now properly non-nullable with either default values or `late` initialization.
