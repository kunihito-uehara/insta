class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
      t.string :title
      t.string :image
      t.text :content

      t.timestamps
    end
  end
end
