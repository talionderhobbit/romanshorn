import 'package:flutter/material.dart';

import '../../data/data.dart';
import '../../data/models/entry_model.dart';
import '../widgets/entry_card.dart';
import '../widgets/header.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();

  List<EntryModel> results = [];

  void searchEntries(
    List<EntryModel> entries,
    String searchTerm,
  ) {
    if (searchTerm.isEmpty) {
      return; // Return the original list if the search term is empty
    }
    results = [];

    final List<EntryModel> searchResults = [];

    for (final entry in entries) {
      if (entry.title.toLowerCase().contains(searchTerm.toLowerCase()) ||
              entry.description
                  .toLowerCase()
                  .contains(searchTerm.toLowerCase()) ||
              entry.category.toLowerCase().contains(searchTerm.toLowerCase())
          //|| entry.tagsIds.any((tag) => tag.toLowerCase().contains(searchTerm.toLowerCase()))
          ) {
        searchResults.add(entry);
      }
    }

    results = searchResults;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Column(
          children: [
            const HeaderLogo(),
            SearchBar(
              searchController: searchController,
              searchEntries: searchEntries,
            ),
            if (results.isEmpty)
              const Expanded(
                child: Center(
                  child: Text("No results found"),
                ),
              ),
            Expanded(
              child: ListView.builder(
                itemCount: results.length,
                itemBuilder: (context, index) {
                  return EntryCard(entry: results[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  final TextEditingController searchController;
  final Function(List<EntryModel>, String) searchEntries;

  const SearchBar(
      {Key? key, required this.searchController, required this.searchEntries})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        onChanged: (value) {
          searchEntries(Data.entryList, value);
        },
        controller: searchController,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: "Search",
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }
}
