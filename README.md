AI-Powered Trivia Quiz App

A dynamic and colorful iOS trivia quiz app that generates questions on any topic using AI.

<img width="381" alt="homescreen" src="https://github.com/user-attachments/assets/2b9c5ce6-f797-4677-89e5-a28fd40dcc6f" />

Features

Custom Topic Selection: Enter any topic and get a personalized quiz

AI-Generated Questions: Each quiz contains 5 unique questions with 4 options each

Educational Experience: Detailed explanations for correct answers

Engaging UI: Vibrant color scheme with intuitive design

Score Tracking: Track your performance and see your final score

Technology Stack

SwiftUI: Modern declarative UI framework for iOS

MVVM Architecture: Clean separation of data and presentation logic

Groq AI API: Integration with Llama 3.3 70B model for dynamic quiz generation

Custom UI Components: Hand-crafted buttons, text fields, and visual effects

How It Works

Enter any topic in the main menu

The app connects to the Groq API to generate questions about your chosen topic

Answer each question by selecting one of four options

See immediate feedback with explanations for each answer

Complete all questions to see your final score

Installation

Clone this repository

Open TriviaYTtuto.xcodeproj in Xcode

Add your Groq API key to Secrets.swift (replace "YOUR-API-KEY-HERE")

Build and run the app on your iOS device or simulator

Requirements

iOS 15.0+

Xcode 14.0+

Groq API key (get one at groq.com)

Setup

To use this app, you'll need to add your Groq API key:

Open Secrets.swift

Replace "YOUR-API-KEY-HERE" with your actual Groq API key

Design

The app features a playful and vibrant design with:

Bold black outlines

Bright color palette including yellows, purples, blues, and pinks

Custom button and text field styles

Dynamic backgrounds that change based on game state

Future Improvements

User accounts and saved quiz history

More advanced quiz customization options

Multiplayer functionality

Additional quiz modes and difficulty levels

Credits

Developed by Max Contreras following  a Youtube tutorial from https://www.youtube.com/@AnyoneCanCode

Uses the Groq API for AI question generation

License

MIT
