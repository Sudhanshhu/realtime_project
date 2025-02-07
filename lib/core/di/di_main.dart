part of 'di.dart';

GetIt di = GetIt.instance;

Future<void> initDi() async {
  final prefs = await SharedPreferences.getInstance();
  di.registerFactory<EmployeeLocalDs>(
      () => EmployeeLocalDsImpl(sharedPreferences: di()));
  di.registerFactory<EmployeeRepo>(() => EmpRepoImpl(
        employeeLocalDs: di(),
      ));
  di.registerFactory<EmpCubit>(() => EmpCubit(di()));
  di.registerFactory<SharedPreferences>(() => prefs);
}
