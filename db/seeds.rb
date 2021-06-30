# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Genre.create!(id: 1, genre_name: "主食", price: "500")
Genre.create!(id: 2, genre_name: "副食", price: "300")
Genre.create!(id: 3, genre_name: "スープ", price: "200")
Genre.create!(id: 4, genre_name: "ドレッシング・ソース", price: "150")
Genre.create!(id: 5, genre_name: "デザート", price: "150")
