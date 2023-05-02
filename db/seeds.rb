# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Users
User.destroy_all

User.create(first_name: "Example",
            last_name: "User",
            email: "example@gmail.com",
            password: "123456",
            categories: Category.create([{ name: "Personal" },
                                         { name: "Work" },
                                         { name: "Vacation" }]))
