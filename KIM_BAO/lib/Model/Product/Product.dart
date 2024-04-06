


// List<Product> ProductFromJson(String str) => List<Product>.from(json.decode(str).map((x)=>Product.fromJson(x)));

// String ProductToJson(List<Product> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));



import 'dart:typed_data';

class Product {
   int? id;
   String Ten;
   String MoTa;
   int Gia;
   Uint8List Img;


   Product({
     this.id,
     required this.Ten,
     required this.Gia,
     required this.Img,
     required this.MoTa,
  });

  
  Product.fromMap(Map<String, dynamic>res):
      id = res['id'],
        Ten = res['Ten'] ?? "",
        Gia = res['Gia']??0,
        Img=res['Img']?? "",
        MoTa = res['MoTa']??"";


  Map<String, Object?> toMap(){
    return {
      "id" : id,
      "Ten" : Ten,
      "Gia" : Gia,
      "Img" : Img,
      "MoTa": MoTa,

    };
  }

   factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        Ten: json["Ten"],
        Gia: json["Gia"],
        Img: json["Img"],
       MoTa: json["MoTa"]

    );
   @override
  String toString() {
    return 'Product(Ten: $Ten, id: $id, Gia: $Gia, img: $Img, MoTa: $MoTa)';
  }
}

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.