// List<Note> NoteFromJson(String str) => List<Note>.from(json.decode(str).map((x)=>Note.fromJson(x)));

// String NoteToJson(List<Note> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Note {
  int? id;
  String Ten;
  String NoiDung;
  String Ngay;

  Note({
    this.id,
    required this.Ten,
    required this.NoiDung,
    required this.Ngay,
  });

  Note.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        Ten = res['Ten'],
        Ngay = res['Ngay'],
        NoiDung = res['NoiDung'];

  Map<String, Object?> toMap() {
    return {
      "id": id,
      "Ten": Ten,
      "Ngay": Ngay,
      "NoiDung": NoiDung,
    };
  }

  factory Note.fromJson(Map<String, dynamic> json) => Note(
      id: json["id"],
      Ten: json["Ten"],
      Ngay: json["Ngay"],
      NoiDung: json["NoiDung"]);
  @override
  String toString() {
    return 'Note(Ten: $Ten, id: $id, Ngay: $Ngay,  NoiDung: $NoiDung)';
  }
}

// Implement toString to make it easier to see information about
// each dog when using the print statement.
