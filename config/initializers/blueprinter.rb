# config/initializers/blueprinter.rb
Blueprinter.configure do |config|
  # Ordenar los campos en el orden en que los definimos (más legible)
  config.sort_fields_by = :definition
end