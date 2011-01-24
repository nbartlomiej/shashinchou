class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :albums
  has_many :comments

  # displays web-ready user text description (i.e. with 
  # obfuscated email; here the email is converted to 
  # unicode upside down characters - not the most 
  # effective method but might suffice for this example)
  def to_s

    # preparing strings of letters and corresponding
    # upside-down characters; 
    # source: http://www.fileformat.info/convert/text/upside-down.htm
    classic = "QWERTYUIOPASDFGHJKLZXCVBNMqwertyuiopasdfghjklzxcvbnm1234567890-_@+.".reverse
    upside_down = "˙+@‾-068Ɫ95ᔭƐ21ɯuqʌɔxzʃʞɾɥƃɟpsɐdoınʎʇɹǝʍbWᴎ𐐒ᴧↃXZ⅂⋊ſH⅁Ⅎ◖S∀ԀOI∩⅄⊥ᴚƎMΌ"

    # substituting letters from one string to the 
    # other; reversing at the end, because when
    # text is flipped upside down it is only
    # readable right-to-left
    email.split(//).collect do |c|
      pos = classic.index(c)
      upside_down.split(//)[pos || 0]
    end.reverse
  end

end
