import 'package:isar/isar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pennypilot/src/presentation/providers/data_providers.dart';
import 'package:pennypilot/src/presentation/providers/database_provider.dart';
import 'package:pennypilot/src/data/models/category_model.dart';
import 'package:pennypilot/src/presentation/widgets/empty_state.dart';

// Categories provider
final categoriesProvider = StreamProvider<List<CategoryModel>>((ref) async* {
  final isar = ref.watch(isarProvider);

  yield* isar.categoryModels
      .filter()
      .isActiveEqualTo(true)
      .watch(fireImmediately: true);
});

// Merchant category mappings provider
final merchantMappingsProvider =
    StreamProvider<List<MerchantCategoryMappingModel>>((ref) async* {
  final isar = ref.watch(isarProvider);

  yield* isar.merchantCategoryMappingModels
      .where()
      .sortByCreatedAtDesc()
      .watch(fireImmediately: true);
});

class CategoryManagementScreen extends ConsumerStatefulWidget {
  const CategoryManagementScreen({super.key});

  @override
  ConsumerState<CategoryManagementScreen> createState() =>
      _CategoryManagementScreenState();
}

class _CategoryManagementScreenState
    extends ConsumerState<CategoryManagementScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Category Management'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Categories', icon: Icon(Icons.category)),
            Tab(text: 'Merchant Mapping', icon: Icon(Icons.link)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          _CategoriesTab(),
          _MerchantMappingTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (_tabController.index == 0) {
            _showAddCategoryDialog(context);
          } else {
            _showAddMappingDialog(context);
          }
        },
        icon: const Icon(Icons.add),
        label: Text(_tabController.index == 0 ? 'Add Category' : 'Add Mapping'),
      ),
    );
  }

  void _showAddCategoryDialog(BuildContext context) {
    final nameController = TextEditingController();
    String selectedIcon = '📁';
    String selectedColor = '#6750A4';

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Add Category'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Category Name',
                    hintText: 'e.g., Groceries',
                  ),
                  textCapitalization: TextCapitalization.words,
                ),
                const SizedBox(height: 16),

                // Icon Picker
                const Text('Select Icon'),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: ['📁', '🛒', '🍔', '⛽', '🎬', '💊', '✈️', '🏋️']
                      .map((icon) => ChoiceChip(
                            label: Text(icon,
                                style: const TextStyle(fontSize: 24)),
                            selected: selectedIcon == icon,
                            onSelected: (selected) {
                              setState(() {
                                selectedIcon = icon;
                              });
                            },
                          ))
                      .toList(),
                ),

                const SizedBox(height: 16),

                // Color Picker
                const Text('Select Color'),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: [
                    '#6750A4', // Purple
                    '#006C4C', // Teal
                    '#0277BD', // Blue
                    '#F57C00', // Orange
                    '#C2185B', // Pink
                    '#7B1FA2', // Deep Purple
                  ]
                      .map((color) => GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedColor = color;
                              });
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Color(
                                    int.parse(color.substring(1), radix: 16) +
                                        0xFF000000),
                                shape: BoxShape.circle,
                                border: selectedColor == color
                                    ? Border.all(color: Colors.white, width: 3)
                                    : null,
                              ),
                              child: selectedColor == color
                                  ? const Icon(Icons.check, color: Colors.white)
                                  : null,
                            ),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () async {
                if (nameController.text.isEmpty) return;

                final isar = ref.read(isarProvider);
                final maxOrder = await isar.categoryModels
                    .where()
                    .sortByOrderDesc()
                    .limit(1)
                    .findFirst();

                final category = CategoryModel()
                  ..name = nameController.text
                  ..icon = selectedIcon
                  ..color = selectedColor
                  ..isSystem = false
                  ..order = (maxOrder?.order ?? 0) + 1
                  ..isActive = true
                  ..transactionCount = 0
                  ..createdAt = DateTime.now();

                await isar.writeTxn(() async {
                  await isar.categoryModels.put(category);
                });

                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content:
                            Text('Category "${nameController.text}" created')),
                  );
                }
              },
              child: const Text('Create'),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddMappingDialog(BuildContext context) {
    final merchantController = TextEditingController();
    int? selectedCategoryId;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          final categoriesAsync = ref.watch(categoriesProvider);

          return AlertDialog(
            title: const Text('Add Merchant Mapping'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: merchantController,
                  decoration: const InputDecoration(
                    labelText: 'Merchant Name',
                    hintText: 'e.g., Amazon',
                  ),
                  textCapitalization: TextCapitalization.words,
                ),
                const SizedBox(height: 16),
                categoriesAsync.when(
                  data: (categories) => DropdownButtonFormField<int>(
                    decoration: const InputDecoration(
                      labelText: 'Category',
                    ),
                    initialValue: selectedCategoryId,
                    items: categories.map((cat) {
                      return DropdownMenuItem(
                        value: cat.id,
                        child: Row(
                          children: [
                            Text(cat.icon,
                                style: const TextStyle(fontSize: 20)),
                            const SizedBox(width: 8),
                            Text(cat.name),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCategoryId = value;
                      });
                    },
                  ),
                  loading: () => const CircularProgressIndicator(),
                  error: (_, __) => const Text('Error loading categories'),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              FilledButton(
                onPressed: () async {
                  if (merchantController.text.isEmpty ||
                      selectedCategoryId == null) {
                    return;
                  }

                  final isar = ref.read(isarProvider);

                  final mapping = MerchantCategoryMappingModel()
                    ..merchantName = merchantController.text
                    ..categoryId = selectedCategoryId!
                    ..isAutomatic = false
                    ..userConfirmed = true
                    ..createdAt = DateTime.now();

                  await isar.writeTxn(() async {
                    await isar.merchantCategoryMappingModels.put(mapping);
                  });

                  if (context.mounted) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Mapping created')),
                    );
                  }
                },
                child: const Text('Create'),
              ),
            ],
          );
        },
      ),
    );
  }
}

// Categories Tab
class _CategoriesTab extends ConsumerWidget {
  const _CategoriesTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(categoriesProvider);

    return categoriesAsync.when(
      data: (categories) {
        if (categories.isEmpty) {
          return EmptyState(
            icon: Icons.category,
            title: 'No Categories Yet',
            message: 'Create custom categories to organize your transactions',
            action: FilledButton.icon(
              onPressed: () {
                // Trigger add category from parent
              },
              icon: const Icon(Icons.add),
              label: const Text('Add Category'),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return _CategoryCard(category: category);
          },
        );
      },
      loading: () => const LoadingState(message: 'Loading categories...'),
      error: (error, stack) => ErrorState(
        title: 'Failed to Load',
        message: error.toString(),
        onRetry: () => ref.refresh(categoriesProvider),
      ),
    );
  }
}

// Category Card Widget
class _CategoryCard extends ConsumerWidget {
  final CategoryModel category;

  const _CategoryCard({required this.category});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final color =
        Color(int.parse(category.color.substring(1), radix: 16) + 0xFF000000);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: color.withAlpha(51),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              category.icon,
              style: const TextStyle(fontSize: 24),
            ),
          ),
        ),
        title: Text(category.name),
        subtitle: Text(
          '${category.transactionCount} transactions',
          style: theme.textTheme.bodySmall,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (category.isSystem)
              Chip(
                label: const Text('System'),
                labelStyle: theme.textTheme.labelSmall,
                padding: EdgeInsets.zero,
              ),
            const SizedBox(width: 8),
            PopupMenuButton(
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      Icon(Icons.edit),
                      SizedBox(width: 8),
                      Text('Edit'),
                    ],
                  ),
                ),
                if (!category.isSystem)
                  const PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete, color: Colors.red),
                        SizedBox(width: 8),
                        Text('Delete', style: TextStyle(color: Colors.red)),
                      ],
                    ),
                  ),
              ],
              onSelected: (value) async {
                if (value == 'delete') {
                  final isar = ref.read(isarProvider);
                  await isar.writeTxn(() async {
                    await isar.categoryModels.delete(category.id);
                  });

                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Category deleted')),
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Merchant Mapping Tab
class _MerchantMappingTab extends ConsumerWidget {
  const _MerchantMappingTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mappingsAsync = ref.watch(merchantMappingsProvider);

    return mappingsAsync.when(
      data: (mappings) {
        if (mappings.isEmpty) {
          return EmptyState(
            icon: Icons.link,
            title: 'No Merchant Mappings',
            message: 'Map merchants to categories for automatic organization',
            action: FilledButton.icon(
              onPressed: () {
                // Trigger add mapping from parent
              },
              icon: const Icon(Icons.add),
              label: const Text('Add Mapping'),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: mappings.length,
          itemBuilder: (context, index) {
            final mapping = mappings[index];
            return _MerchantMappingCard(mapping: mapping);
          },
        );
      },
      loading: () => const LoadingState(message: 'Loading mappings...'),
      error: (error, stack) => ErrorState(
        title: 'Failed to Load',
        message: error.toString(),
        onRetry: () => ref.refresh(merchantMappingsProvider),
      ),
    );
  }
}

// Merchant Mapping Card Widget
class _MerchantMappingCard extends ConsumerWidget {
  final MerchantCategoryMappingModel mapping;

  const _MerchantMappingCard({required this.mapping});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const Icon(Icons.store),
        title: Text(mapping.merchantName),
        subtitle: Text(
          mapping.isAutomatic ? 'Automatic mapping' : 'Manual mapping',
          style: theme.textTheme.bodySmall,
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () async {
            final isar = ref.read(isarProvider);
            await isar.writeTxn(() async {
              await isar.merchantCategoryMappingModels.delete(mapping.id);
            });

            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Mapping deleted')),
              );
            }
          },
        ),
      ),
    );
  }
}
