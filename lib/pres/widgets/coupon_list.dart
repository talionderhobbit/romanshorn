import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:romanshorn/logic/entries_cubit.dart';

import '../../data/models/entry_model.dart';
import '../dialogs.dart';
import 'like_btn.dart';

class CouponList extends StatefulWidget {
  const CouponList({Key? key}) : super(key: key);

  @override
  State<CouponList> createState() => _CouponListState();
}

class _CouponListState extends State<CouponList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EntriesCubit, EntriesState>(
      builder: (context, state) {
        List<EntryModel> coupons = state.entries
            .where((element) => element.category == 'Coupon')
            .toList();

        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: coupons.length,
          itemBuilder: (context, index) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              child: GestureDetector(
                onTap: () => Dialogs.buildHighlightSheet(
                    context: context, entry: coupons[index]),
                child: Card(
                  margin: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      // Image
                      Stack(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Image.network(
                              coupons[index].imgPath,
                              fit: BoxFit.fill,
                            ),
                          ),
                          LikeBtn(entry: coupons[index]),
                        ],
                      ),
                      const SizedBox(width: 12.0),
                      // Text
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Category

                            // Title
                            Text(coupons[index].title,
                                style: Theme.of(context).textTheme.titleLarge),
                            SizedBox(height: 8),
                            Text(coupons[index].description,
                                style: Theme.of(context).textTheme.titleMedium),

                            Expanded(child: Container()),

                            Text(coupons[index].short,
                                style: const TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
