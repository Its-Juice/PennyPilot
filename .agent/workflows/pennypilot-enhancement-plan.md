---
description: PennyPilot Enhancement Implementation Plan
---

# PennyPilot Enhancement Implementation Plan

This document outlines the comprehensive implementation plan for upgrading PennyPilot with smarter receipt understanding, subscription intelligence, Material You integration, and advanced privacy features.

## Phase 1: Enhanced Data Models & Database Schema

### 1.1 Receipt Line Items & Confidence Scoring
- [ ] Create `ReceiptLineItemModel` with fields: description, amount, type (item/tax/discount)
- [ ] Add `ExtractionMetadata` model with confidence scores (high/medium/low)
- [ ] Update `TransactionModel` to include:
  - `extractionConfidence` enum
  - `lineItems` relationship (optional)
  - `merchantNormalized` field
  - `rawMerchantName` field
  - `totalAmount`, `taxAmount`, `discountAmount` fields

### 1.2 Subscription Intelligence
- [ ] Extend `SubscriptionModel` with:
  - `lifecycleState` enum (active, trial, paused, ended)
  - `firstSeenDate` DateTime
  - `lastChargedDate` DateTime
  - `priceHistory` list of price changes
  - `billingCycleHistory` list of cycle changes
  - `frequencyConsistency` score (0-100)
  - `detectionSource` (email/manual/pattern)

### 1.3 Email & Merchant Management
- [ ] Create `EmailSenderPreferenceModel`:
  - `senderEmail` string
  - `senderDomain` string
  - `scanEnabled` boolean
  - `lastScannedDate` DateTime
  - `totalEmailsProcessed` int
- [ ] Create `MerchantNormalizationRuleModel`:
  - `rawName` string
  - `normalizedName` string
  - `confidence` score
  - `isUserDefined` boolean

### 1.4 Custom Categories
- [ ] Create `CategoryModel`:
  - `name` string
  - `parentCategoryId` (for subcategories)
  - `icon` string
  - `color` string
  - `isSystem` boolean
- [ ] Create `MerchantCategoryMappingModel`:
  - `merchantName` string
  - `categoryId` reference
  - `isAutomatic` boolean

## Phase 2: Core Services & Business Logic

### 2.1 Receipt Extraction Service
- [ ] Create `ReceiptExtractionService`:
  - `extractReceiptData()` - parse email content
  - `detectLineItems()` - identify items, taxes, discounts
  - `calculateConfidenceScore()` - assess extraction quality
  - `normalizeMerchant()` - apply normalization rules
- [ ] Implement offline pattern matching for common receipt formats
- [ ] Add fallback extraction methods

### 2.2 Subscription Detection Service
- [ ] Create `SubscriptionIntelligenceService`:
  - `detectSubscription()` - identify recurring patterns
  - `updateLifecycleState()` - track subscription status
  - `detectPriceChange()` - monitor price variations
  - `detectCycleChange()` - track billing frequency changes
  - `calculateConsistency()` - assess payment regularity
- [ ] Implement pattern recognition for subscription keywords
- [ ] Add timeline tracking logic

### 2.3 Merchant Normalization Service
- [ ] Create `MerchantNormalizationService`:
  - `normalizeMerchantName()` - apply rules
  - `addNormalizationRule()` - user-defined rules
  - `suggestNormalization()` - ML-based suggestions (optional)
- [ ] Build default normalization rules database (Amazon, Netflix, etc.)
- [ ] Implement fuzzy matching for similar merchant names

### 2.4 Email Scanner Service
- [ ] Enhance existing `EmailService` with:
  - `checkSenderPreference()` - respect user toggles
  - `dryRunScan()` - preview before importing
  - `manualRescan()` - reprocess with updated rules
  - `getScanStatistics()` - per-sender metrics

### 2.5 Category Management Service
- [ ] Create `CategoryService`:
  - `createCategory()` - add custom categories
  - `assignMerchantToCategory()` - create mappings
  - `getUncategorizedTransactions()` - find unassigned
  - `suggestCategory()` - ML-based (optional)

## Phase 3: Material You Integration

### 3.1 Dynamic Color System
- [ ] Update `AppTheme` class:
  - Implement `ColorScheme.fromSeed()` with wallpaper colors
  - Add fallback color generation for Android < 12
  - Create neutral color palette for financial data
  - Avoid red/green for good/bad semantics
- [ ] Add color customization settings
- [ ] Test on multiple Android versions

### 3.2 Material 3 Components
- [ ] Update all screens to use Material 3 components:
  - Replace old cards with Material 3 cards
  - Use `SurfaceVariant` for receipts
  - Use elevated cards for subscriptions
  - Apply tonal surfaces for charts
- [ ] Implement proper elevation system
- [ ] Add surface tint overlays

### 3.3 Typography & Density
- [ ] Apply Material 3 type scale throughout app
- [ ] Increase body text size for amounts
- [ ] Use monospaced font for currency values
- [ ] Ensure proper text scaling

### 3.4 Motion & Transitions
- [ ] Implement shared axis transitions:
  - Between time ranges
  - Between screens
- [ ] Add gentle fade animations for rescans
- [ ] Remove any aggressive or celebratory animations
- [ ] Ensure all animations are subtle and respectful

### 3.5 Accessibility
- [ ] Implement dynamic text scaling
- [ ] Add high contrast mode support
- [ ] Ensure minimum tap target sizes (48dp)
- [ ] Add screen reader labels
- [ ] Test with TalkBack

## Phase 4: UI/UX Implementation

### 4.1 Enhanced Transaction Details Screen
- [ ] Show confidence score badge (High/Medium/Low)
- [ ] Add expandable line items section
- [ ] Display normalized vs raw merchant name
- [ ] Show extraction metadata
- [ ] Allow manual confidence override

### 4.2 Subscription Intelligence Screen
- [ ] Create subscription timeline view
- [ ] Show lifecycle state badges
- [ ] Display price change history
- [ ] Show billing cycle changes
- [ ] Add frequency consistency indicator
- [ ] Implement "What changed" view

### 4.3 Email Scanner Controls Screen
- [ ] Create sender management UI:
  - List all email senders
  - Toggle scan per sender
  - Show scan statistics
- [ ] Add dry-run preview mode
- [ ] Implement manual rescan functionality
- [ ] Show last scan date per sender

### 4.4 Category Management Screen
- [ ] Create category editor:
  - Add/edit/delete categories
  - Create subcategories
  - Assign icons and colors
- [ ] Implement merchant-category mapping UI
- [ ] Show "Uncategorized inbox" view
- [ ] Add bulk categorization

### 4.5 Time-Based Insights Screen
- [ ] Create period selector (Month/Quarter/Year)
- [ ] Implement "What changed" view:
  - New subscriptions
  - Ended subscriptions
  - Price changes
- [ ] Add heatmap calendar for spending density
- [ ] Show descriptive summaries (no advice)

### 4.6 Enhanced Privacy & Security Screen
- [ ] Add "Reset AI understanding" option
- [ ] Show data ownership tools:
  - Encrypted local export
  - Full app state backup
  - Restore from backup
- [ ] Display storage usage statistics
- [ ] Add merchant normalization rules viewer

## Phase 5: Data Ownership & Export

### 5.1 Export Service
- [ ] Enhance `BackupService`:
  - Export to JSON format
  - Export to CSV format
  - Include all metadata
  - Encrypt exports (optional)
- [ ] Add selective export (transactions only, subscriptions only, etc.)

### 5.2 Backup & Restore
- [ ] Implement full app state backup
- [ ] Create restore functionality
- [ ] Add backup verification
- [ ] Support incremental backups

### 5.3 Reset Options
- [ ] Add "Reset AI understanding" feature:
  - Clear derived metadata
  - Keep raw transaction data
  - Reset merchant normalizations
  - Clear confidence scores

## Phase 6: Optional Advanced Features

### 6.1 Offline ML Integration (Future)
- [ ] Research on-device ML models:
  - TensorFlow Lite
  - ML Kit
  - Custom trained models
- [ ] Implement merchant classification model
- [ ] Add subscription detection model
- [ ] Create fallback to rule-based system
- [ ] Ensure no telemetry

### 6.2 Smart Defaults
- [ ] Build comprehensive default merchant normalization database
- [ ] Create default category suggestions
- [ ] Add common subscription patterns
- [ ] Include receipt format templates

## Implementation Order

1. **Week 1-2**: Phase 1 (Data Models)
2. **Week 3-4**: Phase 2 (Core Services)
3. **Week 5-6**: Phase 3 (Material You)
4. **Week 7-8**: Phase 4 (UI/UX)
5. **Week 9**: Phase 5 (Data Ownership)
6. **Week 10+**: Phase 6 (Optional Advanced)

## Testing Strategy

- Unit tests for all services
- Widget tests for new UI components
- Integration tests for email scanning
- Manual testing on multiple Android versions
- Accessibility testing with TalkBack
- Performance testing with large datasets

## Privacy Principles (Maintained)

✅ All processing happens locally
✅ No cloud servers
✅ No telemetry
✅ User owns all data
✅ Transparent about what's happening
✅ No judgment or advice
✅ Full data export capability
