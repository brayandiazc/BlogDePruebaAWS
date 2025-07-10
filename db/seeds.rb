# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

puts "Creando categorías..."
Category.find_or_create_by(name: 'Tecnología')
Category.find_or_create_by(name: 'Programación')
Category.find_or_create_by(name: 'Diseño')
Category.find_or_create_by(name: 'Marketing')
puts "Categorías creadas."
