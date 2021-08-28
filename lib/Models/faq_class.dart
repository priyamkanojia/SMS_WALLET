class FaqClass {
  String id;
  String subject;
  String description;
  String status;

  FaqClass(
      {this.id,
        this.description,
        this.subject,
        this.status});

  FaqClass.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subject=json['subject'];
    description = json['description'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['subject']=this.subject;
    data['description'] = this.description;
    data['status'] = this.status;
    return data;
  }
}