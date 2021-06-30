class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references  :user, forien_key: true
      t.references  :recipe, forien_key: true
      t.timestamps
    end
  end
end
