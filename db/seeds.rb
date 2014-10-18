# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create!(email: 'ejcorrea@uc.cl', role: :administrador, password: 'mamamia123', password_confirmation: 'mamamia123', confirmed_at: Time.now)
user = User.create!(email: 'ejcorrea2@uc.cl', role: :moderador, password: 'mamamia123', password_confirmation: 'mamamia123', confirmed_at: Time.now)

Curso.create!(nombre: "Programación Avanzada", sigla: "IIC2233")