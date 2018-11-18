<<<<<<< HEAD
module UsersHelper  
  
  # Returns the Gravatar for the given user.
  def gravatar_for(user, options = { size: 80 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: "#{user.first_name} #{user.last_name}", class: "gravatar")
  end
=======
module UsersHelper
>>>>>>> 528a84ac36f9ee8ae5ac92ad60e3b15c99db9827
end
