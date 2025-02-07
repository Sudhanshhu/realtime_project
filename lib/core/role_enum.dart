enum RoleEnum {
  productDesigner(0, 'Product Designer'),
  flutterDeveloper(1, 'Flutter Developer'),
  qaTester(2, 'QA Tester'),
  productOwner(3, 'Product Owner');

  final int code;
  final String title;

  const RoleEnum(this.code, this.title);

  static RoleEnum fromCode(int code) {
    return RoleEnum.values.firstWhere(
      (role) => role.code == code,
      orElse: () => throw ArgumentError('Invalid code: $code'),
    );
  }
}
