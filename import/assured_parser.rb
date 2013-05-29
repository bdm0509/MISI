class AssuredParser
  MATCH_SEQUENCE = "!@#$@#"

  def self.parse(text)
    text = text.gsub!(/\s+/, " ")

    assureds = text.split("\n")

    assureds.each { |assured|
      assured_components = assured.split
      
      puts "Assured\n--------\n#{assured}\n"
    }
  end

end
