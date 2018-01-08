require 'rails_helper'

describe Phone do
  # 連絡先ごとに重複した電話番号を許可しないこと
  it 'does not allow duplicate phone numbers per contact' do
    contact = create(:contact)
    contact.phones.create(phone_type: 'home', phone: '000-000-000')
    mobile_phone = contact.phones.build(phone_type: 'mobile', phone: '000-000-000')
    mobile_phone.valid?
    expect(mobile_phone.errors[:phone]).to include("has already been taken")
  end

  # 2件の連絡先で同じ電話番号を共有できること
  it 'allows two contacts to share a phone number' do
    contact = create(:contact)
    phone = contact.phones.create(phone_type: 'home', phone: '000-000-000')
    other_contact = build(:contact)
    other_phone = other_contact.phones.build(phone_type: 'home', phone: '000-000-000')
    expect(other_phone).to be_valid
  end
end
