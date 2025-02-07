// ignore_for_file: public_member_api_docs, sort_constructors_first

class CustomArgs {
  dynamic args;
  dynamic args2;
  CustomArgs({
    this.args,
    this.args2,
  });

  factory CustomArgs.defaultSetting(dynamic args) {
    return CustomArgs(args: args);
  }
}
