## Title: Nearcut-backend-challenge 💈

This is a single page app for uploading User data. It is available @ https://rails-nearcut-challenge.herokuapp.com
It is also a coding-challenge made for [Nearcut](https://nearcut.com/).

## Specs:

- Rails (rails 6.1.4)
- Ruby (ruby 3.0.0)
- psql (PostgreSQL 1.2.3) - database for heroku
- ActiveRecoprd Import (activerecord-import 1.3.0) - for faster querying in case of bulk CSV upload
- pry (0.13.1) - debugging
- Rspec (5.0.2) - testing

## How to install:

#### Clone the project and create your own repository:

```
git clone git@github.com:karcagigergo/nearcut_challenge.git --origin nearcut_challenge your-project-name
```

#### Create your repository:

```
git init .
git add .
git commit
hub create
```

#### Install all the dependencies:

```
bundle install
yarn install
```

## How to use: 🕹

1. Open the website https://rails-nearcut-challenge.herokuapp.com
2. Select a CSV file and upload it.

- Data can only be uploaded via CSV files as shown below:

```
name,password
Muhammad,QPFJWz1343439
Maria Turing,AAAfk1swods
Isabella,Abc123
Axel,000aaaBBBccccDDD
```

Upon uploading we can expect an error message like so:

```
Muhammad was successfully saved

Change 1 character of Maria Turing's password

Change 4 characters of Isabella's password

Change 5 characters of Axel's password
```

The reason why these messages are shown is because if a row leads to a valid User, then the User is saved and the result for this row is a success. Although if a row leads to an invalid User, the User should not be saved and an error should be shown in the results on the website.
A **valid user** is a user with: a _name_ (any kind is accepted) and a _strong password_: (It has at least 10 characters and at most 16 characters. It contains at least one lowercase character, one uppercase character and one digit. It cannot contain three repeating characters in a row (e.g. "...zzz..." is not strong, but "...zz...z..." is strong, assuming other conditions are met).)
If the password provided is not strong, then the minimum number of character changes required to make it a strong password is displayed on the website. Insertion, deletion or replacement of any one character is considered one change.
