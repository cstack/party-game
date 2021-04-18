class AddTokenToStories < ActiveRecord::Migration[6.1]
  def change
  	add_column :stories, :token, :string
  end
end
