# Realtime-chat-api

## Table of Contents

- [What is the project about](#what-is-the-project-about)
- [Architecture](#architecture)
- [Feature List](#feature-list)
- [Local Development Setup](#local-development-setup)
- [Acknowledgments](#acknowledgments)

## What is the project about

Realtime-chat is a chat application with real time communication powered by websockets.

## Architecture

The backend of the Realtime chat application is built using Ruby on Rails and it integrates with a [React frontend](https://github.com/iIqbalSazim/realtime-chat-client).
<br/>
It follows a RESTful architecture with a Model-View-Controller (MVC) pattern.

## Feature List

- **Login/Registration:**

  - Users can login and register.
  - New user registrations are notified to all other logged in users.

- **Main Functionalities:**

  - Users will be able to see list of other users.
  - Users will be able to chat one on one with other users.

## Local Development Setup

### Prerequisites

- Ruby v3.2.2 and Ruby on Rails installed on your machine
- PostgreSQL installed on your machine

### Step-by-step instructions

1. Clone the repository: `git clone <repository-url>`
2. Navigate to the api directory: `cd realtime-chat-api`
3. Install dependencies: `bundle install`
4. Set up PostgreSQL:
   - Create a new database. Grant all privileges on the database to the user.
5. Configure rails database:
   - Open config/database.yml file.
   - Update the database field under **development** section with your desired database name (e.g., realtime_chat_api_development).
   - Uncomment and update the username and password fields if necessary.
6. Set up the database: `rails db:create && rails db:migrate`
7. Run the development server: `rails server`

## Acknowledgments

- This project was developed as a requirement for month 3 in the Sazim Learner's Program.
- Special thanks to the instructors and mentors for their guidance and support throughout the program.
