class Country < ActiveRecord::Base
	has_one :report
	has_one :prisoner
end
