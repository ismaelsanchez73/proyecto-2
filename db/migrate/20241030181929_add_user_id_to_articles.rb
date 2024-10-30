class AddUserIdToArticles < ActiveRecord::Migration[7.0] # Cambia el número de versión si es necesario
  def change
    add_column :articles, :user_id, :integer
    add_index :articles, :user_id # Opcional: Agregar un índice para mejorar el rendimiento de las consultas
  end
end
