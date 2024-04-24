# eUnity-app

## Overview

Welcome to eUnity, where connections thrive! eUnity is a dating app designed to help you find meaningful relationships with like-minded individuals. This README serves as your guide to understanding the app's features and functionalities.

## Backend set up

First install node.js from:

  ```
  https://nodejs.org/en
  ```

Once full repo is in local repository run the follwoing command to install all packages
  ```
  npm install
  ```
This will install dotenv, express, mongoose, and nodemon

After, create an empty file called ".env"
Then add this to the file:
  ```
  DATABASE_URL=mongodb://localhost/userInfo
  ```
This URL is just a place holder for now until the database is created

To run the server enter the following in the terminal
  ```
  npm run devStart
  ```
Ensure you are in the backend folder before running these commands

## Features

### Home Screen

- **Header Navigation**: Access key sections like Home, Messages, and Profile with ease.
- **Featured Profiles**: Discover potential matches showcased on the home screen.
- **Search Bar**: Find new connections quickly using the search functionality.

### Profile Screen

- **User Profile**: View user's basic information including name, age, and location.
- **Bio Section**: Share more about yourself in the bio section.
- **Gallery**: Showcase additional photos to attract potential matches.
- **Edit Profile**: Easily edit your profile and preferences.

### Matching Screen

- **Potential Matches**: See potential matches tailored to your preferences.
- **Swipe Functionality**: Swipe left to pass or right to like potential matches.
- **Information Cards**: Get basic details of each match at a glance.

### Messaging Screen

- **Conversations**: Access your conversations with matches.
- **Chat Interface**: Communicate seamlessly with message history.
- **Send Messages**: Use the input field to send new messages to your matches.

### Settings Screen

- **Customization**: Personalize app preferences to suit your needs.
- **Account Management**: Manage your account settings and preferences.
- **Help and Support**: Access help resources and FAQs.

### Notification Screen

- **Recent Notifications**: Stay updated with recent activity and notifications.
- **Customize Notifications**: Tailor notification preferences to your liking.

### Feedback Screen

- **Submit Feedback**: Provide feedback or report issues using the feedback form.

### Onboarding Screens

- **Welcome Screen**: Get introduced to the app's key features.
- **Walkthrough**: Learn how to navigate and use the app effectively.
- **Call-to-Action**: Start your journey by creating an account or logging in.

### Upgrade Screen

- **Premium Features**: Explore the benefits of premium membership.
- **Subscription**: Easily subscribe to premium features with a single click.

### Success Screen

- **Confirmation**: Receive positive confirmation messages for completed actions.


