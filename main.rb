# frozen_string_literal: true

require 'uri'
require 'net/http'
require 'json'
require 'dotenv/load'
require 'rspec/autorun'
class CryptoParse
  def run
    p '*' * 100
    p 'Full payload of given ["BTC", "XRP", "ETH"] cryptocurrencies'
    p '-' * 100
    p full_payload(%w[BTC XRP ETH])
    sleep(1)
    p '*' * 100
    p 'View the [circulating_supply, max_supply, name, symbol, price] for [ETH, BTC]'
    p '-' * 100
    fields = get_specific_fields(%w[BTC ETH])
    p fields
    sleep(1)
    p '*' * 100
    p 'Specific cryptocurrency to specific fiat. Ie: BTC in ZAR or ETH in USD'
    p '-' * 100
    p convertion('BTC', 'ZAR')
    sleep(1)
    p convertion('ETH', 'USD')
    p '*' * 100
    p 'Calculate the price of one cryptocurrency from another, in relation to their dollar value Ie: 1BTC = $100, 1ETH = $50, therefore 1ETH == 0.5BTC'
    p '-' * 100
    calculations(fields)
  end

  ##### TASK 1
  def full_payload(cryptocurrencies)
    uri = URI("https://api.nomics.com/v1/currencies/ticker?key=#{ENV['KEY']}&ids=#{cryptocurrencies.join(', ')}")
    JSON.parse(Net::HTTP.get(uri))
  end

  ##### TASK 2
  def get_specific_fields(cryptocurrencies)
    full_response = full_payload(cryptocurrencies)
    wanted_keys = %w[circulating_supply max_supply name symbol price]
    response = []
    full_response.each do |crypto|
      response << crypto.to_h.select { |key, _| wanted_keys.include? key }
    end
    response
  end

  ##### TASK 3
  def convertion(crypto, currency)
    uri = URI("https://api.nomics.com/v1/currencies/ticker?key=#{ENV['KEY']}&ids=#{crypto}&convert=#{currency}")
    "#{crypto} in #{currency} => #{JSON.parse(Net::HTTP.get(uri)).first['price']}"
  end

  ##### TASK 4
  def calculations(fields)
    bitcoin = fields[0]
    etherium = fields[1]
    p "#{bitcoin['symbol']} = #{bitcoin['price']} $"
    p "#{etherium['symbol']} = #{etherium['price']} $"
    p "1 #{etherium['symbol']} == #{etherium['price'].to_f / bitcoin['price'].to_f} #{bitcoin['symbol']}"
  end
end

CryptoParse.new.run
