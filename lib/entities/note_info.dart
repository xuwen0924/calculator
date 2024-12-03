class NoteInfo {
  String? title;
  List<String>? topics;

  NoteInfo({
    this.title,
    this.topics,
  });

  factory NoteInfo.fromJson(Map<String, dynamic> json) => NoteInfo(
        title: json["title"],
        topics: json["topics"] == null ? [] : List<String>.from(json["topics"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "topics": topics,
      };
}
