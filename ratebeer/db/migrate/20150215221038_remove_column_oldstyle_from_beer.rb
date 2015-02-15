class RemoveColumnOldstyleFromBeer < ActiveRecord::Migration
  def change
    remove_column :beers, :oldstyle
  end
end
