require 'rails_helper'
describe User do
  describe '#create' do

    # 必須項目のテストコード
    it "nikcnameがない場合は登録できないこと" do
      user = build(:user, nickname: "")
      user.valid?
      expect(user.errors[:nickname]).to include("を入力してください")
    end

    it "emailがない場合は登録できないこと" do
      user = build(:user, email: "")
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end

    it "emailの中間に@がない場合、登録できないこと" do
      user = build(:user, email: "email")
      user.valid?
      expect(user.errors[:email]).to include("は不正な値です")
    end

    it "emailの中間に@がある場合、登録できること" do
      user = build(:user, email: "email@email")
      expect(user).to be_valid
    end

    it "passwordがない場合は登録できないこと" do
      user = build(:user, password: "")
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end

    it "passwordが存在してもpassword_confirmationがない場合は登録できないこと" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
    end

    it "lastnameがない場合は登録できないこと" do
      user = build(:user, lastname: "")
      user.valid?
      expect(user.errors[:lastname]).to include("を入力してください")
    end

    it "firstnameがない場合は登録できないこと" do
      user = build(:user, firstname: "")
      user.valid?
      expect(user.errors[:firstname]).to include("を入力してください")
    end

    it "firstname_kanaがない場合は登録できないこと" do
      user = build(:user, firstname_kana: "")
      user.valid?
      expect(user.errors[:firstname_kana]).to include("を入力してください")
    end

    it "lastname_kanaがない場合は登録できないこと" do
      user = build(:user, lastname_kana: "")
      user.valid?
      expect(user.errors[:lastname_kana]).to include("を入力してください")
    end

    it "birth_yearがない場合は登録できないこと" do
      user = build(:user, birth_year: "")
      user.valid?
      expect(user.errors[:birth_year]).to include("を入力してください")
    end

    it "birth_monthがない場合は登録できないこと" do
      user = build(:user, birth_month: "")
      user.valid?
      expect(user.errors[:birth_month]).to include("を入力してください")
    end

    it "birth_dayがない場合は登録できないこと" do
      user = build(:user, birth_day: "")
      user.valid?
      expect(user.errors[:birth_day]).to include("を入力してください")
    end

    it "tel_numberがない場合は登録できないこと" do
      user = build(:user, tel_number: "")
      user.valid?
      expect(user.errors[:tel_number]).to include("を入力してください")
    end


    #文字数制限のある項目のテストコード
    it "passwordが7文字以上であれば登録できること" do
      user = build(:user, password: "0000000", password_confirmation: "0000000")
      expect(user).to be_valid
    end

    it "passwordが6文字以下であれば登録できないこと" do
      user = build(:user, password: "000000", password_confirmation: "000000")
      user.valid?
    end


    # 一意性のテストコード
    it "重複したemailが存在する場合登録できないこと" do      
      user = create(:user)
      another_user = build(:user, email: user.email)
      another_user.valid?
      expect(another_user.errors[:email]).to include("はすでに存在します")
    end

    it "重複したnicknameが存在する場合登録できないこと" do      
      user = create(:user)
      another_user = build(:user, nickname: user.nickname)
      another_user.valid?
      expect(another_user.errors[:nickname]).to include("はすでに存在します")
    end

    # 氏名は全角ひらがな・漢字・カタカナであること
    it 'lastnameが全角であること（半角カナではない）' do
      user = build(:user, lastname: "ｱｱ")
      user.valid?
      expect(user.errors[:lastname]).to include("は不正な値です")
    end

    it 'lastnameが全角であること（半角英語ではない）' do
      user = build(:user, lastname: "aa")
      user.valid?
      expect(user.errors[:lastname]).to include("は不正な値です")
    end

    it 'lastnameが全角であること（半角数字ではない）' do
      user = build(:user, lastname: "11")
      user.valid?
      expect(user.errors[:lastname]).to include("は不正な値です")
    end
 
    it 'lastnameが全角であること（全角数字ではない）' do
      user = build(:user, lastname: "２２２")
      user.valid?
      expect(user.errors[:lastname]).to include("は不正な値です")
    end
 
    it 'lastnameが全角ひらがなであれば登録できる' do
      user = build(:user, lastname: "ああ")     
      expect(user).to be_valid 
    end
   
    it 'lastnameが全角漢字であれば登録できる' do
      user = build(:user, lastname: "嗚呼")     
      expect(user).to be_valid 
    end

    it 'lastnameが全角カタカナであれば登録できる' do
      user = build(:user, lastname: "アア")     
      expect(user).to be_valid 
    end

    it 'firstnameが全角であること（半角カナではない）' do
      user = build(:user, firstname: "ｲｲ")
      user.valid?
      expect(user.errors[:firstname]).to include("は不正な値です")
    end

    it 'firstnameが全角であること（半角英語ではない）' do
      user = build(:user, firstname: "ee")
      user.valid?
      expect(user.errors[:firstname]).to include("は不正な値です")
    end

    it 'firstnameが全角であること（半角数字ではない）' do
      user = build(:user, firstname: "11")
      user.valid?
      expect(user.errors[:firstname]).to include("は不正な値です")
    end

    it 'firstnameが全角であること（全角数字ではない）' do
      user = build(:user, firstname: "１１")
      user.valid?
      expect(user.errors[:firstname]).to include("は不正な値です")
    end

    it 'firstnameが全角ひらがなであれば登録できる' do
      user = build(:user, firstname: "ああ")     
      expect(user).to be_valid 
    end

    it 'firstnameが全角漢字であれば登録できる' do
      user = build(:user, firstname: "嗚呼")     
      expect(user).to be_valid 
    end

    it 'firstnameが全角カタカナであれば登録できる' do
      user = build(:user, firstname: "アア")     
      expect(user).to be_valid 
    end

    # 氏名のカナは全角カタカナのみ
    it 'firstname_kanaが全角カタカナであること（半角カナではない）' do
      user = build(:user, firstname_kana: "ｲｲ")
      user.valid?
      expect(user.errors[:firstname_kana]).to include("は不正な値です")
    end

    it 'firstname_kanaが全角カタカナであること（ひらがなではない）' do
      user = build(:user, firstname_kana: "いい")
      user.valid?
      expect(user.errors[:firstname_kana]).to include("は不正な値です")
    end

    it 'firstname_kanaが全角カタカナであること（全角英語ではない）' do
      user = build(:user, firstname_kana: "ｒｑ")
      user.valid?
      expect(user.errors[:firstname_kana]).to include("は不正な値です")
    end

    it 'firstname_kanaが全角カタカナであること（半角英語ではない）' do
      user = build(:user, firstname_kana: "EE")
      user.valid?
      expect(user.errors[:firstname_kana]).to include("は不正な値です")
    end

    it 'firstname_kanaが全角カタカナであること（数字ではない）' do
      user = build(:user, firstname_kana: "11")
      user.valid?
      expect(user.errors[:firstname_kana]).to include("は不正な値です")
    end

    it 'firstname_kanaが全角カタカナであれば登録できる' do
      user = build(:user, firstname_kana: "イイ")     
      expect(user).to be_valid 
    end

    it 'lastname_kanaが全角カタカナであること（半角カナではない）' do
      user = build(:user, lastname_kana: "ｱｱ")
      user.valid?
      expect(user.errors[:lastname_kana]).to include("は不正な値です")
    end

    it 'lastname_kanaが全角カタカナであること（ひらがなではない）' do
      user = build(:user, lastname_kana: "ああ")
      user.valid?
      expect(user.errors[:lastname_kana]).to include("は不正な値です")
    end

    it 'lastname_kanaが全角カタカナであること（全角英語ではない）' do
      user = build(:user, lastname_kana: "ｒｑ")
      user.valid?
      expect(user.errors[:lastname_kana]).to include("は不正な値です")
    end

    it 'lastname_kanaが全角カタカナであること（半角英語ではない）' do
      user = build(:user, lastname_kana: "aa")
      user.valid?
      expect(user.errors[:lastname_kana]).to include("は不正な値です")
    end

    it 'lastname_kanaが全角カタカナであること（数字ではない）' do
      user = build(:user, lastname_kana: "22")
      user.valid?
      expect(user.errors[:lastname_kana]).to include("は不正な値です")
    end


    #tel_number関連
    it 'tel_numberが10文字で登録出来ること' do
      user = build(:user, tel_number: "0123456789")
      expect(user).to be_valid 
    end

    it 'tel_numberが11文字で登録出来ること' do
      user = build(:user, tel_number: "01234567890")
      expect(user).to be_valid 
    end

    it 'tel_numberが9文字で登録出来ないこと' do
      user = build(:user, tel_number: "012345678")
      user.valid?
      expect(user.errors[:tel_number]).to include("は10文字以上で入力してください")
    end

    it 'tel_numberが12文字で登録出来ないこと' do
      user = build(:user, tel_number: "012345678910")
      user.valid?
      expect(user.errors[:tel_number]).to include("は11文字以内で入力してください")
    end

    it 'tel_numberにひらがなが入ると登録できない' do
      user = build(:user, tel_number: "0900000000あ")
      user.valid?
      expect(user.errors[:tel_number]).to include("は数値で入力してください")
    end

    it 'tel_numberに全角カタカナが入ると登録できない' do
      user = build(:user, tel_number: "0900000000ア")
      user.valid?
      expect(user.errors[:tel_number]).to include("は数値で入力してください")
    end

    it 'tel_numberに半角カタカナが入ると登録できない' do
      user = build(:user, tel_number: "0900000000ｱ")
      user.valid?
      expect(user.errors[:tel_number]).to include("は数値で入力してください")
    end

    it 'tel_numberに半角英語が入ると登録できない' do
      user = build(:user, tel_number: "0900000000a")
      user.valid?
      expect(user.errors[:tel_number]).to include("は数値で入力してください")
    end

    it 'tel_numberに全角数字が入ると登録できない' do
      user = build(:user, tel_number: "0900000000９")
      user.valid?
      expect(user.errors[:tel_number]).to include("は数値で入力してください")
    end

    it 'tel_numberに全角英語が入ると登録できない' do
      user = build(:user, tel_number: "0900000000Ａ")
      user.valid?
      expect(user.errors[:tel_number]).to include("は数値で入力してください")
    end

  end
end