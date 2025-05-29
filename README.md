#Trivia Quiz App

A dynamic trivia quiz app built using Flutter and GetX that fetches real-time trivia questions from the API Ninjas Trivia API. Users can choose trivia categories such as Music, Geography, Food & Drink, Science & Nature, and Entertainment to test their knowledge.

Features

Fetches trivia questions from API in real-time

Category-based question filtering

Randomized answer options

Displays correct answers

Clean and responsive UI

State management using GetX

A new Flutter project.

Getting Started

Prerequisites

Flutter SDK

An API key from API Ninjas

Installation:
Install dependencies:

flutter pub get

Add your API keys:

Create a file at lib/constants/keys.dart:

const String APIKEY = 'YOUR_TRIVIA_API_KEY';
const String RANDOMKEY = 'YOUR_RANDOM_WORD_API_KEY';

Add this file to .gitignore.

##Run the app:

flutter run

To-Do

Add score tracking and leaderboard

Add timer-based questions

Integrate Firebase for user data and analytics

Add animations and sound effects

Author

Developed by Pradeep Singh
