import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

import '../../data/models/deal_model.dart';

class DealListItem extends StatelessWidget {
  final DealData deal;
  const DealListItem({super.key, required this.deal});

  @override
  Widget build(BuildContext context) {
    // Format Date from "2018-12-04" -> "4 Dec 2018"
    final date = DateTime.tryParse(deal.createdAt ?? "");
    final formattedDate =
        date != null ? DateFormat("d MMM yyyy").format(date) : "";

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: Colors.grey,
          width: 1.0,
        ), // Add border here
        borderRadius: BorderRadius.circular(
          4.0,
        ), // Optional: Match your desired radius
      ),
      margin: const EdgeInsets.all(4),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 80,
                  height: 80,
                  child: CachedNetworkImage(
                    imageUrl: deal.imageMedium ?? "",
                    placeholder: (_, __) => Container(color: Colors.grey[200]),
                    errorWidget: (_, __, ___) => const Icon(Icons.error),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    deal.title ?? "New Deal",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.thumb_up_sharp,
                      size: 16,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 5),
                    Text("${deal.commentsCount ?? 0}"),
                    const SizedBox(width: 10),
                    const Icon(
                      Icons.chat_bubble_outline,
                      size: 16,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 5),
                    Text("${deal.commentsCount ?? 0}"),
                    const SizedBox(width: 10),
                    const Icon(Icons.access_time, size: 16, color: Colors.grey),
                    const SizedBox(width: 5),
                    Text(formattedDate),
                  ],
                ),
                Text(
                  "At ${deal.storeName ?? 'Other'}",
                  style: const TextStyle(color: Colors.blue),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
