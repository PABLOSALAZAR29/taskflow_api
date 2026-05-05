class UserBlueprint < Blueprinter::Base
  identifier :id

  fields :name, :email, :role

  # Vista por defecto (sin especificar view)
  view :normal do
    fields :name, :email, :role
  end

  # Vista extendida (opcional, por si la necesitas después)
  view :extended do
    fields :name, :email, :role, :created_at
  end
end