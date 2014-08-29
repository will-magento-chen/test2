module ContactsHelper
  def wishlist_countries
    Carmen::Country.all.select{|c| %w{US CA GB AT BE DK FR DE GG IE IM IT JE LU NL ES SE CH}.include?(c.code)}
  end

  def csv_contacts_path
    if request.fullpath == "/"
      "/contacts.csv"
    elsif request.fullpath.include?("/?")
      request.fullpath.gsub!("\/?", "contacts.csv?")
    else
      request.fullpath.gsub!("contacts", "contacts.csv")
    end
  end
end
