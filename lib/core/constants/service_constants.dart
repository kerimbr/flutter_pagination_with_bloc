class ServiceConstants {

  static final ServiceConstants _instance = ServiceConstants._init();
  static ServiceConstants get instance => _instance;
  ServiceConstants._init();

  String get baseUrl => 'https://jsonplaceholder.typicode.com';
  String get todosPath => '/todos';

  String get limitQuery => '_limit';
  String get startQuery => '_start';

  int get limitValue => 25;


}