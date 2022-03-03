//=> 1 hello word
void main() {
  print('Hello, World!');
}

//=> 2 variables
var name = 'Cao Minh';
var year = 1997;
var pi = 3.14;
var boys = ['Yugi', 'Kaiba'];
var image = {
  'tags': ['handsome'],
  'url': '//path/to/handsome.svg'
};

// //=> 3 control flow statements
// if (year >= 2001) {
//   print('21st century');

// } else if (year >= 1901) {
//   print('20th century');
// }

// for (final object in array) {
//   print(object);
// }

// for (int month = 1; month <= 12; month++) {
//   print(month);
// }

// while (year < 2016) {
//   year += 1;
// }

// //=> 4 functions
// /// recommend specifying the types of each function's
// /// arguments and return value
// int fibonacci(int n) {
//   if (n == 0 || n == 1) return n;
//   return fibonacci(n - 1) + fibonacci(n - 2);
// }

// var result = fibonacci(20);

// /// arrow syntax ex
// array.where((varName) => varName.contains('value')).foreach(print);

// //=> 5 comments
// // normal one-line comment

// /// documentation comment - used to libraries
// /// class, and their members. tools liek IDEs and
// /// dartdoc treatdoc, comments specially

// //=> 6 imports
// // access APIs defined in other libraties
// // import core libraties
// import 'dart:math';

// // from external packages
// import 'package:test/test.dart';

// // files
// import 'path/to/my_other_file.dart';

// //=> 7 classes
// class Spacecraft {
//   String: name;
//   DateTime ? launchDate;

//   // read-only non-final property
//   int ? get launchYear => launchDate ? .year;

//   // constructor
//   Spacecraft(this.name, this.launchDate) {
//     // initialization code
//   }

//   // named constructor - forwards
//   Spacecraft.unlaunched(String name): this(name, null);

//   // method
//   void describe() {
//     print('Spacecraft: $name');
//     // type promotion not work on getters

//     var launchDate= this.launchDate;
//     if (launchDate != null) {
//       int years =
//         DateTime.now().difference(launchDate).inDays ~/ 365;
//       print('Launched: $launchYear ($years years ago)');

//     } else {
//       print('Unlaunched');
//     }
//   }
// }

// // use classes ex
// var caoMinh = Spacecraft('Cao Minh 1', DateTime(1977, 9 , 5));
