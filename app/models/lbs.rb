class Lbs
  include Mongoid::Document
  field :user_id, :type => Integer
  field :location, :type => String
end
