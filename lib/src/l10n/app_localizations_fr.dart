// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appName => 'PennyPilot';

  @override
  String get demo => 'DÉMO';

  @override
  String get scanEmails => 'Analyser les e-mails';

  @override
  String errorScanning(String error) {
    return 'Erreur d\'analyse : $error';
  }

  @override
  String get spendingByCategory => 'Dépenses par catégorie';

  @override
  String get spendingPulse => 'Pouls des dépenses';

  @override
  String get recentTransactions => 'Transactions récentes';

  @override
  String get viewAll => 'Voir tout';

  @override
  String errorLoadingTransactions(String error) {
    return 'Erreur lors du chargement des transactions : $error';
  }

  @override
  String get upcomingSubscriptions => 'Abonnements à venir';

  @override
  String get noActiveSubscriptions => 'Aucun abonnement actif détecté.';

  @override
  String renewingInDays(int days) {
    return 'Renouvellement dans $days jours';
  }

  @override
  String errorLoadingSubscriptions(String error) {
    return 'Erreur lors du chargement des abonnements : $error';
  }

  @override
  String get noTransactionsYet => 'Pas encore de transactions';

  @override
  String get connectEmailDescription =>
      'Connectez votre e-mail pour analyser automatiquement les reçus et suivre vos dépenses.';

  @override
  String get connectEmail => 'Connecter l\'e-mail';

  @override
  String get overview => 'Aperçu';

  @override
  String get transactions => 'Transactions';

  @override
  String get subs => 'Abos';

  @override
  String get insights => 'Statistiques';

  @override
  String get settings => 'Paramètres';

  @override
  String get appearance => 'Apparence';

  @override
  String get light => 'Clair';

  @override
  String get dark => 'Sombre';

  @override
  String get system => 'Système';

  @override
  String get pitchBlackOled => 'Noir absolu (OLED)';

  @override
  String get oledDescription => 'Fond complètement noir pour les écrans OLED';

  @override
  String get accounts => 'Comptes';

  @override
  String get manageConnectedAccounts => 'Gérer les comptes connectés';

  @override
  String get noAccountsConnected => 'Aucun compte connecté';

  @override
  String accountsConnected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count comptes connectés',
      one: '1 compte connecté',
    );
    return '$_temp0';
  }

  @override
  String get general => 'Général';

  @override
  String get primaryCurrency => 'Devise principale';

  @override
  String get manageCategories => 'Gérer les catégories';

  @override
  String get privacySecurity => 'Confidentialité et sécurité';

  @override
  String get privacyAudit => 'Audit de confidentialité';

  @override
  String get rescanEmails => 'Analyser à nouveau les e-mails';

  @override
  String get scanningEmails => 'Analyse des e-mails en cours...';

  @override
  String get scanComplete => 'Analyse terminée';

  @override
  String scanFailed(String error) {
    return 'Échec de l\'analyse : $error';
  }

  @override
  String get backups => 'Sauvegardes';

  @override
  String get aboutPennyPilot => 'À propos de PennyPilot';

  @override
  String get selectCurrency => 'Sélectionner la devise';

  @override
  String get searchHint => 'Rechercher un commerçant ou des notes...';

  @override
  String get closeSearch => 'Fermer la recherche';

  @override
  String get search => 'Rechercher';

  @override
  String get scanReceipt => 'Scanner le reçu';

  @override
  String get filterAndSort => 'Filtrer et trier';

  @override
  String get noMatches => 'Aucun résultat';

  @override
  String get tryAdjustingFilters => 'Essayez d\'ajuster vos filtres';

  @override
  String get clearFilters => 'Effacer les filtres';

  @override
  String get loadingTransactions => 'Chargement des transactions...';

  @override
  String get failedToLoad => 'Échec du chargement';

  @override
  String get addEntry => 'Ajouter une entrée';

  @override
  String get income => 'Revenus';

  @override
  String get expenses => 'Dépenses';

  @override
  String get net => 'Net';

  @override
  String categoryFilter(String category) {
    return 'Catégorie : $category';
  }

  @override
  String sortFilter(String sort) {
    return 'Tri : $sort';
  }

  @override
  String get date => 'Date';

  @override
  String get amount => 'Montant';

  @override
  String get merchant => 'Commerçant';

  @override
  String get reset => 'Réinitialiser';

  @override
  String get apply => 'Appliquer';

  @override
  String get subscriptions => 'Abonnements';

  @override
  String get addSubscription => 'Ajouter un abonnement';

  @override
  String get noSubscriptionsFound => 'Aucun abonnement trouvé';

  @override
  String get noSubscriptionsDescription =>
      'Nous détecterons automatiquement les abonnements à partir de vos transactions, ou vous pouvez les ajouter manuellement.';

  @override
  String get addManually => 'Ajouter manuellement';

  @override
  String get monthlySpend => 'Dépense mensuelle';

  @override
  String get active => 'Actif';

  @override
  String get trial => 'Essai';

  @override
  String get paused => 'En pause';

  @override
  String get ended => 'Terminé';

  @override
  String get all => 'Tous';

  @override
  String noFilteredSubscriptions(Object filter) {
    return 'Aucun abonnement $filter';
  }

  @override
  String get trySelectingDifferentFilter =>
      'Essayez de sélectionner un filtre différent';

  @override
  String get showAll => 'Tout afficher';

  @override
  String get loadingSubscriptions => 'Chargement des abonnements...';

  @override
  String detailsFor(Object name) {
    return 'Détails pour $name';
  }

  @override
  String get spendingInsights => 'Aperçu des dépenses';

  @override
  String errorLoadingCategories(Object error) {
    return 'Erreur lors du chargement des catégories : $error';
  }

  @override
  String get notEnoughDataForInsights =>
      'Pas assez de données pour les statistiques pour le moment.';

  @override
  String get connectEmailInsights =>
      'Connectez votre e-mail pour voir vos habitudes de dépenses.';

  @override
  String get monthlyTrend => 'Tendance mensuelle';

  @override
  String get topMerchants => 'Top commerçants';

  @override
  String get totalVolume => 'Volume total';

  @override
  String get avgPerDay => 'Moy. / jour';

  @override
  String get other => 'Autre';

  @override
  String get skip => 'Passer';

  @override
  String get getStarted => 'Commencer';

  @override
  String get continueText => 'Continuer';

  @override
  String get onboardingTitle1 => 'Prenez le contrôle de vos dépenses';

  @override
  String get onboardingDesc1 =>
      'PennyPilot vous aide à gérer vos finances avec facilité et précision.';

  @override
  String get onboardingTitle2 => 'La confidentialité est notre priorité';

  @override
  String get onboardingDesc2 =>
      'Vos données ne quittent jamais votre appareil. Tout est traité localement pour une sécurité maximale.';

  @override
  String get onboardingTitle3 => 'Analyses assistées par l\'IA';

  @override
  String get onboardingDesc3 =>
      'L\'IA sur l\'appareil identifie automatiquement les transactions et suit les abonnements à partir de vos e-mails.';

  @override
  String get connectAccounts => 'Connecter les comptes';

  @override
  String get linkEmailDescription =>
      'Liez votre e-mail pour suivre automatiquement vos dépenses.';

  @override
  String get connectGmail => 'Connecter Gmail';

  @override
  String connectedTo(String account) {
    return 'Connecté à $account';
  }

  @override
  String failedToConnect(Object error) {
    return 'Échec de la connexion : $error';
  }

  @override
  String get connectOutlook => 'Connecter Outlook';

  @override
  String get connectICloud => 'Connecter iCloud';

  @override
  String get tryDemoMode => 'Essayer le mode démo (Données fictives)';

  @override
  String get privacyDisclaimer =>
      'Nous ne lisons que les e-mails liés aux reçus et aux abonnements. Aucune donnée ne quitte votre appareil.';

  @override
  String get transactionRecorded => 'Transaction enregistrée';

  @override
  String error(Object error) {
    return 'Erreur : $error';
  }

  @override
  String get newEntry => 'Nouvelle entrée';

  @override
  String get expense => 'Dépense';

  @override
  String get incomeLabel => 'Revenu';

  @override
  String get pleaseEnterAmount => 'Veuillez saisir un montant';

  @override
  String get invalidAmount => 'Montant invalide';

  @override
  String get source => 'Source';

  @override
  String get merchantLabel => 'Commerçant';

  @override
  String get pleaseEnterSource => 'Veuillez saisir la source';

  @override
  String get pleaseEnterMerchant => 'Veuillez saisir le commerçant';

  @override
  String get category => 'Catégorie';

  @override
  String get pleaseSelectCategory => 'Veuillez sélectionner une catégorie';

  @override
  String get recurring => 'Récurrent';

  @override
  String get recurringIncomeDescription => 'Revenu régulier comme un salaire';

  @override
  String get recurringExpenseDescription =>
      'Dépense répétitive comme un abonnement';

  @override
  String get saveTransaction => 'Enregistrer la transaction';

  @override
  String get subscriptionAdded => 'Abonnement ajouté avec succès';

  @override
  String errorAddingSubscription(Object error) {
    return 'Erreur lors de l\'ajout de l\'abonnement : $error';
  }

  @override
  String get serviceName => 'Nom du service';

  @override
  String get serviceNameHint => 'ex: Netflix, Spotify';

  @override
  String get required => 'Requis';

  @override
  String get invalid => 'Invalide';

  @override
  String get billingCycle => 'Cycle de facturation';

  @override
  String get nextRenewalDate => 'Prochaine date de renouvellement';

  @override
  String get notesOptional => 'Notes (facultatif)';

  @override
  String get tryAgain => 'Réessayer';
}
