import 'package:flutter/material.dart';

class NoteListItem extends StatefulWidget {
  final int index;
  final String title;
  final void Function() onDelete;
  final ValueChanged<String>? onChanged;

  NoteListItem({
    Key? key,
    required this.index,
    required this.title,
    required this.onDelete,
    required this.onChanged,
  }) : super(key: key);

  @override
  _NoteListItemState createState() => _NoteListItemState();
}

class _NoteListItemState extends State<NoteListItem> {
  TextEditingController topicController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    topicController = TextEditingController(text: widget.title ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, top: 16, bottom: 0, right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 0,
            blurRadius: 5,
            offset: const Offset(0, 3),
          )
        ],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.blue,
          width: 1,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${widget.index + 1}',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: widget.onDelete,
                  child: const Icon(Icons.delete),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(
              height: 0.5,
              color: Colors.black12,
            ),
            const SizedBox(height: 12),
            const Row(
              children: [
                Text(
                  'Writing Topic',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 4),
                Text(
                  '*',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            TextField(
              controller: topicController,
              textAlign: TextAlign.left,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              decoration: const InputDecoration(
                hintText: 'The writing topic has not been filled in',
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                border: InputBorder.none,
                filled: false,
              ),
              maxLines: 1,
              onChanged: widget.onChanged,
            ),
            const Divider(
              height: 0.5,
              color: Colors.black12,
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
