class Country < ActiveRecord::Base
	has_one :report
	has_one :prisoner
	has_many :dangers
end
