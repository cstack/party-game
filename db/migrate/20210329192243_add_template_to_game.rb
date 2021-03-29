class AddTemplateToGame < ActiveRecord::Migration[6.1]
  def change
  	add_column :games, :template, :string
  end
end
