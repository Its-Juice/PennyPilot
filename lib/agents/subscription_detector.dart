import '../data/models/transaction_model.dart';
import '../data/models/subscription_model.dart';

abstract class Agent {
  Future<dynamic> detect(List<TransactionModel> txns);
}

class Cluster {
  final double recurrence;
  Cluster({required this.recurrence});
}

class MLModel {
  static List<Cluster> predictClusters(List<TransactionModel> txns) {
    // Placeholder implementation
    return [];
  }
}

class SubscriptionAgent extends Agent {
  @override
  Future<SubscriptionModel?> detect(List<TransactionModel> txns) async {
    final clusters = MLModel.predictClusters(txns);
    final recurringCluster = clusters
        .where((cluster) => cluster.recurrence > 0.9)
        .toList();

    if (recurringCluster.isEmpty) return null;

    // Placeholder: return SubscriptionModel.fromCluster(recurringCluster.first);
    return null; // SubscriptionModel.fromCluster doesn't exist yet
  }
}
