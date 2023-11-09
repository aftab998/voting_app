class electionModel {
  int? electionID;
  String? name;
  String? date;
  String? time;
  String? description;
  String? status;
  String? createdAt;
  String? updatedAt;

  electionModel(
      {this.electionID,
      this.name,
      this.date,
      this.time,
      this.description,
      this.status,
      this.createdAt,
      this.updatedAt});

  electionModel.fromJson(Map<String, dynamic> json) {
    electionID = json['ElectionID'];
    name = json['Name'];
    date = json['Date'];
    time = json['Time'];
    description = json['Description'];
    status = json['Status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ElectionID'] = this.electionID;
    data['Name'] = this.name;
    data['Date'] = this.date;
    data['Time'] = this.time;
    data['Description'] = this.description;
    data['Status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
