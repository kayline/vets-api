# frozen_string_literal: true

require 'rails_helper'

describe EVSS::PCIUAddress::DomesticAddress do
  it 'should have valid factory' do
    expect(build(:pciu_domestic_address)).to be_valid
  end

  it 'should require address_one' do
    expect(build(:pciu_domestic_address, address_one: '')).not_to be_valid
  end

  it 'should raise an error if address_one contains invalid chars' do
    expect(build(:pciu_domestic_address, address_one: '123 main ®t.')).not_to be_valid
  end

  it 'should not require address_two or three' do
    expect(build(:pciu_domestic_address, address_two: '')).to be_valid
    expect(build(:pciu_domestic_address, address_three: '')).to be_valid
  end

  it 'should require address fields to be less than 35 chars' do
    expect(
      build(:pciu_domestic_address, address_one: 'Chargoggagoggmanchauggagoggchaubunagungamaugg')
    ).not_to be_valid
    expect(
      build(:pciu_domestic_address, address_two: 'Chargoggagoggmanchauggagoggchaubunagungamaugg')
    ).not_to be_valid
    expect(
      build(:pciu_domestic_address, address_three: 'Chargoggagoggmanchauggagoggchaubunagungamaugg')
    ).not_to be_valid
  end

  it 'should require city to be less than 30 chars' do
    expect(build(:pciu_domestic_address, city: 'Pekwachnamaykoskwaskwaypinwanik')).not_to be_valid
  end

  it 'should require city' do
    expect(build(:pciu_domestic_address, city: '')).not_to be_valid
  end

  it 'should require state_code' do
    expect(build(:pciu_domestic_address, state_code: '')).not_to be_valid
  end

  it 'should not require country_name' do
    expect(build(:pciu_domestic_address, country_name: '')).to be_valid
  end

  it 'should require and validate zip_code' do
    expect(build(:pciu_domestic_address, zip_code: '')).not_to be_valid
    expect(build(:pciu_domestic_address, zip_code: 'abc12')).not_to be_valid
    expect(build(:pciu_domestic_address, zip_code: '987655')).not_to be_valid
  end

  it 'should validate zip_suffix if it is present' do
    expect(build(:pciu_domestic_address, zip_suffix: '1234')).to be_valid
    expect(build(:pciu_domestic_address, zip_suffix: 'ab12')).not_to be_valid
  end
end
