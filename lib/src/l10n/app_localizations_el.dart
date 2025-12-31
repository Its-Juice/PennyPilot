// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Modern Greek (`el`).
class AppLocalizationsEl extends AppLocalizations {
  AppLocalizationsEl([String locale = 'el']) : super(locale);

  @override
  String get appName => 'PennyPilot';

  @override
  String get demo => 'ΔΟΚΙΜΗ';

  @override
  String get scanEmails => 'Σάρωση E-mail';

  @override
  String errorScanning(String error) {
    return 'Σφάλμα σάρωσης: $error';
  }

  @override
  String get spendingByCategory => 'Δαπάνες ανά κατηγορία';

  @override
  String get spendingPulse => 'Παλμός δαπανών';

  @override
  String get recentTransactions => 'Πρόσφατες Συναλλαγές';

  @override
  String get viewAll => 'Προβολή όλων';

  @override
  String errorLoadingTransactions(String error) {
    return 'Σφάλμα φόρτωσης συναλλαγών: $error';
  }

  @override
  String get upcomingSubscriptions => 'Επόμενες Συνδρομές';

  @override
  String get noActiveSubscriptions => 'Δεν εντοπίστηκαν ενεργές συνδρομές.';

  @override
  String renewingInDays(int days) {
    return 'Ανανέωση σε $days ημέρες';
  }

  @override
  String errorLoadingSubscriptions(String error) {
    return 'Σφάλμα φόρτωσης συνδρομών: $error';
  }

  @override
  String get noTransactionsYet => 'Καμία συναλλαγή ακόμα';

  @override
  String get connectEmailDescription =>
      'Συνδέστε το email σας για αυτόματη σάρωση αποδείξεων και παρακολούθηση των δαπανών σας.';

  @override
  String get connectEmail => 'Σύνδεση Email';

  @override
  String get overview => 'Επισκόπηση';

  @override
  String get transactions => 'Συναλλαγές';

  @override
  String get subs => 'Συνδρομές';

  @override
  String get insights => 'Αναλύσεις';

  @override
  String get settings => 'Ρυθμίσεις';

  @override
  String get appearance => 'Εμφάνιση';

  @override
  String get light => 'Φωτεινό';

  @override
  String get dark => 'Σκοτεινό';

  @override
  String get system => 'Σύστημα';

  @override
  String get pitchBlackOled => 'Απόλυτο Μαύρο (OLED)';

  @override
  String get oledDescription => 'Πλήρως μαύρο φόντο για οθόνες OLED';

  @override
  String get accounts => 'Λογαριασμοί';

  @override
  String get manageConnectedAccounts => 'Διαχείριση συνδεδεμένων λογαριασμών';

  @override
  String get noAccountsConnected => 'Κανένας συνδεδεμένος λογαριασμός';

  @override
  String accountsConnected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count λογαριασμοί συνδεδεμένοι',
      one: '1 λογαριασμός συνδεδεμένος',
    );
    return '$_temp0';
  }

  @override
  String get general => 'Γενικά';

  @override
  String get primaryCurrency => 'Κύριο Νόμισμα';

  @override
  String get manageCategories => 'Διαχείριση Κατηγοριών';

  @override
  String get privacySecurity => 'Απόρρητο & Ασφάλεια';

  @override
  String get privacyAudit => 'Έλεγχος Απορρήτου';

  @override
  String get rescanEmails => 'Επανασάρωση Email';

  @override
  String get scanningEmails => 'Σάρωση email...';

  @override
  String get scanComplete => 'Η σάρωση ολοκληρώθηκε';

  @override
  String scanFailed(String error) {
    return 'Η σάρωση απέτυχε: $error';
  }

  @override
  String get backups => 'Αντίγραφα ασφαλείας';

  @override
  String get aboutPennyPilot => 'Σχετικά με το PennyPilot';

  @override
  String get selectCurrency => 'Επιλογή Νομίσματος';

  @override
  String get searchHint => 'Αναζήτηση εμπόρου ή σημειώσεων...';

  @override
  String get closeSearch => 'Κλείσιμο Αναζήτησης';

  @override
  String get search => 'Αναζήτηση';

  @override
  String get scanReceipt => 'Σάρωση Απόδειξης';

  @override
  String get filterAndSort => 'Φιλτράρισμα & Ταξινόμηση';

  @override
  String get noMatches => 'Δεν βρέθηκαν αποτελέσματα';

  @override
  String get tryAdjustingFilters => 'Δοκιμάστε να προσαρμόσετε τα φίλτρα σας';

  @override
  String get clearFilters => 'Καθαρισμός Φίλτρων';

  @override
  String get loadingTransactions => 'Φόρτωση συναλλαγών...';

  @override
  String get failedToLoad => 'Αποτυχία Φόρτωσης';

  @override
  String get addEntry => 'Προσθήκη Εγγραφής';

  @override
  String get income => 'Έσοδα';

  @override
  String get expenses => 'Έξοδα';

  @override
  String get net => 'Καθαρά';

  @override
  String categoryFilter(String category) {
    return 'Κατηγορία: $category';
  }

  @override
  String sortFilter(String sort) {
    return 'Ταξινόμηση: $sort';
  }

  @override
  String get date => 'Ημερομηνία';

  @override
  String get amount => 'Ποσό';

  @override
  String get merchant => 'Έμπορος';

  @override
  String get reset => 'Επαναφορά';

  @override
  String get apply => 'Εφαρμογή';

  @override
  String get subscriptions => 'Συνδρομές';

  @override
  String get addSubscription => 'Προσθήκη Συνδρομής';

  @override
  String get noSubscriptionsFound => 'Δεν βρέθηκαν συνδρομές';

  @override
  String get noSubscriptionsDescription =>
      'Θα εντοπίσουμε αυτόματα συνδρομές από τις συναλλαγές σας ή μπορείτε να τις προσθέσετε χειροκίνητα.';

  @override
  String get addManually => 'Μη αυτόματη προσθήκη';

  @override
  String get monthlySpend => 'Μηνιαία Δαπάνη';

  @override
  String get active => 'Ενεργή';

  @override
  String get trial => 'Δοκιμαστική';

  @override
  String get paused => 'Σε παύση';

  @override
  String get ended => 'Έχει λήξει';

  @override
  String get all => 'Όλες';

  @override
  String noFilteredSubscriptions(Object filter) {
    return 'Καμία $filter συνδρομή';
  }

  @override
  String get trySelectingDifferentFilter =>
      'Δοκιμάστε να επιλέξετε διαφορετικό φίλτρο';

  @override
  String get showAll => 'Εμφάνιση όλων';

  @override
  String get loadingSubscriptions => 'Φόρτωση συνδρομών...';

  @override
  String detailsFor(Object name) {
    return 'Λεπτομέρειες για $name';
  }

  @override
  String get spendingInsights => 'Αναλύσεις Δαπανών';

  @override
  String errorLoadingCategories(Object error) {
    return 'Σφάλμα φόρτωσης κατηγοριών: $error';
  }

  @override
  String get notEnoughDataForInsights =>
      'Δεν υπάρχουν αρκετά δεδομένα για αναλύσεις ακόμα.';

  @override
  String get connectEmailInsights =>
      'Συνδέστε το email σας για να δείτε τα μοτίβα δαπανών σας.';

  @override
  String get monthlyTrend => 'Μηνιαία Τάση';

  @override
  String get topMerchants => 'Κορυφαίοι Έμποροι';

  @override
  String get totalVolume => 'Συνολικός Όγκος';

  @override
  String get avgPerDay => 'ΜΟ / Ημέρα';

  @override
  String get other => 'Άλλο';

  @override
  String get skip => 'Παράλειψη';

  @override
  String get getStarted => 'Ξεκινήστε';

  @override
  String get continueText => 'Συνέχεια';

  @override
  String get onboardingTitle1 => 'Πάρτε τον έλεγχο των δαπανών σας';

  @override
  String get onboardingDesc1 =>
      'Το PennyPilot σας βοηθά να διαχειρίζεστε τα οικονομικά σας με ευκολία και ακρίβεια.';

  @override
  String get onboardingTitle2 => 'Η ιδιωτικότητα είναι προτεραιότητά μας';

  @override
  String get onboardingDesc2 =>
      'Τα δεδομένα σας δεν φεύγουν ποτέ από τη συσκευή σας. Όλα υποβάλλονται σε επεξεργασία τοπικά για μέγιστη ασφάλεια.';

  @override
  String get onboardingTitle3 => 'Αναλύσεις με τη βοήθεια τεχνητής νοημοσύνης';

  @override
  String get onboardingDesc3 =>
      'Η τεχνητή νοημοσύνη στη συσκευή εντοπίζει αυτόματα συναλλαγές και παρακολουθεί συνδρομές από τα email σας.';

  @override
  String get connectAccounts => 'Σύνδεση Λογαριασμών';

  @override
  String get linkEmailDescription =>
      'Συνδέστε το email σας για αυτόματη παρακολούθηση εξόδων.';

  @override
  String get connectGmail => 'Σύνδεση Gmail';

  @override
  String connectedTo(String account) {
    return 'Συνδέθηκε στο $account';
  }

  @override
  String failedToConnect(Object error) {
    return 'Αποτυχία σύνδεσης: $error';
  }

  @override
  String get connectOutlook => 'Σύνδεση Outlook';

  @override
  String get connectICloud => 'Σύνδεση iCloud';

  @override
  String get tryDemoMode => 'Δοκιμή Demo (Εικονικά Δεδομένα)';

  @override
  String get privacyDisclaimer =>
      'Διαβάζουμε μόνο email που σχετίζονται με αποδείξεις και συνδρομές. Κανένα δεδομένο δεν φεύγει από τη συσκευή σας.';

  @override
  String get transactionRecorded => 'Η συναλλαγή καταγράφηκε';

  @override
  String error(Object error) {
    return 'Σφάλμα: $error';
  }

  @override
  String get newEntry => 'Νέα Εγγραφή';

  @override
  String get expense => 'Έξοδο';

  @override
  String get incomeLabel => 'Έσοδο';

  @override
  String get pleaseEnterAmount => 'Παρακαλώ εισάγετε ένα ποσό';

  @override
  String get invalidAmount => 'Μη έγκυρο ποσό';

  @override
  String get source => 'Πηγή';

  @override
  String get merchantLabel => 'Έμπορος';

  @override
  String get pleaseEnterSource => 'Παρακαλώ εισάγετε πηγή';

  @override
  String get pleaseEnterMerchant => 'Παρακαλώ εισάγετε έμπορο';

  @override
  String get category => 'Κατηγορία';

  @override
  String get pleaseSelectCategory => 'Παρακαλώ επιλέξτε κατηγορία';

  @override
  String get recurring => 'Επαναλαμβανόμενη';

  @override
  String get recurringIncomeDescription => 'Τακτικό εισόδημα όπως ο μισθός';

  @override
  String get recurringExpenseDescription =>
      'Επαναλαμβανόμενο έξοδο όπως μια συνδρομή';

  @override
  String get saveTransaction => 'Αποθήκευση Συναλλαγής';

  @override
  String get subscriptionAdded => 'Η συνδρομή προστέθηκε με επιτυχία';

  @override
  String errorAddingSubscription(Object error) {
    return 'Σφάλμα κατά την προσθήκη συνδρομής: $error';
  }

  @override
  String get serviceName => 'Όνομα Υπηρεσίας';

  @override
  String get serviceNameHint => 'π.χ. Netflix, Spotify';

  @override
  String get required => 'Απαιτείται';

  @override
  String get invalid => 'Μη έγκυρο';

  @override
  String get billingCycle => 'Κύκλος Χρέωσης';

  @override
  String get nextRenewalDate => 'Επόμενη Ημερομηνία Ανανέωσης';

  @override
  String get notesOptional => 'Σημειώσεις (Προαιρετικό)';

  @override
  String get tryAgain => 'Δοκιμάστε Ξανά';
}
