class Note {
  String title;
  String desc;
  String time;

  Note({required this.title, required this.desc, required this.time});

  Note.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        desc = json['desc'],
        time = json['time'];

  Map<String, dynamic> toJson() {
    return {'title': title, 'desc': desc, 'time': time};
  }
}
