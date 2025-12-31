// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appName => 'PennyPilot';

  @override
  String get demo => 'DEMO';

  @override
  String get scanEmails => 'E-Mails scannen';

  @override
  String errorScanning(String error) {
    return 'Fehler beim Scannen: $error';
  }

  @override
  String get spendingByCategory => 'Ausgaben nach Kategorie';

  @override
  String get spendingPulse => 'Ausgabenverlauf';

  @override
  String get recentTransactions => 'Letzte Transaktionen';

  @override
  String get viewAll => 'Alle anzeigen';

  @override
  String errorLoadingTransactions(String error) {
    return 'Fehler beim Laden der Transaktionen: $error';
  }

  @override
  String get upcomingSubscriptions => 'Anstehende Abonnements';

  @override
  String get noActiveSubscriptions => 'Keine aktiven Abonnements gefunden.';

  @override
  String renewingInDays(int days) {
    return 'Verlängerung in $days Tagen';
  }

  @override
  String errorLoadingSubscriptions(String error) {
    return 'Fehler beim Laden der Abonnements: $error';
  }

  @override
  String get noTransactionsYet => 'Noch keine Transaktionen';

  @override
  String get connectEmailDescription =>
      'Verbinden Sie Ihre E-Mail, um automatisch nach Quittungen zu suchen und Ihre Ausgaben zu verfolgen.';

  @override
  String get connectEmail => 'E-Mail verbinden';

  @override
  String get overview => 'Übersicht';

  @override
  String get transactions => 'Transaktionen';

  @override
  String get subs => 'Abos';

  @override
  String get insights => 'Einblicke';

  @override
  String get settings => 'Einstellungen';

  @override
  String get appearance => 'Erscheinungsbild';

  @override
  String get light => 'Hell';

  @override
  String get dark => 'Dunkel';

  @override
  String get system => 'System';

  @override
  String get pitchBlackOled => 'Tiefschwarz (OLED)';

  @override
  String get oledDescription =>
      'Vollständig schwarzer Hintergrund für OLED-Bildschirme';

  @override
  String get accounts => 'Konten';

  @override
  String get manageConnectedAccounts => 'Verbundene Konten verwalten';

  @override
  String get noAccountsConnected => 'Keine Konten verbunden';

  @override
  String accountsConnected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Konten verbunden',
      one: '1 Konto verbunden',
    );
    return '$_temp0';
  }

  @override
  String get general => 'Allgemein';

  @override
  String get primaryCurrency => 'Primärwährung';

  @override
  String get manageCategories => 'Kategorien verwalten';

  @override
  String get privacySecurity => 'Datenschutz & Sicherheit';

  @override
  String get privacyAudit => 'Datenschutz-Audit';

  @override
  String get rescanEmails => 'E-Mails erneut scannen';

  @override
  String get scanningEmails => 'E-Mails werden gescannt...';

  @override
  String get scanComplete => 'Scan abgeschlossen';

  @override
  String scanFailed(String error) {
    return 'Scan fehlgeschlagen: $error';
  }

  @override
  String get backups => 'Sicherungen';

  @override
  String get aboutPennyPilot => 'Über PennyPilot';

  @override
  String get selectCurrency => 'Währung wählen';

  @override
  String get searchHint => 'Nach Händler oder Notizen suchen...';

  @override
  String get closeSearch => 'Suche schließen';

  @override
  String get search => 'Suchen';

  @override
  String get scanReceipt => 'Quittung scannen';

  @override
  String get filterAndSort => 'Filtern & Sortieren';

  @override
  String get noMatches => 'Keine Treffer';

  @override
  String get tryAdjustingFilters => 'Versuchen Sie, die Filter anzupassen';

  @override
  String get clearFilters => 'Filter löschen';

  @override
  String get loadingTransactions => 'Transaktionen werden geladen...';

  @override
  String get failedToLoad => 'Laden fehlgeschlagen';

  @override
  String get addEntry => 'Eintrag hinzufügen';

  @override
  String get income => 'Einnahmen';

  @override
  String get expenses => 'Ausgaben';

  @override
  String get net => 'Netto';

  @override
  String categoryFilter(String category) {
    return 'Kategorie: $category';
  }

  @override
  String sortFilter(String sort) {
    return 'Sortierung: $sort';
  }

  @override
  String get date => 'Datum';

  @override
  String get amount => 'Betrag';

  @override
  String get merchant => 'Händler';

  @override
  String get reset => 'Zurücksetzen';

  @override
  String get apply => 'Anwenden';

  @override
  String get subscriptions => 'Abonnements';

  @override
  String get addSubscription => 'Abonnement hinzufügen';

  @override
  String get noSubscriptionsFound => 'Keine Abonnements gefunden';

  @override
  String get noSubscriptionsDescription =>
      'Wir erkennen Abonnements automatisch aus Ihren Transaktionen, oder Sie können sie manuell hinzufügen.';

  @override
  String get addManually => 'Manuell hinzufügen';

  @override
  String get monthlySpend => 'Monatliche Ausgaben';

  @override
  String get active => 'Aktiv';

  @override
  String get trial => 'Testzeitraum';

  @override
  String get paused => 'Pausiert';

  @override
  String get ended => 'Beendet';

  @override
  String get all => 'Alle';

  @override
  String noFilteredSubscriptions(Object filter) {
    return 'Keine $filter Abonnements';
  }

  @override
  String get trySelectingDifferentFilter =>
      'Versuchen Sie es mit einem anderen Filter';

  @override
  String get showAll => 'Alle anzeigen';

  @override
  String get loadingSubscriptions => 'Abonnements werden geladen...';

  @override
  String detailsFor(Object name) {
    return 'Details für $name';
  }

  @override
  String get spendingInsights => 'Ausgaben-Einblicke';

  @override
  String errorLoadingCategories(Object error) {
    return 'Fehler beim Laden der Kategorien: $error';
  }

  @override
  String get notEnoughDataForInsights =>
      'Noch nicht genügend Daten für Einblicke vorhanden.';

  @override
  String get connectEmailInsights =>
      'Verbinden Sie Ihre E-Mail, um Ihre Ausgabenmuster zu sehen.';

  @override
  String get monthlyTrend => 'Monatlicher Trend';

  @override
  String get topMerchants => 'Top-Händler';

  @override
  String get totalVolume => 'Gesamtvolumen';

  @override
  String get avgPerDay => 'Durchschn. / Tag';

  @override
  String get other => 'Andere';

  @override
  String get skip => 'Überspringen';

  @override
  String get getStarted => 'Jetzt loslegen';

  @override
  String get continueText => 'Weiter';

  @override
  String get onboardingTitle1 =>
      'Übernehmen Sie die Kontrolle über Ihre Ausgaben';

  @override
  String get onboardingDesc1 =>
      'PennyPilot hilft Ihnen, Ihre Finanzen mit Leichtigkeit und Präzision zu steuern.';

  @override
  String get onboardingTitle2 => 'Datenschutz ist unsere Priorität';

  @override
  String get onboardingDesc2 =>
      'Ihre Daten verlassen niemals Ihr Gerät. Alles wird lokal verarbeitet, um maximale Sicherheit zu gewährleisten.';

  @override
  String get onboardingTitle3 => 'KI-gestützte Einblicke';

  @override
  String get onboardingDesc3 =>
      'Die geräteinterne KI identifiziert automatisch Transaktionen und verfolgt Abonnements aus Ihren E-Mails.';

  @override
  String get connectAccounts => 'Konten verbinden';

  @override
  String get linkEmailDescription =>
      'Verknüpfen Sie Ihre E-Mail, um Ausgaben automatisch zu erfassen.';

  @override
  String get connectGmail => 'Mit Gmail verbinden';

  @override
  String connectedTo(String account) {
    return 'Verbunden mit $account';
  }

  @override
  String failedToConnect(Object error) {
    return 'Verbindung fehlgeschlagen: $error';
  }

  @override
  String get connectOutlook => 'Mit Outlook verbinden';

  @override
  String get connectICloud => 'Mit iCloud verbinden';

  @override
  String get tryDemoMode => 'Demo-Modus ausprobieren (Beispieldaten)';

  @override
  String get privacyDisclaimer =>
      'Wir lesen nur E-Mails im Zusammenhang mit Quittungen und Abonnements. Es verlassen keine Daten Ihr Gerät.';

  @override
  String get transactionRecorded => 'Transaktion aufgezeichnet';

  @override
  String error(Object error) {
    return 'Fehler: $error';
  }

  @override
  String get newEntry => 'Neuer Eintrag';

  @override
  String get expense => 'Ausgabe';

  @override
  String get incomeLabel => 'Einnahme';

  @override
  String get pleaseEnterAmount => 'Bitte geben Sie einen Betrag ein';

  @override
  String get invalidAmount => 'Ungültiger Betrag';

  @override
  String get source => 'Quelle';

  @override
  String get merchantLabel => 'Händler';

  @override
  String get pleaseEnterSource => 'Bitte Quelle eingeben';

  @override
  String get pleaseEnterMerchant => 'Bitte Händler eingeben';

  @override
  String get category => 'Kategorie';

  @override
  String get pleaseSelectCategory => 'Bitte wählen Sie eine Kategorie';

  @override
  String get recurring => 'Wiederkehrend';

  @override
  String get recurringIncomeDescription => 'Regelmäßiges Einkommen wie Gehalt';

  @override
  String get recurringExpenseDescription =>
      'Wiederkehrende Ausgabe wie Abonnement';

  @override
  String get saveTransaction => 'Transaktion speichern';

  @override
  String get subscriptionAdded => 'Abonnement erfolgreich hinzugefügt';

  @override
  String errorAddingSubscription(Object error) {
    return 'Fehler beim Hinzufügen des Abonnements: $error';
  }

  @override
  String get serviceName => 'Dienstname';

  @override
  String get serviceNameHint => 'z. B. Netflix, Spotify';

  @override
  String get required => 'Erforderlich';

  @override
  String get invalid => 'Ungültig';

  @override
  String get billingCycle => 'Abrechnungszyklus';

  @override
  String get nextRenewalDate => 'Nächstes Erneuerungsdatum';

  @override
  String get notesOptional => 'Notizen (optional)';

  @override
  String get tryAgain => 'Erneut versuchen';
}
