require 'httparty'

module Nunchaku
  class ExchangeRate < ActiveRecord
    self.table_name = 'exchange_rates'
    include ::HTTParty

    COUNTRY_CODES = {can: 'CAD', chn: 'CNY', gbr: 'GBP', hkg: 'HKD', idn: 'IDR', ind: 'INR', jpn: 'JPY',
      mys: 'MYR', nzl: 'NZD', phl: 'PHP', sgp: 'SGD', tha: 'THB', usa: 'USD',
      fra: 'EUR', deu: 'EUR', ita: 'EUR', esp: 'EUR'}

    class << self
      def populate(from, to)
        from.upto(to) do |date|
          unless where(quote_date: date).first
            response = HTTParty.get("http://api.fixer.io/#{date.to_s}?base=AUD")
            response['rates'].each do |code,rate|
              create(currency_code: code, quote_date: date, aud_rate: rate)
            end
          end
        end
      end
    end
  end
end