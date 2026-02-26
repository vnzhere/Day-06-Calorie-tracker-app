let meals = JSON.parse(localStorage.getItem("meals")) || [];
let total = parseInt(localStorage.getItem("total")) || 0;
let goal = parseInt(localStorage.getItem("goal")) || 0;

// Initialize on load
window.onload = function () {
  updateUI();
};

function switchScreen(id) {
  document.querySelectorAll(".screen").forEach(screen => {
    screen.classList.remove("active");
  });
  document.getElementById(id).classList.add("active");
}

function showHome() { switchScreen("home"); }
function showAdd() { switchScreen("add"); }
function showHistory() { switchScreen("history"); }
function showProfile() { switchScreen("profile"); }

function addMeal(event) {
  event.preventDefault();

  const name = document.getElementById("mealName").value;
  const calories = parseInt(document.getElementById("calories").value);

  meals.push({ name, calories });
  total += calories;

  localStorage.setItem("meals", JSON.stringify(meals));
  localStorage.setItem("total", total);

  updateUI();

  document.querySelector("#add form").reset();
  showHome();
}

function saveProfile(event) {
  event.preventDefault();

  const height = parseFloat(document.getElementById("height").value);
  const weight = parseFloat(document.getElementById("weight").value);

  const bmi = (weight / ((height/100) * (height/100))).toFixed(2);

  localStorage.setItem("height", height);
  localStorage.setItem("weight", weight);
  localStorage.setItem("bmi", bmi);

  updateUI();
  showHome();
}

function setGoal() {
  goal = parseInt(document.getElementById("calorieGoal").value);
  localStorage.setItem("goal", goal);
  updateUI();
}

function updateUI() {
  // Update Calories
  document.getElementById("totalCalories").innerText = total + " kcal";

  // Update Meal List
  const mealList = document.getElementById("mealList");
  mealList.innerHTML = "";
  meals.forEach(meal => {
    const li = document.createElement("li");
    li.innerText = meal.name + " - " + meal.calories + " kcal";
    mealList.appendChild(li);
  });

  // Update Profile
  document.getElementById("displayHeight").innerText = localStorage.getItem("height") || "--";
  document.getElementById("displayWeight").innerText = localStorage.getItem("weight") || "--";
  document.getElementById("displayBMI").innerText = localStorage.getItem("bmi") || "--";

  // Update Goal Progress
  if (goal > 0) {
    let percentage = Math.min((total / goal) * 100, 100);
    document.getElementById("progressBar").style.width = percentage + "%";
    document.getElementById("goalStatus").innerText =
      "Goal Progress: " + percentage.toFixed(1) + "%";
  }
}

function resetApp() {
  localStorage.clear();
  meals = [];
  total = 0;
  goal = 0;
  updateUI();
  alert("All data has been reset.");
}