module ContactsHelper
  def wishlist_countries
    Carmen::Country.all.select{|c| %w{US CA GB AT BE DK FR DE GG IE IM IT JE LU NL ES SE CH}.include?(c.code)}
  end
end
