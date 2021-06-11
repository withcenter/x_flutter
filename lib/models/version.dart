class Version {
  final String version;

  const Version(this.version);

  @override
  String toString() => 'Version(version: $version)';

  factory Version.fromJson(Map<String, dynamic> json) {
    return Version(json['version'] as String);
  }

  Map<String, dynamic> toJson() {
    return {
      'version': version,
    };
  }
}
