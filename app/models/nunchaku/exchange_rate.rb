require 'open-uri'
require 'json'

module Nunchaku
  class ExchangeRate < ActiveRecord
    self.table_name = 'exchange_rates'

    JSONRATES_API_KEY = '424e4f63972152d6c326980cf6f8a536'
    class << self
      def populate(date)
        base_uri = "http://apilayer.net/api/historical?access_key=#{JSONRATES_API_KEY}"
        stream = open(base_uri +
                "&date=#{date}")
        response = JSON.parse(stream.read)
        unless where(quote_date: date).exists?
          rates = response['quotes']
          aud_rate_conversion = rates["USDAUD"]
          rates.each do |code,rate|
            currency_code = code.slice(3..6)
            new_rate = rate.to_d / aud_rate_conversion.to_d
            create(currency_code: currency_code, quote_date: date, aud_rate: new_rate)
          end
        end unless response['error']
      end
    end
  end
end
