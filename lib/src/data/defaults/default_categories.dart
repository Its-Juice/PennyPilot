class DefaultCategoryData {
  final String name;
  final String icon;
  final String color;
  final List<String> keywords;

  DefaultCategoryData({
    required this.name,
    required this.icon,
    required this.color,
    required this.keywords,
  });
}

class DefaultCategories {
  static final List<DefaultCategoryData> categories = [
    DefaultCategoryData(
      name: 'Entertainment & Subscriptions',
      icon: 'subscriptions',
      color: '#E91E63',
      keywords: ['Netflix', 'Spotify', 'Disney+', 'Hulu', 'YouTube', 'Prime Video', 'Apple Music', 'PlayStation', 'Xbox', 'Steam', 'Nintendo'],
    ),
    DefaultCategoryData(
      name: 'Food & Dining',
      icon: 'restaurant',
      color: '#FF9800',
      keywords: ['Uber Eats', 'DoorDash', 'Grubhub', 'McDonald', 'Starbucks', 'Restaurant', 'Pizza', 'Burger', 'Cafe', 'Bakery'],
    ),
    DefaultCategoryData(
      name: 'Groceries',
      icon: 'shopping_cart',
      color: '#4CAF50',
      keywords: ['Walmart', 'Target', 'Costco', 'Whole Foods', 'Trader Joe', 'Supermarket', 'Grocery', 'Aldi', 'Safeway', 'Kroger'],
    ),
    DefaultCategoryData(
      name: 'Transportation',
      icon: 'directions_car',
      color: '#2196F3',
      keywords: ['Uber', 'Lyft', 'Bolt', 'Gas', 'Shell', 'Chevron', 'Exxon', 'Parking', 'Train', 'Bus', 'Airlines', 'Delta', 'United', 'Southwest'],
    ),
    DefaultCategoryData(
      name: 'Shopping',
      icon: 'shopping_bag',
      color: '#9C27B0',
      keywords: ['Amazon', 'eBay', 'Best Buy', 'Apple Store', 'Nike', 'Adidas', 'Clothing', 'Electronics', 'Mall'],
    ),
    DefaultCategoryData(
      name: 'Utilities & Bills',
      icon: 'receipt',
      color: '#607D8B',
      keywords: ['Electric', 'Water', 'Gas Utility', 'Internet', 'Xfinity', 'Verizon', 'AT&T', 'T-Mobile', 'Phone', 'Insurance'],
    ),
    DefaultCategoryData(
      name: 'Professional Services',
      icon: 'work',
      color: '#795548',
      keywords: ['Adobe', 'Microsoft', 'Google Cloud', 'AWS', 'DigitalOcean', 'GitHub', 'LinkedIn', 'Dropbox', 'Zoom', 'Slack'],
    ),
    DefaultCategoryData(
      name: 'Health & Personal Care',
      icon: 'health_and_safety',
      color: '#F44336',
      keywords: ['CVS', 'Walgreens', 'Pharmacy', 'Gym', 'Fitness', 'Hospital', 'Doctor', 'Dentist'],
    ),
  ];
}
