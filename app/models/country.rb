class Country < ActiveRecord::Base
	has_one :report
	has_one :prisoner
	has_many :dangers

  def cool_title
    if self.dangers.count > 0
      danger = self.dangers.sample
      case danger.title
        when 'oorlog'
          return "Oorlogje spelen in #{ self.title }"
        when 'rebellen'
          return "Anarchie in #{ self.title }"
        when 'piraterij'
          return "Piraterij in #{ self.title }"
        when 'geweld'
          return "Ruw geweld in #{ self.title }"
        when 'carjacking'
          return "Raak je auto kwijt in #{ self.title }"
        when 'afpersing'
          return "Corruptie in #{ self.title }"
        when 'aardbeving'
          return "Aardbeving in #{ self.title }"
        when 'orkaan'
          return "Harde wind in #{ self.title }"
        when 'lawine'
          return "Lawinegevaar in #{ self.title }"
        when 'beroving'
          return "Schavuiten in #{ self.title }"
        when 'brand'
          return "Vuurtje stoken in #{ self.title }"
        when 'verkeer'
          return "Rally-rijden in #{ self.title }"
        when 'cycloon'
          return "Windhozen in #{ self.title }"
        when 'demonstratie'
          return "Demonstreer mee in #{ self.title }"
        when 'overstroming'
          return "Watergeweld in #{ self.title }"
        when 'wegen'
          return "Gaten in de weg in #{ self.title }"
        when 'terrorist'
          return "Bomgordels in #{ self.title }"
        else
          return self.title
      end

    end

    self.title 

  end

end
