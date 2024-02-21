Map<String, dynamic> _parseRecord(Object? record) {
  return (record as Map<Object?, Object?>)
      .map((key, value) => MapEntry(key.toString(), value));
}

class CloudKitRecord {
  final String recordType;
  final String recordName;
  final DateTime? creationDate;
  final DateTime? modificationDate;
  final Map<String, dynamic> values;

  CloudKitRecord(
      {required this.recordType,
      required this.recordName,
      this.creationDate,
      this.modificationDate,
      required this.values});

  factory CloudKitRecord.fromMap(Map<Object?, Object?> map) {
    try {
      return CloudKitRecord(
          recordType: map['recordType'] as String,
          recordName: map['recordName'] as String,
          creationDate: map['creationDate'] != null
              ? DateTime.fromMillisecondsSinceEpoch(
                  ((map['creationDate'] as num) * 1000).toInt())
              : null,
          modificationDate: map['modificationDate'] != null
              ? DateTime.fromMillisecondsSinceEpoch(
                  ((map['modificationDate'] as num) * 1000).toInt())
              : null,
          values: _parseRecord(map['record']));
    } catch (e) {
      throw Exception('Cannot parse cloud kit response: $e');
    }
  }
}
