let meals = [];
let total = 0;

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

  document.getElementById("totalCalories").innerText = total + " kcal";

  const li = document.createElement("li");
  li.innerText = name + " - " + calories + " kcal";
  document.getElementById("mealList").appendChild(li);

  document.querySelector("#add form").reset();
  showHome();
}

function saveProfile(event) {
  event.preventDefault();

  const height = parseFloat(document.getElementById("height").value);
  const weight = parseFloat(document.getElementById("weight").value);

  const bmi = (weight / ((height/100) * (height/100))).toFixed(2);

  document.getElementById("displayHeight").innerText = height;
  document.getElementById("displayWeight").innerText = weight;
  document.getElementById("displayBMI").innerText = bmi;

  showHome();
}