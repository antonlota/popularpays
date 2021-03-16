class CreateGigs < ActiveRecord::Migration[6.1]
  def change
    create_table :gigs do |t|
      t.string :brand_name
      t.integer :state
      t.references :creator, null: false, foreign_key: true

      t.timestamps
    end
  end
end
