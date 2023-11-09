# Little Esty Shop

## Background and Description

"Little Esty Shop" is a group project that requires students to build a fictitious e-commerce platform where merchants and admins can manage inventory and fulfill customer invoices.

## Learning Goals
- Practice designing a normalized database schema and defining model relationships
- Utilize advanced routing techniques including namespacing to organize and group like functionality together.
- Utilize advanced active record techniques to perform complex database queries
- [Optional] Practice consuming a public API while utilizing POROs as a way to apply OOP principles to organize code

## Requirements
- Must use Rails 7.0.x, Ruby 3.2.2
- Must use PostgreSQL
- All code must be tested via feature tests and model tests, respectively
- Must use GitHub branching, team code reviews via GitHub PR comments, and either GitHub Projects or a project management tool of your group's choice (Trello, Notion, etc.)
- Must include a thorough README to describe the project
   - README should include a basic description of the project, a summary of the work completed, and some ideas for a potential contributor to work on/refactor next. Also include the names and GitHub links of all student contributors on your project. 
- Must deploy completed code to the internet (using Heroku or Render)
- Continuous Integration / Continuous Deployment is not allowed
- Use of scaffolding is not allowed
- Any gems added to the project must be approved by an instructor
  - Pre-approved gems are `capybara, pry, faker, factory_bot_rails, orderly, simplecov, shoulda-matchers, launchy`

## Setup

* Fork this repository
* Clone your fork
* From the command line, install gems and set up your DB:
    * `bundle`
    * `rails db:create`
* Run the test suite with `bundle exec rspec`.
* Run your development server with `rails s` to see the app in action.

## Phases

1. [Database Setup](./doc/db_setup.md)
1. [User Stories](./doc/user_stories.md)
1. [Extensions](./doc/extensions.md)
1. [Evaluation](./doc/evaluation.md)

________________________________________________________________________________________

Update

Little Esty shop has features for merchants and admins

The features are as follows:

- Merchant Dashboard
- Merchant Items
- Merchant Invoices
- Admin Dashboard
- Admin Invoices

Merchant Dashboard

The feature displays 
- the name of a merchant
- link's to the merchant's item index and invoice page
- top five customers defining success with most transactions
- number of transactions per customer
- items ready to ship
- item names
-corresponding invoice IDs
- links to invoice show pages

Merchant Items

The feature displays
- list of merchant's items
- restriction of visibility to items owned by the merchant
- item details on item show page
- merchant item update information with a successful message upon update
- enablement or disablement of merchant item
- grouping of items by enabled or disabled status
- creation of new items by merchants
- 5 most popular items listed  with links to the item show page
- total revenue for each item
- display of top selling date for the 5 most sold items

Merchant Invoices

The feature displays
- Invoice with a minimum of one merchant item
- Invoice details
- items on the invoice with name, quantity, price and item status
- total revenue based on dynamic invoice by merchant's request

Admin Dashboard

The feature displays
- links to admin merchants index and admin invoices index page
- top 5 customers with highest successful transactions
- Invoice with unshipped items

Admin Merchants

The feature displays
- access to merchants in database
- admin merchants show page(details of individual)
- admin rights (enable or disable)
- grouping of merchants by enabled/disabled status
- top 5 merchants based on total revenue
- links to merchant show page displaying total revenue for each merchant

Admin Invoices

The feature displays

- all Invoices
- admin invoice show page
- invoice details
- lists items on the invoie with details
- total revenue generated from the invoice
- admin rights (update status of invoices)

How this project can be modified

- use of API Consumption
- modifications of the user experience
- html/css styling(craigslist..)
- test: additional sad path testing
- code refactorung: dry, testing, etc.
- modify flash messages or add others for easier user experience


Group Partners

Eric Belongea
- https://github.com/EricBelongea 
Xander Hendry
- https://github.com/XanderHendry
Edward Rodriguez
- https://github.com/TheAveryRodriguez 
Victor Sanchez
- https://github.com/vsanantone

