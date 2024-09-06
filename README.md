# Gambling-Site-Using-Sinatra-Framework (Sinatra Betting Web Application)

## Overview

This is a simple betting web application built using the **Sinatra** web framework. It allows users to sign up, log in, place bets, and track their wins and losses over time. The application maintains user sessions and stores betting data, providing users with a personalized experience each time they log in.

## Features

### User Authentication
- **Sign Up**: New users can create an account.
- **Log In**: Existing users can log in with their username and password stored in the database.
- **Session Management**: User session data is managed and stored in a session hash for the duration of the login.

### Betting Functionality
- **Place Bets**: Logged-in users can place bets through a form.
- **Win/Loss Tracking**: The application displays whether the user has won or lost after each bet.

### Data Tracking
- **Session Statistics**: During each login session, the app displays the user's betting statistics for the current session (stored in the session hash).
- **Lifetime Statistics**: Displays the total betting statistics for the user since they started using the site. These values are stored and updated in the database each time the user logs out.

### Logout
- **Logout**: Upon logging out, the session data is cleared, and the user is redirected to the login page. The session’s betting statistics are added to the user’s lifetime statistics in the database.

## Setup & Installation

1. **Install Dependencies**:
   ```bash
   bundle install
   ```
2. **Run the Application**:
   ```bash
   ruby app.rb
   ```
3. **Access the App**: Open your browser and navigate to `http://localhost:4567`.

## How it Works

- **Session Handling**: User data during a session is stored in a session hash, allowing users to track their bets within a single login session.
- **Database**: A database stores user login information, along with total betting statistics for each user, which are updated at the end of each session.
- **Forms**: The betting form allows users to submit their bets, and results are displayed immediately.

## Screenshots

<img width="516" alt="register" src="https://github.com/user-attachments/assets/de3fb67e-fb46-4e49-a805-062263ac48d7">
<img width="842" alt="homepage" src="https://github.com/user-attachments/assets/8765dd6e-8246-418b-a638-43ea25128b24">
<img width="840" alt="profit" src="https://github.com/user-attachments/assets/2a6cfb58-8c95-4719-896d-db3da3bb509f">
<img width="840" alt="loss" src="https://github.com/user-attachments/assets/6db3bebd-6ecb-4d34-99f5-62cc784f3d56">
<img width="840" alt="net profit" src="https://github.com/user-attachments/assets/fb4ff2bd-6778-47e8-bb04-7014b7a703ba">


## Conclusion

This Sinatra-based application provides a simple yet effective system for online betting with session tracking, user authentication, and lifetime statistics.
