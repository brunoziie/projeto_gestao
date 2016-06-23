# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
User.create name: "Usuário Administrador", email: "admin@salvus.me", password: "12345678", password_confirmation: "12345678", responsibility: ResponsibilityType::MANAGER
User.create name: "Usuário Desenvolvedor", email: "dev@salvus.me", password: "12345678", password_confirmation: "12345678", responsibility: ResponsibilityType::WORKER
