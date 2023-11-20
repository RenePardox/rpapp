class Data {
  int? id;
  String title;
  String descrip;

  Data({this.id, required this.title, required this.descrip});

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'descrip': descrip};
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      id: map['id'],
      title: map['title'], 
      descrip: map['descrip'],
    );
  }
}
