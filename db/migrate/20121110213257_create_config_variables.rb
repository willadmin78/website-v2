class CreateConfigVariables < ActiveRecord::Migration[4.2]
  def change
    create_table :config_variables do |t|
      t.string :name
      t.string :value
      t.timestamps
    end
  end
end
