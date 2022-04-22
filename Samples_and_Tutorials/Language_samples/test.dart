//=> 6 imports
// access APIs defined in other libraties
// import core libraties
import 'dart:io';
import 'dart:math';

// from external packages
// import 'package:test/test.dart';

// files
// import 'path/to/my_other_file.dart';

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

//=> 3 control flow statements
void controlFlowStatements() {
  if (year >= 2001) {
    print('21st century');
  } else if (year >= 1901) {
    print('20th century');
  }

  var array = [1, 2];
  for (final object in array) {
    print(object);
  }

  for (int month = 1; month <= 12; month++) {
    print(month);
  }

  while (year < 2016) {
    year += 1;
  }
}

//=> 4 functions
void functions() {
  /// recommend specifying the types of each function's
  /// arguments and return value
  int fibonacci(int n) {
    if (n == 0 || n == 1) return n;
    return fibonacci(n - 1) + fibonacci(n - 2);
  }

  var result = fibonacci(20);
  if (result == 5) {
    print('Not Error for result');
  }

  var array = [
    ['1', '2']
  ];

  /// arrow syntax ex
  array.where((varName) => varName.contains('value'));
}

//=> 5 comments
// normal one-line comment

/// documentation comment - used to libraries
/// class, and their members. tools liek IDEs and
/// dartdoc treatdoc, comments specially

//=> 7 classes
class Spacecraft {
  String name;
  DateTime? launchDate;

  // read-only non-final property
  int? get launchYear => launchDate?.year;

  // constructor
  Spacecraft(this.name, this.launchDate) {
    // initialization code
  }

  // named constructor - forwards
  Spacecraft.unlaunched(String name) : this(name, null);

  // method
  void describe() {
    print('Spacecraft: $name');
    // type promotion not work on getters

    var launchDate = this.launchDate;
    if (launchDate != null) {
      int years = DateTime.now().difference(launchDate).inDays ~/ 365;
      print('Launched: $launchYear ($years years ago)');
    } else {
      print('Unlaunched');
    }
  }
}

// use classes ex
var caoMinh = Spacecraft('Cao Minh 1', DateTime(1977, 9, 5)).describe();

//=> 8 inheritance
class Orbiter extends Spacecraft {
  double altitude;

  Orbiter(String name, DateTime launchDate, this.altitude)
      : super(name, launchDate);
}

//=> 9 mixins
mixin Piloted {
  int astronauts = 1;

  void describeCrew() {
    print('Number of astronauts: $astronauts');
  }
}

// add a mixin's to a class with extend
class PilotedCraft extends Spacecraft with Piloted {
  PilotedCraft.unlaunched(String name) : super.unlaunched(name);
  // ...
}

//=> 10 interfaces and abstract classes
// not have interface keyword, but you can implement with class instead
class MockSpaceship implements Spacecraft {
  @override
  DateTime? launchDate;

  @override
  late String name;

  @override
  void describe() {
    // TODO: implement describe
  }

  @override
  // TODO: implement launchYear
  int? get launchYear => throw UnimplementedError();
  // ...
}

// can create an abstract class to be extended by a concrete class
// abstract class can contain abstract methods (with empty bodies)
abstract class Describable {
  void describe();

  void describeWithEmphasis() {
    print('=========');
    describe();
    print('=========');
  }
}

//=> 11 async
const oneSecond = Duration(seconds: 1);
// ...
Future<void> printWithDelay(String message) async {
  await Future.delayed(oneSecond);
  print(message);
}

// the method above is quivalent to
Future<void> printWithDelayThen(String message) {
  return Future.delayed(oneSecond).then((_) {
    print(message);
  });
}

// async await make asynchoronous code easy to read
Future<void> createDescriptions(Iterable<String> objects) async {
  for (final object in objects) {
    try {
      var file = File('$object.txt');
      if (await file.exists()) {
        var modified = await file.lastModified();
        print('File for $object already exists. It was modified on $modified');
        continue;
      }
      await file.create();
      await file.writeAsString('State describing $object in this file.');
    } on IOException catch (e) {
      print('Cannot create description for $object: $e');
    }
  }
}

// you can also you async*, nice, readable way to build streams
Stream<String> report(Spacecraft craft, Iterable<String> objects) async* {
  for (final object in objects) {
    await Future.delayed(oneSecond);
    yield '${craft.name} flies by $object';
  }
}

//=> 12 exceptions
Stream<Future<void>> exceptions() async* {
  // to raise an exception use throw
  const astronauts = 0;
  if (astronauts == 0) {
    throw StateError('No astronauts.');
  }

  const flyByObjects = ['a', 'b'];
  // catch exception, use try statement with on or catch (or both)
  try {
    for (final object in flyByObjects) {
      var description = await File('$object.txt').readAsString();
      print(description);
    }
  } on IOException catch (e) {
    print('Could not describe object: $e');
  } finally {}
}
