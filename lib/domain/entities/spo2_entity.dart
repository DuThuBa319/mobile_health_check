
import '../../data/models/spo2_model/spo2_model.dart';

class Spo2Entity {
  int? spo2;
  String? imageLink;
  DateTime? updatedDate;

  Spo2Entity({this.imageLink, this.updatedDate, this.spo2});
  Spo2Entity copywith({
    int? spo2,
    String? imageLink,
    DateTime? updatedDate,
  }) {
    return Spo2Entity(
        spo2: spo2 ?? this.spo2,
        imageLink: imageLink ?? this.imageLink,
        updatedDate: updatedDate ?? this.updatedDate);
  }

  Spo2Model getSpo2Model() {
    return Spo2Model(
        imageLinkSpo2: imageLink, spo2: spo2, updatedDate: updatedDate);
  }
}
