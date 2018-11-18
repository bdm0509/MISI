class AssuredParser
  def self.parse(text)
    text = text.gsub!(/\s\s+/, "  ").rstrip
    assureds = text.split("\n")

    assureds.each { |assured_text|
      assured_components = assured_text.rstrip.split("  ")
      
      # Lots of conditionals here
      title = assured_components[0]
      if assured_components.size == 8
        street  = assured_components[1]
        city    = assured_components[2]
        state   = assured_components[3]
        zip     = assured_components[4]
        phone   = assured_components[5]
        contact = assured_components[6]
        fee     = assured_components[7]
      elsif assured_components.size == 7
        street  = assured_components[1]
        city    = assured_components[2]
        state   = assured_components[3]
        zip     = assured_components[4]
        phone   = assured_components[5]
        fee     = assured_components[6]
      elsif assured_components.size == 4
        city    = assured_components[1]
        state   = assured_components[2]
        fee     = assured_components[3]
      elsif assured_components.size == 3
        contact = assured_components[1]
        fee     = assured_components[2]
      elsif assured_components.size == 2
        fee     = assured_components[1]
      else
        unless assured_components.size == 1 and title == "Miscellaneous"
          puts "Error! I don't know how to handle '#{assured_text}', with #{assured_components.size} components"
        end
      end

      assured = Assured.new(
        :title   => title,
        :street  => street,
        :city    => city,
        :state   => state,
        :zip     => zip,
        :contact => contact,
        :phone   => phone,
        :fee     => fee
      )
      
      assured.save!
    }
  end
end