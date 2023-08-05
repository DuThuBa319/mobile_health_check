class BloodPressureEntity {
  int? id;
  int? sys;
  int? dia;
  int? pulse;
  DateTime? updatedDate;
  BloodPressureEntity(
      {this.dia, this.pulse, this.sys, this.updatedDate, this.id});
}
