# 👨🏻‍💻 Rami's Shopify Backend Challenge 2019👨🏻‍💻

Hopefully this doesn't suck and helps you understand how to get this running, doing all the things you want it to. I'm only going to be documenting how to use the API which can be accessed where its deployed. If you want to clone the repo and try running this project locally i'm sure you'll know how to set it up. I'm assuming whoever is looking over this has experience with setting up and running a Ruby on Rails project so forgive me for skipping some details. 

You can access the API here once you have the project running: http://localhost:3000/graphiql

* [The API](https://github.com/ramitaleb/shopify-backend-challenge-2019#the-api)
  
  * [The Model](https://github.com/ramitaleb/shopify-backend-challenge-2019#the-model)
  
  * [Adding Products to the Marketplace](https://github.com/ramitaleb/shopify-backend-challenge-2019#adding-products-to-the-marketplace)
  
  * [Querying for Products](https://github.com/ramitaleb/shopify-backend-challenge-2019#querying-for-products)
  

## The API ⚙️
I decided to use [GraphQL](https://graphql.org/) as I've never used it before and I thought it would be a great opportunity to get my feet wet with it. *The bonus points also don't hurt* 🤪

### The Model
Before we get into using the API we should familiarize ourselves with the model that we'll be working with.

The Product model is what we're going to be using which has the following attributes:

`title`: String

`price`: Float

`inventory_count`: Integer

### Adding Products to the Marketplace
To be able to query for products, we must first have products to query. This is how we're going to do that.
You're going to want to write a mutation that will be able to add whatever you specify to the database.

Example:
```
mutation {
  create_product (
    title: "sandwich"
    price: 5.00
    inventory_count: 80
  ) {
    id
    title
    price
    inventory_count
  }
}
```
Output:
```
{
  "data": {
    "create_product": {
      "id": "1",
      "title": "sandwich",
      "price": 5,
      "inventory_count": 80
    }
  }
}
```
What this will do is it will create a sandwich, with the price of 5.00 and an inventory count of 80 then return to you the object its created.. You can change these values to whatever you'd like as long as they respect the type of the given attribute.

### Querying for Products
Now that we have a product or multiple products in our database, we can start querying for them.

#### Querying for a Single Product
##### Querying by ID
Here we are querying for a product by its unique ID. We are asking for it to return to us the id, title, price and inventory_count. 

Example:
```
{
  product_by_id(id: 1) {
    id
    title
    price
    inventory_count
  }
}
```
Output:
```
{
  "data": {
    "product_by_id": {
      "id": "1",
      "title": "sandwich",
      "price": 5.00,
      "inventory_count": 80
    }
  }
}
```
As you can see it returns for us just the one product that we specified we wanted using the ID.

##### Querying by Title
Here we are querying for a product by its title.

Example:
```
{
  product_by_title(title: "sandwich") {
		id
    title
    price
    inventory_count
  }
}
```
Output: 
```
{
  "data": {
    "product_by_title": {
      "id": "1",
      "title": "sandwich",
      "price": 5.00,
      "inventory_count": 80
    }
  }
}
```
As you can see it returns for us just the one product that we specified we wanted using the title.

#### Querying for Multiple Products
##### Querying for all Products
Here we are querying for all products.

Example:
```
{
  all_products() {
    id
    title
    price
    inventory_count
  }
}
```
OR
```
{
  all_products(only_available: false){
    id
    title
    price
    inventory_count
  }
}
```
Output: 
```
{
  "data": {
    "all_products": [
      {
        "id": "1",
        "title": "sandwich",
        "price": 5.00,
        "inventory_count": 80
      },
      {
        "id": "2",
        "title": "headphones",
        "price": 55.00,
        "inventory_count": 800
      },
      {
        "id": "3",
        "title": "love",
        "price": 1.00,
        "inventory_count": 0
      }
    ]
  }
}
```
In both cases you can see it returns for us all products currently in our marketplace.

##### Querying for all Available Products
Available proucts are products with an `inventory_count > 0`. We must pass an argument `only_available: true` to be able to only see the products that are available. 

Example:
```
{
  all_products(only_available: true){
    id
    title
    price
    inventory_count
  }
}
```
Output:
```
{
  "data": {
    "all_products": [
      {
        "id": "1",
        "title": "sandwich",
        "price": 5.00,
        "inventory_count": 80
      },
      {
        "id": "2",
        "title": "headphones",
        "price": 55.00,
        "inventory_count": 800
      }
    ]
  }
}
```
As you can see here, we only were returned the products `sandwich` and `headphones`. Since the product `love` has an `inventory_count` of 0 it is not shown in this output. 💔

### Purchasing a Product
You are also able to purchase available products with the API by calling this mutation endpoint along with the `id` of the product you would like to purchase. (No guarantee you will receive any product you purchase 😶)

Example:
```
mutation {
  purchase_product (
    id: 1
  ) {
    id
    title
    price
    inventory_count
  }
}
```

Output:
```
{
  "data": {
    "purchase_product": {
      "id": "1",
      "title": "sandwich",
      "price": 5.0,
      "inventory_count": 79
    }
  }
}
```
As you can see we are returned the product we purchased with an updated `inventory_count` that has been decremented by 1.

**Note**: Attempting to purchase a product with an `inventory_count` of 0 will just return back the product without decrementing it further. 



