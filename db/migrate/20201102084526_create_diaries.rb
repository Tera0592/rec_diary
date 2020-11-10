class CreateDiaries < ActiveRecord::Migration[6.0]
  def change
    create_table :diaries do |t|

      t.integer   :user_id,       foreign_key: true
      t.datetime  :time,          null: false
      t.string    :title,         null: false
      t.text      :impression,    null: false
      t.timestamps
    end
  end
end
