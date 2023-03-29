class Student {
  int? id;
  String name;
  Student({
     this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result['id'] = id;
    result['name'] = name;

    return result;
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
    );
  }
}
