# frozen_string_literal: true

require 'rails_helper'

describe EVSS::PCIUAddress::InternationalAddress do
  it 'should have valid factory' do
    expect(build(:pciu_international_address)).to be_valid
  end

  it 'should require address_one' do
    expect(build(:pciu_international_address, address_one: '')).not_to be_valid
  end

  it 'should require city' do
    expect(build(:pciu_international_address, city: '')).not_to be_valid
  end

  it 'should require country_name' do
    expect(build(:pciu_international_address, country_name: '')).not_to be_valid
  end
end
