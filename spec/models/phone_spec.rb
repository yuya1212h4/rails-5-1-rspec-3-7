require 'rails_helper'

describe Phone do
  # 連絡先ごとに重複した電話番号を許可しないこと
  it 'does not allow duplicate phone numbers per contact' do
    contact = create(:contact)
    create(:home_phone, phone: '000-000-000', contact: contact)
    mobile_phone = build(:mobile_phone, phone: '000-000-000', contact: contact)
    mobile_phone.valid?
    expect(mobile_phone.errors[:phone]).to include("has already been taken")
  end

  # 2件の連絡先で同じ電話番号を共有できること
  it 'allows two contacts to share a phone number' do
    create(:home_phone, phone: '000-000-000')
    expect(build(:home_phone, phone: '000-000-000')).to be_valid
  end
end
