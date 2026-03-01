import 'package:flutter/material.dart';

void main() {
  runApp(CalorieTrackerApp());
}

class CalorieTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calorie Tracker',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int totalCalories = 0;
  int goal = 2000;
  List<String> meals = [];

  void addMeal(String mealName, int calories) {
    setState(() {
      totalCalories += calories;
      meals.add("$mealName - $calories cal");
    });
  }

  void resetAll() {
    setState(() {
      totalCalories = 0;
      meals.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    double progress = totalCalories / goal;

    return Scaffold(
      appBar: AppBar(title: Text("Dashboard")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [

            SizedBox(height: 10),

            Text(
              "Hello, Vaniya 👋",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 10),

            Text(
              "Track your daily calories",
              style: TextStyle(color: Colors.grey[600]),
            ),

            SizedBox(height: 30),

            Text(
              "Total Calories: $totalCalories",
              style: TextStyle(fontSize: 20),
            ),

            SizedBox(height: 15),

            LinearProgressIndicator(
              value: progress > 1 ? 1 : progress,
              minHeight: 10,
            ),

            SizedBox(height: 20),

            ElevatedButton(
              child: Text("Profile"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ProfileScreen()),
                );
              },
            ),

            ElevatedButton(
              child: Text("Add Meal"),
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AddMealScreen()),
                );

                if (result != null) {
                  addMeal(result['meal'], result['calories']);
                }
              },
            ),

            ElevatedButton(
              child: Text("History"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => HistoryScreen(meals: meals),
                  ),
                );
              },
            ),

            ElevatedButton(
              child: Text("Reset"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: resetAll,
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  double? bmi;

  void calculateBMI() {
    double height = double.parse(heightController.text) / 100;
    double weight = double.parse(weightController.text);

    setState(() {
      bmi = weight / (height * height);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [

            TextField(
              controller: heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Height (cm)"),
            ),

            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Weight (kg)"),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              child: Text("Calculate BMI"),
              onPressed: calculateBMI,
            ),

            SizedBox(height: 20),

            bmi != null
                ? Text(
                    "Your BMI: ${bmi!.toStringAsFixed(2)}",
                    style: TextStyle(fontSize: 18),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

class AddMealScreen extends StatefulWidget {
  @override
  _AddMealScreenState createState() => _AddMealScreenState();
}

class _AddMealScreenState extends State<AddMealScreen> {
  final mealController = TextEditingController();
  final calorieController = TextEditingController();

  void submitMeal() {
    String meal = mealController.text;
    int calories = int.parse(calorieController.text);

    Navigator.pop(context, {
      'meal': meal,
      'calories': calories,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Meal")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [

            TextField(
              controller: mealController,
              decoration: InputDecoration(labelText: "Meal Name"),
            ),

            TextField(
              controller: calorieController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Calories"),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              child: Text("Add Meal"),
              onPressed: submitMeal,
            ),
          ],
        ),
      ),
    );
  }
}

class HistoryScreen extends StatelessWidget {
  final List<String> meals;

  HistoryScreen({required this.meals});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Meal History")),
      body: meals.isEmpty
          ? Center(child: Text("No meals added yet"))
          : ListView.builder(
              itemCount: meals.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.fastfood),
                  title: Text(meals[index]),
                );
              },
            ),
    );
  }
}