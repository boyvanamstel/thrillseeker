class Country < ActiveRecord::Base
	has_one :report
	has_one :prisoner
	has_many :dangers
  has_many :consulates

  def cool_title(danger)
    if danger
      case danger.title
        when 'oorlog'
          return "Oorlogje Spelen in #{ self.title }"
        when 'rebellen'
          return "Anarchie in #{ self.title }"
        when 'piraterij'
          return "Piraterij in #{ self.title }"
        when 'geweld'
          return "Ruw Geweld in #{ self.title }"
        when 'carjacking'
          return "Joyriden in #{ self.title }"
        when 'afpersing'
          return "Afpersen in #{ self.title }"
        when 'aardbeving'
          return "Aardbeving in #{ self.title }"
        when 'orkaan'
          return "Stormchasen in #{ self.title }"
        when 'lawine'
          return "Lawinegevaar in #{ self.title }"
        when 'beroving'
          return "Struikroven in #{ self.title }"
        when 'brand'
          return "Vuurtje Stoken in #{ self.title }"
        when 'verkeer'
          return "Rally-rijden in #{ self.title }"
        when 'cycloon'
          return "Waterhoossurfen in #{ self.title }"
        when 'demonstratie'
          return "Demonstreer mee in #{ self.title }"
        when 'overstroming'
          return "Waterpark in #{ self.title }"
        when 'wegen'
          return "Jeep Safari in #{ self.title }"
        when 'terrorist'
          if self.classification.to_i < 3
            return ["Kamperen in #{ self.title }", "Bungalow in #{ self.title }", "Citytrip naar #{ self.title }", "Backpacken in #{ self.title }"].sample
          elsif self.classification.to_i >= 3
            return "Heilige Oorlog Voeren in #{ self.title }"
          else
            return self.title
          end
        else
          return self.title
      end

    end

    self.title 

  end

  def death_rating
    3
  end

  def class_image
    classes = ["beginner", "gevorderd", "veteraan", "ramptoerist"]
    return "#{ classes[self.classification.to_i - 1] }2.png"
  end

  def reisleider
    reisleiders = ["barry", "robin", "boy"]
    return "#{ reisleiders.sample }.png"
  end


end
