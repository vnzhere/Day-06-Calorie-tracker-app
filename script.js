let meals = [];
let total = 0;

function showHome() {
  switchScreen("home");
}

function showAdd() {
  switchScreen("add");
}

function showHistory() {
  switchScreen("history");
}

function switchScreen(id) {
  document.querySelectorAll(".screen").forEach(screen => {
    screen.classList.remove("active");
  });
  document.getElementById(id).classList.add("active");
}

function addMeal(event) {
  event.preventDefault();

  const name = document.getElementById("mealName").value;
  const calories = parseInt(document.getElementById("calories").value);

  meals.push({ name, calories });
  total += calories;

  document.getElementById("totalCalories").innerText = total + " kcal";

  const li = document.createElement("li");
  li.innerText = name + " - " + calories + " kcal";
  document.getElementById("mealList").appendChild(li);

  document.querySelector("form").reset();
  showHome();
}