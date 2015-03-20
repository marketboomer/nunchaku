class CreateExchangeRateTable < ActiveRecord::Migration
  def change
    create_table :exchange_rates do |t|
      t.string  :country_code, nullable: false
      t.string  :currency_code, nullable: false
      t.date    :quote_date, nullable: false
      t.decimal :aud_rate, precision: 19, scale: 4, nullable: false
      t.integer :lock_version, default: 0
      t.timestamps
    end
  end
end