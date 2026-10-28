// Mixin providing evaluation behaviors for students
mixin Evaluable {
  void submitAssignment() {
    print('Assignment submitted successfully.');
  }

  void takeExam() {
    print('Exam session completed.');
  }
}

// Abstract base class Person
abstract class Person {
  String name;
  int id;

  Person({required this.name, required this.id});

  // Abstract method that subclasses must implement
  String getRole();

  void introduce() {
    print('Hello, my name is $name (ID: $id) and I am a ${getRole()}.');
  }
}

// Course class representing a university course
class Course {
  String code;
  String title;
  int credits;

  Course({required this.code, required this.title, required this.credits});

  @override
  String toString() => '$code: $title ($credits credits)';
}

// Student class extending Person and using the Evaluable mixin
class Student extends Person with Evaluable {
  String program;
  double gpa;
  List<Course> enrolledCourses = [];

  Student({
    required String name,
    required int id,
    required this.program,
    required this.gpa,
  }) : super(name: name, id: id);

  @override
  String getRole() => 'Student';

  // Method to enroll in a course
  void enrollIn(Course course) {
    if (!enrolledCourses.any((c) => c.code == course.code)) {
      enrolledCourses.add(course);
      print('$name successfully enrolled in ${course.title}.');
    } else {
      print('$name is already enrolled in ${course.title}.');
    }
  }

  // Calculate total credits based on enrolled courses
  int getTotalCredits() {
    return enrolledCourses.fold(0, (sum, course) => sum + course.credits);
  }
}

// Lecturer class extending Person
class Lecturer extends Person {
  String department;
  List<Course> taughtCourses = [];

  Lecturer({
    required String name,
    required int id,
    required this.department,
  }) : super(name: name, id: id);

  @override
  String getRole() => 'Lecturer';

  // Method to assign a course to teach
  void assignCourse(Course course) {
    if (!taughtCourses.any((c) => c.code == course.code)) {
      taughtCourses.add(course);
      print('Lecturer $name assigned to teach ${course.title}.');
    } else {
      print('Lecturer $name is already teaching ${course.title}.');
    }
  }
}

void main() {
  print('=== STUDENT MANAGEMENT SYSTEM DEMO ===\n');

  // 1. Creating Courses
  var course1 = Course(code: 'INFT 425', title: 'Mobile Application Development', credits: 3);
  var course2 = Course(code: 'CS 301', title: 'Data Structures and Algorithms', credits: 4);

  // 2. Creating a Student and a Lecturer
  var student = Student(
    name: 'Kelvin Aboagye',
    id: 102345,
    program: 'Computer Science',
    gpa: 3.8,
  );

  var lecturer = Lecturer(
    name: 'Mr. Kobbina Amoah',
    id: 90012,
    department: 'Computing Sciences and Engineering',
  );

  // 3. Testing Introductions and Roles
  student.introduce();
  print('GPA: ${student.gpa}\n');

  lecturer.introduce();
  print('Department: ${lecturer.department}\n');

  // 4. Enrolling Student and Assigning Lecturer Courses
  print('--- Course Actions ---');
  student.enrollIn(course1);
  student.enrollIn(course2);
  print('Total Credits Enrolled: ${student.getTotalCredits()}\n');

  lecturer.assignCourse(course1);

  // 5. Testing Mixin Features
  print('\n--- Evaluation (Mixin) Actions ---');
  stdout_write_simulation(student);
}

// Helper function to test student mixin features cleanly
void stdout_write_simulation(Student student) {
  print('${student.name} actions:');
  student.submitAssignment();
  student.takeExam();
}