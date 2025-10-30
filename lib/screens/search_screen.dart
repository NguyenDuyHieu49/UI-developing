import 'package:flutter/material.dart';
import '../l10n/translations.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _results = [];

  void _performSearch(String query) {
    setState(() {
      _results = query.isEmpty
          ? []
          : List.generate(5, (index) => "Result ${index + 1} for '$query'");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(t('search')), backgroundColor: Colors.blue),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  onChanged: _performSearch,
                  decoration: InputDecoration(
                    hintText: t('search_hint'),
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: _results.isEmpty
                      ? Center(child: Text(t('no_results')))
                      : ListView.builder(
                          itemCount: _results.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: const Icon(Icons.article),
                              title: Text(_results[index]),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
