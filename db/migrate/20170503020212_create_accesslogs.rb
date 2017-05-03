class CreateAccesslogs < ActiveRecord::Migration[5.0]
  def change
    create_table :accesslogs do |t|
      t.string :word
      t.string :params
      t.datetime :date_created

      t.timestamps
    end
  end
end
