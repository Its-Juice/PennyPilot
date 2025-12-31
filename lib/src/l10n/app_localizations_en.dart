// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'PennyPilot';

  @override
  String get demo => 'DEMO';

  @override
  String get scanEmails => 'Scan Emails';

  @override
  String errorScanning(String error) {
    return 'Error scanning: $error';
  }

  @override
  String get spendingByCategory => 'Spending by Category';

  @override
  String get spendingPulse => 'Spending Pulse';

  @override
  String get recentTransactions => 'Recent Transactions';

  @override
  String get viewAll => 'View All';

  @override
  String errorLoadingTransactions(String error) {
    return 'Error loading transactions: $error';
  }

  @override
  String get upcomingSubscriptions => 'Upcoming Subscriptions';

  @override
  String get noActiveSubscriptions => 'No active subscriptions detected.';

  @override
  String renewingInDays(int days) {
    return 'Renewing in $days days';
  }

  @override
  String errorLoadingSubscriptions(String error) {
    return 'Error loading subscriptions: $error';
  }

  @override
  String get noTransactionsYet => 'No Transactions Yet';

  @override
  String get connectEmailDescription =>
      'Connect your email to automatically scan for receipts and track your spending.';

  @override
  String get connectEmail => 'Connect Email';

  @override
  String get overview => 'Overview';

  @override
  String get transactions => 'Transactions';

  @override
  String get subs => 'Subs';

  @override
  String get insights => 'Insights';

  @override
  String get settings => 'Settings';

  @override
  String get appearance => 'Appearance';

  @override
  String get light => 'Light';

  @override
  String get dark => 'Dark';

  @override
  String get system => 'System';

  @override
  String get pitchBlackOled => 'Pitch Black OLED';

  @override
  String get oledDescription => 'Completely black background for OLED screens';

  @override
  String get accounts => 'Accounts';

  @override
  String get manageConnectedAccounts => 'Manage connected accounts';

  @override
  String get noAccountsConnected => 'No accounts connected';

  @override
  String accountsConnected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count accounts connected',
      one: '1 account connected',
    );
    return '$_temp0';
  }

  @override
  String get general => 'General';

  @override
  String get primaryCurrency => 'Primary Currency';

  @override
  String get manageCategories => 'Manage Categories';

  @override
  String get privacySecurity => 'Privacy & Security';

  @override
  String get privacyAudit => 'Privacy Audit';

  @override
  String get rescanEmails => 'Rescan Emails';

  @override
  String get scanningEmails => 'Scanning emails...';

  @override
  String get scanComplete => 'Scan complete';

  @override
  String scanFailed(String error) {
    return 'Scan failed: $error';
  }

  @override
  String get backups => 'Backups';

  @override
  String get aboutPennyPilot => 'About PennyPilot';

  @override
  String get selectCurrency => 'Select Currency';

  @override
  String get searchHint => 'Search merchant or notes...';

  @override
  String get closeSearch => 'Close Search';

  @override
  String get search => 'Search';

  @override
  String get scanReceipt => 'Scan Receipt';

  @override
  String get filterAndSort => 'Filter & Sort';

  @override
  String get noMatches => 'No Matches';

  @override
  String get tryAdjustingFilters => 'Try adjusting your filters';

  @override
  String get clearFilters => 'Clear Filters';

  @override
  String get loadingTransactions => 'Loading transactions...';

  @override
  String get failedToLoad => 'Failed to Load';

  @override
  String get addEntry => 'Add Entry';

  @override
  String get income => 'Income';

  @override
  String get expenses => 'Expenses';

  @override
  String get net => 'Net';

  @override
  String categoryFilter(String category) {
    return 'Category: $category';
  }

  @override
  String sortFilter(String sort) {
    return 'Sort: $sort';
  }

  @override
  String get date => 'Date';

  @override
  String get amount => 'Amount';

  @override
  String get merchant => 'Merchant';

  @override
  String get reset => 'Reset';

  @override
  String get apply => 'Apply';

  @override
  String get subscriptions => 'Subscriptions';

  @override
  String get addSubscription => 'Add Subscription';

  @override
  String get noSubscriptionsFound => 'No Subscriptions Found';

  @override
  String get noSubscriptionsDescription =>
      'We\'ll automatically detect subscriptions from your transactions, or you can add them manually.';

  @override
  String get addManually => 'Add Manually';

  @override
  String get monthlySpend => 'Monthly Spend';

  @override
  String get active => 'Active';

  @override
  String get trial => 'Trial';

  @override
  String get paused => 'Paused';

  @override
  String get ended => 'Ended';

  @override
  String get all => 'All';

  @override
  String noFilteredSubscriptions(Object filter) {
    return 'No $filter Subscriptions';
  }

  @override
  String get trySelectingDifferentFilter => 'Try selecting a different filter';

  @override
  String get showAll => 'Show All';

  @override
  String get loadingSubscriptions => 'Loading subscriptions...';

  @override
  String detailsFor(Object name) {
    return 'Details for $name';
  }

  @override
  String get spendingInsights => 'Spending Insights';

  @override
  String errorLoadingCategories(Object error) {
    return 'Error loading categories: $error';
  }

  @override
  String get notEnoughDataForInsights => 'Not enough data for insights yet.';

  @override
  String get connectEmailInsights =>
      'Connect your email to see your spending patterns.';

  @override
  String get monthlyTrend => 'Monthly Trend';

  @override
  String get topMerchants => 'Top Merchants';

  @override
  String get totalVolume => 'Total Volume';

  @override
  String get avgPerDay => 'Avg. / Day';

  @override
  String get other => 'Other';

  @override
  String get skip => 'Skip';

  @override
  String get getStarted => 'Get Started';

  @override
  String get continueText => 'Continue';

  @override
  String get onboardingTitle1 => 'Take Control of Your Spending';

  @override
  String get onboardingDesc1 =>
      'PennyPilot helps you navigate your finances with ease and precision.';

  @override
  String get onboardingTitle2 => 'Privacy is Our Priority';

  @override
  String get onboardingDesc2 =>
      'Your data never leaves your device. Everything is processed locally for maximum security.';

  @override
  String get onboardingTitle3 => 'AI-Powered Insights';

  @override
  String get onboardingDesc3 =>
      'On-device AI automatically identifies transactions and tracks subscriptions from your emails.';

  @override
  String get connectAccounts => 'Connect Accounts';

  @override
  String get linkEmailDescription =>
      'Link your email to automatically track expenses.';

  @override
  String get connectGmail => 'Connect Gmail';

  @override
  String connectedTo(String account) {
    return 'Connected to $account';
  }

  @override
  String failedToConnect(Object error) {
    return 'Failed to connect: $error';
  }

  @override
  String get connectOutlook => 'Connect Outlook';

  @override
  String get connectICloud => 'Connect iCloud';

  @override
  String get tryDemoMode => 'Try Demo Mode (Mock Data)';

  @override
  String get privacyDisclaimer =>
      'We only read emails related to receipts and subscriptions. No data leaves your device.';

  @override
  String get transactionRecorded => 'Transaction recorded';

  @override
  String error(Object error) {
    return 'Error: $error';
  }

  @override
  String get newEntry => 'New Entry';

  @override
  String get expense => 'Expense';

  @override
  String get incomeLabel => 'Income';

  @override
  String get pleaseEnterAmount => 'Please enter an amount';

  @override
  String get invalidAmount => 'Invalid amount';

  @override
  String get source => 'Source';

  @override
  String get merchantLabel => 'Merchant';

  @override
  String get pleaseEnterSource => 'Please enter source';

  @override
  String get pleaseEnterMerchant => 'Please enter merchant';

  @override
  String get category => 'Category';

  @override
  String get pleaseSelectCategory => 'Please select a category';

  @override
  String get recurring => 'Recurring';

  @override
  String get recurringIncomeDescription => 'Regular income like salary';

  @override
  String get recurringExpenseDescription =>
      'Repeating expense like subscription';

  @override
  String get saveTransaction => 'Save Transaction';

  @override
  String get subscriptionAdded => 'Subscription added successfully';

  @override
  String errorAddingSubscription(Object error) {
    return 'Error adding subscription: $error';
  }

  @override
  String get serviceName => 'Service Name';

  @override
  String get serviceNameHint => 'e.g. Netflix, Spotify';

  @override
  String get required => 'Required';

  @override
  String get invalid => 'Invalid';

  @override
  String get billingCycle => 'Billing Cycle';

  @override
  String get nextRenewalDate => 'Next Renewal Date';

  @override
  String get notesOptional => 'Notes (Optional)';

  @override
  String get tryAgain => 'Try Again';
}
