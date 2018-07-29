class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name
    end
    # If need to make name inque
    # add_index :tags, :name, unique: true
  end
end
