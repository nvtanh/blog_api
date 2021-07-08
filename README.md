# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
`2.7.2`

* Database initialization

Run command to setup and create seed DB

```ruby
bundle exec rails db:drop db:create db:migrate db:seed
```

* How to run the test suite

```ruby
bundle exec rspec
```

* How to run server local and test via postman

Run server in local
```ruby
bundle exec rails s
```

Import postman collection at [here](https://www.postman.com/collections/cf36abd309508f53121f) and test by it
