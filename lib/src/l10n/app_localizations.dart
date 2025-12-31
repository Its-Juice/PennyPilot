import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_el.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('el'),
    Locale('en'),
    Locale('fr')
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'PennyPilot'**
  String get appName;

  /// No description provided for @demo.
  ///
  /// In en, this message translates to:
  /// **'DEMO'**
  String get demo;

  /// No description provided for @scanEmails.
  ///
  /// In en, this message translates to:
  /// **'Scan Emails'**
  String get scanEmails;

  /// No description provided for @errorScanning.
  ///
  /// In en, this message translates to:
  /// **'Error scanning: {error}'**
  String errorScanning(String error);

  /// No description provided for @spendingByCategory.
  ///
  /// In en, this message translates to:
  /// **'Spending by Category'**
  String get spendingByCategory;

  /// No description provided for @spendingPulse.
  ///
  /// In en, this message translates to:
  /// **'Spending Pulse'**
  String get spendingPulse;

  /// No description provided for @recentTransactions.
  ///
  /// In en, this message translates to:
  /// **'Recent Transactions'**
  String get recentTransactions;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get viewAll;

  /// No description provided for @errorLoadingTransactions.
  ///
  /// In en, this message translates to:
  /// **'Error loading transactions: {error}'**
  String errorLoadingTransactions(String error);

  /// No description provided for @upcomingSubscriptions.
  ///
  /// In en, this message translates to:
  /// **'Upcoming Subscriptions'**
  String get upcomingSubscriptions;

  /// No description provided for @noActiveSubscriptions.
  ///
  /// In en, this message translates to:
  /// **'No active subscriptions detected.'**
  String get noActiveSubscriptions;

  /// No description provided for @renewingInDays.
  ///
  /// In en, this message translates to:
  /// **'Renewing in {days} days'**
  String renewingInDays(int days);

  /// No description provided for @errorLoadingSubscriptions.
  ///
  /// In en, this message translates to:
  /// **'Error loading subscriptions: {error}'**
  String errorLoadingSubscriptions(String error);

  /// No description provided for @noTransactionsYet.
  ///
  /// In en, this message translates to:
  /// **'No Transactions Yet'**
  String get noTransactionsYet;

  /// No description provided for @connectEmailDescription.
  ///
  /// In en, this message translates to:
  /// **'Connect your email to automatically scan for receipts and track your spending.'**
  String get connectEmailDescription;

  /// No description provided for @connectEmail.
  ///
  /// In en, this message translates to:
  /// **'Connect Email'**
  String get connectEmail;

  /// No description provided for @overview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overview;

  /// No description provided for @transactions.
  ///
  /// In en, this message translates to:
  /// **'Transactions'**
  String get transactions;

  /// No description provided for @subs.
  ///
  /// In en, this message translates to:
  /// **'Subs'**
  String get subs;

  /// No description provided for @insights.
  ///
  /// In en, this message translates to:
  /// **'Insights'**
  String get insights;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @system.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get system;

  /// No description provided for @pitchBlackOled.
  ///
  /// In en, this message translates to:
  /// **'Pitch Black OLED'**
  String get pitchBlackOled;

  /// No description provided for @oledDescription.
  ///
  /// In en, this message translates to:
  /// **'Completely black background for OLED screens'**
  String get oledDescription;

  /// No description provided for @accounts.
  ///
  /// In en, this message translates to:
  /// **'Accounts'**
  String get accounts;

  /// No description provided for @manageConnectedAccounts.
  ///
  /// In en, this message translates to:
  /// **'Manage connected accounts'**
  String get manageConnectedAccounts;

  /// No description provided for @noAccountsConnected.
  ///
  /// In en, this message translates to:
  /// **'No accounts connected'**
  String get noAccountsConnected;

  /// No description provided for @accountsConnected.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 account connected} other{{count} accounts connected}}'**
  String accountsConnected(int count);

  /// No description provided for @general.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get general;

  /// No description provided for @primaryCurrency.
  ///
  /// In en, this message translates to:
  /// **'Primary Currency'**
  String get primaryCurrency;

  /// No description provided for @manageCategories.
  ///
  /// In en, this message translates to:
  /// **'Manage Categories'**
  String get manageCategories;

  /// No description provided for @privacySecurity.
  ///
  /// In en, this message translates to:
  /// **'Privacy & Security'**
  String get privacySecurity;

  /// No description provided for @privacyAudit.
  ///
  /// In en, this message translates to:
  /// **'Privacy Audit'**
  String get privacyAudit;

  /// No description provided for @rescanEmails.
  ///
  /// In en, this message translates to:
  /// **'Rescan Emails'**
  String get rescanEmails;

  /// No description provided for @scanningEmails.
  ///
  /// In en, this message translates to:
  /// **'Scanning emails...'**
  String get scanningEmails;

  /// No description provided for @scanComplete.
  ///
  /// In en, this message translates to:
  /// **'Scan complete'**
  String get scanComplete;

  /// No description provided for @scanFailed.
  ///
  /// In en, this message translates to:
  /// **'Scan failed: {error}'**
  String scanFailed(String error);

  /// No description provided for @backups.
  ///
  /// In en, this message translates to:
  /// **'Backups'**
  String get backups;

  /// No description provided for @aboutPennyPilot.
  ///
  /// In en, this message translates to:
  /// **'About PennyPilot'**
  String get aboutPennyPilot;

  /// No description provided for @selectCurrency.
  ///
  /// In en, this message translates to:
  /// **'Select Currency'**
  String get selectCurrency;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search merchant or notes...'**
  String get searchHint;

  /// No description provided for @closeSearch.
  ///
  /// In en, this message translates to:
  /// **'Close Search'**
  String get closeSearch;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @scanReceipt.
  ///
  /// In en, this message translates to:
  /// **'Scan Receipt'**
  String get scanReceipt;

  /// No description provided for @filterAndSort.
  ///
  /// In en, this message translates to:
  /// **'Filter & Sort'**
  String get filterAndSort;

  /// No description provided for @noMatches.
  ///
  /// In en, this message translates to:
  /// **'No Matches'**
  String get noMatches;

  /// No description provided for @tryAdjustingFilters.
  ///
  /// In en, this message translates to:
  /// **'Try adjusting your filters'**
  String get tryAdjustingFilters;

  /// No description provided for @clearFilters.
  ///
  /// In en, this message translates to:
  /// **'Clear Filters'**
  String get clearFilters;

  /// No description provided for @loadingTransactions.
  ///
  /// In en, this message translates to:
  /// **'Loading transactions...'**
  String get loadingTransactions;

  /// No description provided for @failedToLoad.
  ///
  /// In en, this message translates to:
  /// **'Failed to Load'**
  String get failedToLoad;

  /// No description provided for @addEntry.
  ///
  /// In en, this message translates to:
  /// **'Add Entry'**
  String get addEntry;

  /// No description provided for @income.
  ///
  /// In en, this message translates to:
  /// **'Income'**
  String get income;

  /// No description provided for @expenses.
  ///
  /// In en, this message translates to:
  /// **'Expenses'**
  String get expenses;

  /// No description provided for @net.
  ///
  /// In en, this message translates to:
  /// **'Net'**
  String get net;

  /// No description provided for @categoryFilter.
  ///
  /// In en, this message translates to:
  /// **'Category: {category}'**
  String categoryFilter(String category);

  /// No description provided for @sortFilter.
  ///
  /// In en, this message translates to:
  /// **'Sort: {sort}'**
  String sortFilter(String sort);

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @merchant.
  ///
  /// In en, this message translates to:
  /// **'Merchant'**
  String get merchant;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @subscriptions.
  ///
  /// In en, this message translates to:
  /// **'Subscriptions'**
  String get subscriptions;

  /// No description provided for @addSubscription.
  ///
  /// In en, this message translates to:
  /// **'Add Subscription'**
  String get addSubscription;

  /// No description provided for @noSubscriptionsFound.
  ///
  /// In en, this message translates to:
  /// **'No Subscriptions Found'**
  String get noSubscriptionsFound;

  /// No description provided for @noSubscriptionsDescription.
  ///
  /// In en, this message translates to:
  /// **'We\'ll automatically detect subscriptions from your transactions, or you can add them manually.'**
  String get noSubscriptionsDescription;

  /// No description provided for @addManually.
  ///
  /// In en, this message translates to:
  /// **'Add Manually'**
  String get addManually;

  /// No description provided for @monthlySpend.
  ///
  /// In en, this message translates to:
  /// **'Monthly Spend'**
  String get monthlySpend;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @trial.
  ///
  /// In en, this message translates to:
  /// **'Trial'**
  String get trial;

  /// No description provided for @paused.
  ///
  /// In en, this message translates to:
  /// **'Paused'**
  String get paused;

  /// No description provided for @ended.
  ///
  /// In en, this message translates to:
  /// **'Ended'**
  String get ended;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @noFilteredSubscriptions.
  ///
  /// In en, this message translates to:
  /// **'No {filter} Subscriptions'**
  String noFilteredSubscriptions(Object filter);

  /// No description provided for @trySelectingDifferentFilter.
  ///
  /// In en, this message translates to:
  /// **'Try selecting a different filter'**
  String get trySelectingDifferentFilter;

  /// No description provided for @showAll.
  ///
  /// In en, this message translates to:
  /// **'Show All'**
  String get showAll;

  /// No description provided for @loadingSubscriptions.
  ///
  /// In en, this message translates to:
  /// **'Loading subscriptions...'**
  String get loadingSubscriptions;

  /// No description provided for @detailsFor.
  ///
  /// In en, this message translates to:
  /// **'Details for {name}'**
  String detailsFor(Object name);

  /// No description provided for @spendingInsights.
  ///
  /// In en, this message translates to:
  /// **'Spending Insights'**
  String get spendingInsights;

  /// No description provided for @errorLoadingCategories.
  ///
  /// In en, this message translates to:
  /// **'Error loading categories: {error}'**
  String errorLoadingCategories(Object error);

  /// No description provided for @notEnoughDataForInsights.
  ///
  /// In en, this message translates to:
  /// **'Not enough data for insights yet.'**
  String get notEnoughDataForInsights;

  /// No description provided for @connectEmailInsights.
  ///
  /// In en, this message translates to:
  /// **'Connect your email to see your spending patterns.'**
  String get connectEmailInsights;

  /// No description provided for @monthlyTrend.
  ///
  /// In en, this message translates to:
  /// **'Monthly Trend'**
  String get monthlyTrend;

  /// No description provided for @topMerchants.
  ///
  /// In en, this message translates to:
  /// **'Top Merchants'**
  String get topMerchants;

  /// No description provided for @totalVolume.
  ///
  /// In en, this message translates to:
  /// **'Total Volume'**
  String get totalVolume;

  /// No description provided for @avgPerDay.
  ///
  /// In en, this message translates to:
  /// **'Avg. / Day'**
  String get avgPerDay;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @continueText.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueText;

  /// No description provided for @onboardingTitle1.
  ///
  /// In en, this message translates to:
  /// **'Take Control of Your Spending'**
  String get onboardingTitle1;

  /// No description provided for @onboardingDesc1.
  ///
  /// In en, this message translates to:
  /// **'PennyPilot helps you navigate your finances with ease and precision.'**
  String get onboardingDesc1;

  /// No description provided for @onboardingTitle2.
  ///
  /// In en, this message translates to:
  /// **'Privacy is Our Priority'**
  String get onboardingTitle2;

  /// No description provided for @onboardingDesc2.
  ///
  /// In en, this message translates to:
  /// **'Your data never leaves your device. Everything is processed locally for maximum security.'**
  String get onboardingDesc2;

  /// No description provided for @onboardingTitle3.
  ///
  /// In en, this message translates to:
  /// **'AI-Powered Insights'**
  String get onboardingTitle3;

  /// No description provided for @onboardingDesc3.
  ///
  /// In en, this message translates to:
  /// **'On-device AI automatically identifies transactions and tracks subscriptions from your emails.'**
  String get onboardingDesc3;

  /// No description provided for @connectAccounts.
  ///
  /// In en, this message translates to:
  /// **'Connect Accounts'**
  String get connectAccounts;

  /// No description provided for @linkEmailDescription.
  ///
  /// In en, this message translates to:
  /// **'Link your email to automatically track expenses.'**
  String get linkEmailDescription;

  /// No description provided for @connectGmail.
  ///
  /// In en, this message translates to:
  /// **'Connect Gmail'**
  String get connectGmail;

  /// No description provided for @connectedTo.
  ///
  /// In en, this message translates to:
  /// **'Connected to {account}'**
  String connectedTo(String account);

  /// No description provided for @failedToConnect.
  ///
  /// In en, this message translates to:
  /// **'Failed to connect: {error}'**
  String failedToConnect(Object error);

  /// No description provided for @connectOutlook.
  ///
  /// In en, this message translates to:
  /// **'Connect Outlook'**
  String get connectOutlook;

  /// No description provided for @connectICloud.
  ///
  /// In en, this message translates to:
  /// **'Connect iCloud'**
  String get connectICloud;

  /// No description provided for @tryDemoMode.
  ///
  /// In en, this message translates to:
  /// **'Try Demo Mode (Mock Data)'**
  String get tryDemoMode;

  /// No description provided for @privacyDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'We only read emails related to receipts and subscriptions. No data leaves your device.'**
  String get privacyDisclaimer;

  /// No description provided for @transactionRecorded.
  ///
  /// In en, this message translates to:
  /// **'Transaction recorded'**
  String get transactionRecorded;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String error(Object error);

  /// No description provided for @newEntry.
  ///
  /// In en, this message translates to:
  /// **'New Entry'**
  String get newEntry;

  /// No description provided for @expense.
  ///
  /// In en, this message translates to:
  /// **'Expense'**
  String get expense;

  /// No description provided for @incomeLabel.
  ///
  /// In en, this message translates to:
  /// **'Income'**
  String get incomeLabel;

  /// No description provided for @pleaseEnterAmount.
  ///
  /// In en, this message translates to:
  /// **'Please enter an amount'**
  String get pleaseEnterAmount;

  /// No description provided for @invalidAmount.
  ///
  /// In en, this message translates to:
  /// **'Invalid amount'**
  String get invalidAmount;

  /// No description provided for @source.
  ///
  /// In en, this message translates to:
  /// **'Source'**
  String get source;

  /// No description provided for @merchantLabel.
  ///
  /// In en, this message translates to:
  /// **'Merchant'**
  String get merchantLabel;

  /// No description provided for @pleaseEnterSource.
  ///
  /// In en, this message translates to:
  /// **'Please enter source'**
  String get pleaseEnterSource;

  /// No description provided for @pleaseEnterMerchant.
  ///
  /// In en, this message translates to:
  /// **'Please enter merchant'**
  String get pleaseEnterMerchant;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @pleaseSelectCategory.
  ///
  /// In en, this message translates to:
  /// **'Please select a category'**
  String get pleaseSelectCategory;

  /// No description provided for @recurring.
  ///
  /// In en, this message translates to:
  /// **'Recurring'**
  String get recurring;

  /// No description provided for @recurringIncomeDescription.
  ///
  /// In en, this message translates to:
  /// **'Regular income like salary'**
  String get recurringIncomeDescription;

  /// No description provided for @recurringExpenseDescription.
  ///
  /// In en, this message translates to:
  /// **'Repeating expense like subscription'**
  String get recurringExpenseDescription;

  /// No description provided for @saveTransaction.
  ///
  /// In en, this message translates to:
  /// **'Save Transaction'**
  String get saveTransaction;

  /// No description provided for @subscriptionAdded.
  ///
  /// In en, this message translates to:
  /// **'Subscription added successfully'**
  String get subscriptionAdded;

  /// No description provided for @errorAddingSubscription.
  ///
  /// In en, this message translates to:
  /// **'Error adding subscription: {error}'**
  String errorAddingSubscription(Object error);

  /// No description provided for @serviceName.
  ///
  /// In en, this message translates to:
  /// **'Service Name'**
  String get serviceName;

  /// No description provided for @serviceNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Netflix, Spotify'**
  String get serviceNameHint;

  /// No description provided for @required.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get required;

  /// No description provided for @invalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid'**
  String get invalid;

  /// No description provided for @billingCycle.
  ///
  /// In en, this message translates to:
  /// **'Billing Cycle'**
  String get billingCycle;

  /// No description provided for @nextRenewalDate.
  ///
  /// In en, this message translates to:
  /// **'Next Renewal Date'**
  String get nextRenewalDate;

  /// No description provided for @notesOptional.
  ///
  /// In en, this message translates to:
  /// **'Notes (Optional)'**
  String get notesOptional;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get tryAgain;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'el', 'en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'el':
      return AppLocalizationsEl();
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
