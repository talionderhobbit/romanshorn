import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:romanshorn/logic/entries_cubit.dart';

import '../../data/models/entry_model.dart';
import '../dialogs.dart';

class FavouritesGrid extends StatefulWidget {
  const FavouritesGrid({Key? key}) : super(key: key);

  @override
  State<FavouritesGrid> createState() => _FavouritesGridState();
}

class _FavouritesGridState extends State<FavouritesGrid> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EntriesCubit, EntriesState>(
      builder: (context, state) {
        List<EntryModel> favs =
            state.entries.where((element) => element.liked).toList();

        return GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 8,
          crossAxisCount: 2,
          shrinkWrap: true,
          children: List.generate(
            favs.length,
            (index) {
              return GestureDetector(
                onTap: () => Dialogs.buildHighlightSheet(
                    context: context, entry: favs[index]),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    AspectRatio(
                      aspectRatio: 3 / 2,
                      child: Image.network(
                        favs[index].imgPath,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: SizedBox(
                            width: double.maxFinite,
                            child: Text(favs[index].title,
                                textAlign: TextAlign.center),
                          ),
                        )),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        margin: const EdgeInsets.all(4),
                        padding: const EdgeInsets.all(0),
                        decoration: const BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                        child: IconButton(
                            onPressed: () {
                              BlocProvider.of<EntriesCubit>(context)
                                  .toggleLikes(favs[index].id);
                            },
                            icon: favs[index].liked
                                ? const Icon(Icons.favorite, color: Colors.red)
                                : const Icon(Icons.favorite_border)),
                      ),
                    ),
                    if (favs[index].id == "5")
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text("Wetter Warnung"),
                                content: const Text(
                                    "Für Morgen ist schlechtes Wetter vorhergesagt. \nWir schlagen dir alternativ einen Besuch im \"Kino Roxy\" vor."),
                                actions: [
                                  TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text("OK"))
                                ],
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.warning_rounded,
                            color: Colors.red,
                            size: 35,
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
    ;
  }
}
