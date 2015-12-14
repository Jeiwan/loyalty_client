# Loyalty Client

The gem is an API client for a loyalty service. The service provides functions and business logic of loyalty programs (cumulative discount when buying goods), and the gem implements interaction with the service. Later the gem was integrated into a Rails application to satisfy the needs of my customer's clients.

# Description

My customer had a network of offline store (1000+ stores), each store had a computer with a Rails application installed on it. This application helped sale managers in store to sell goods, track each sale, control goods in stock, print receipts on cashbox, order goods from suppliers etc.

One day the customer needed to have loyalty programs in their stores. Loyalty program gives buyers cumulative discount: for each purchase buyer gets loyalty points on his loyalty card, the amount of points depends on the sum of receipt. After buyer collected some points, he can spend them in one of his purchases, i.d. use these points as a discount.

# Tasks

The first task was to implement an API client that interact with a loyatly service. The service had all the business logic related to loyalaty programs, and we just used it in our application. This result is demonstrated in this gem.
The second task was to integrate the API client into our Rails application to allow sales managers actually use loyalty programs. This task included a lot of work with JS, prototyping interfaces, designing user interaction etc. The result code is not demonstated here as it's covered by NDA.

# Structure

There are three main operations:

1. `Loyalty::LoyaltyService::Operations.sale`

2. `Loyalty::LoyaltyService::Operations.return`

3. `Loyalty::LoyaltyService::Operations.rollback`

Each of them corresponding to certain operation: sale of goods, return of goods, rollback of sale or return operations (if something went wrong after tracking sale in the loyalty service).
These 3 methods the highest level of abstraction: they are built on low-level methods that reflect the actual API and prived convenient interface for a programmer.

`LoyaltyService` and `AccountService` are those low-level classes that reflect the actual API of the loyalty service. Each of their methods correspond to certain operation in the API.

`LoyaltyService` implements operations related to sells, returns, rollbacks.

`AccountService` implements operations related to user accounts. Before performing a sale with loyalty program and adding points to buyer's account, the account in fact should be create. So this is the class that implements buyer loyalty account registration, confirmation (vis SMS code), card replacement etc.
