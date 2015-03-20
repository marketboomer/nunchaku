class DeleteCountryCodeFromExchangeRates < ActiveRecord::Migration
  def up
    remove_column :exchange_rates, :country_code
  end

  def down
    add_column :exchange_rates, :country_code, nullable: false
  end
end
