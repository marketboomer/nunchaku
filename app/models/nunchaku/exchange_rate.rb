require 'open-uri'
require 'json'

module Nunchaku
  class ExchangeRate < ActiveRecord
    self.table_name = 'exchange_rates'

    JSONRATES_API_KEY = 'jr-998a5a48b629ce433c0fd7d031944dff'
    class << self
      def populate(from, to)
        base_uri = "http://jsonrates.com/historical/?base=AUD&apiKey=#{JSONRATES_API_KEY}"
        stream = open(base_uri +
                "&dateStart=#{from}" +
                "&dateEnd=#{to}")
        response = JSON.parse(stream.read)
        from.upto(to) do |date|
          unless where(quote_date: date).exists?
            # response = HTTParty.get("http://api.fixer.io/#{date.to_s}?base=AUD")
            rates = response['rates'][date.to_s].except('utctime')
            rates.each do |code,rate|
              create(currency_code: code, quote_date: date, aud_rate: rate.to_d)
            end
          end
        end unless response['error']
      end
    end
  end
end