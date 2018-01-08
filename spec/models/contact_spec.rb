require 'rails_helper'

describe Contact do
  # 姓と名とメールがあれば有効な状態であること
  it "is valid with a firstname, lastname and email" do
    contact = create(:contact)
    expect(contact).to be_valid
  end

  # 名が無ければ、無効な状態であること
  it "is invalid without a firstname" do
    contact = build(:contact, firstname: nil)
    contact.valid?
    expect(contact.errors[:firstname]).to include("can't be blank")
  end

  # 姓が無ければ、無効な状態であること
  it "is invalid without a lastname" do
    contact = build(:contact, lastname: nil)
    contact.valid?
    expect(contact.errors[:lastname]).to include("can't be blank")
  end

  # メールアドレスが無ければ、無効な状態であること
  it "is invalid without an email address" do
    contact = build(:contact, email: nil)
    contact.valid?
    expect(contact.errors[:email]).to include("can't be blank")
  end

  # 重複したメールアドレスなら無効な状態であること
  it "is invalid with a duplicate email address" do
    contact1 = create(:contact, email: "test@example.com")
    contact2 = build(:contact, email: "test@example.com")
    contact2.valid?
    expect(contact2.errors[:email]).to include("has already been taken")
  end

  # 連絡先のフルネームを文字列として返すこと
  it "returns a contact's full name as a string" do
    contact = create(:contact, firstname: "Jhon", lastname: "Smith")
    expect(contact.name).to eq "Jhon Smith"
  end

  # 文字で姓をフィルタする
  describe "filter last name by letter" do
    before :each do
      @smith = create(:contact, lastname: 'Smith')
      @jones = create(:contact, lastname: 'Jones')
      @johnson = create(:contact, lastname: 'Johnson')
    end

    # マッチする文字の場合
    context "with matching letters" do
      # マッチした結果をソート済みの配列として返すこと
      it "returns a sorted array of results that match" do
        expect(Contact.by_letter("J")).to eq [@johnson, @jones]
      end
    end

    # マッチしない文字の場合
    context "with non-matching letters" do
      # マッチしなかったものは結果に含まれないこと
      it "omits results that do not match" do
        expect(Contact.by_letter("J")).not_to eq [@smith]
      end
    end
  end
end
