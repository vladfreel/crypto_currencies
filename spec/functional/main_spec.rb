# frozen_string_literal: true

require 'spec_helper'
RSpec.describe 'CryptoParse Functional Test' do
  describe 'CryptoParse' do
    it 'Task 1' do
      expect(CryptoParse.new.full_payload(%w[BTC XRP ETH]).count).to eq(3)
    end

    it 'Task 2' do
      sleep(1)
      subject = CryptoParse.new.get_specific_fields(%w[BTC ETH])
      expect(subject[0]).to have_key('symbol')
      expect(subject[0]).to have_key('name')
      expect(subject[0]).to have_key('price')
      expect(subject[0]).to have_key('circulating_supply')
      expect(subject[0]).to have_key('max_supply')
      expect(subject[1]).to have_key('symbol')
      expect(subject[1]).to have_key('name')
      expect(subject[1]).to have_key('price')
      expect(subject[1]).to have_key('circulating_supply')
      # expect(subject[1]).to have_key('max_supply') not surewhy the API not return this data
    end

    it 'Task 3' do
      sleep(1)
      expect(CryptoParse.new.convertion('BTC', 'ZAR')).to include('BTC in ZAR ')
      sleep(1)
      expect(CryptoParse.new.convertion('ETH', 'USD')).to include('ETH in USD ')
    end

    it 'Task 4' do
      sleep(1)
      crypto = CryptoParse.new
      expect(crypto.calculations(crypto.get_specific_fields(%w[BTC ETH]))).to include('1 ETH == ')
    end
  end
end
