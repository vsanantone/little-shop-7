# Extensions

## Tier 1 - Least Difficult

```
Extension 1-1: Manage Invoice Statuses

As an admin     
When I visit an admin invoices index page
I see each of the invoices statuses
I also have the ability to manage all invoice statuses on the page at the same time.
I can change multiple statuses via a dropdown list or checkboxes.
When I click the update button, I see the changes reflected on the index page for each invoice I updated.
```

```
Extension 1-2: Sort Lists 

As an admin, merchant, or visitor
On all pages that list all merchants, invoices, or items
I see a button to sort the list alphabetically, and I see a button to sort by most recent date.
When I click these buttons, the list is updated accordingly.
```

### Styling

Implement a consistent look and feel throughout your site with reusable styles.

You could use a framework for this such as [Bootstrap](https://getbootstrap.com) or [Tailwind](https://tailwindcss.com/). 

[Bootstrap Ruby Gem](https://github.com/twbs/bootstrap-rubygem)

Or, you could create custom styles!

## Tier 2 - Difficult

### API Consumption

For each of these additional user stories, you will need to hit an endpoint provided by the [Unsplash API](https://unsplash.com/developers) in order to serve the data required on your site.
NOTE: Use of the Unsplash gem is not permitted for this project. 

```
37. Unsplash API: App Logo

As a visitor or an admin user
When I visit any page on the site
I see the logo image at the top of every page

Note: You can choose which picture from Unsplash you'd like to be your app's logo. DO NOT save the image to your repo, but instead serve it up via the API.
```

```
38. Unsplash API: Item Image

As a visitor or an admin user
When I visit the Merchant Item Show page (/merchants/:merchant_id/items/:item_id)
I see a photo related to that item's name
```

```
39. Unsplash API: Merchant Image

As a visitor or an admin user
When I visit a Merchant's Dashboard (/merchants/:merchant_id/dashboard)
I see a random photo near the name of the Merchant
This photo should update to a new random photo each time the page is refreshed.
```

```
40. Unsplash API: Logo Image Like History

As a visitor or an admin user
When I visit any page on the site
I see that next to the app logo is the number of likes that image has. 

Note: Communicate with your teammate that is working on the first API story to make sure you're gathering statistics for the same image that they're displaying as the logo. 
```


### Filters

```
Extension 2-1: Filters

As an admin, I have the ability to see all items on the site
I can also filter the results of this page by any item attribute

What this could look like:
Search boxes for both name and description
Check boxes for merchant names
Greater than, less than, and equal to options for unit price
Greater than, less than, and equal to options for created at and updated at
```

## Tier 3 - Most Difficult

### Extension 3-1: Auth
Implement authentication and authorization for admins and/or merchant users.

[Authentication Lesson Plan](https://backend.turing.io/module2/lessons/authentication)

[Authorization Lesson Plan](https://backend.turing.io/module2/lessons/authorization)

[Sessions](https://guides.rubyonrails.org/action_controller_overview.html)


### Extension 3-2: Cart
Implement the functionality for visitors to start adding items to their cart.

[Cart Lesson Plan](https://backend.turing.io/module2/lessons/cart_implementation)

### Extension 3-3: Chat
Research [Action Cable](https://guides.rubyonrails.org/action_cable_overview.html) and implement chat functionality on the site.


### Extension 3-4: Come Up With Your Own Feature!

Talk with your team to come up with a feature that could be implemented in this project. (Please get approval from your instructor before starting work.)
