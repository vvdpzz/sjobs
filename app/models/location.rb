class Location
  include Mongoid::Document
  field :user_id, :type => Integer
  field :user_name
  field :time, :type => Time, :default =>Time.now
  field :longitude, :type => String
  field :latitude, :type => String
  field :z_elev
  field :velocity
  field :accel
  field :direction
  field :pitch
  field :roll
  field :battery
  field :confidence
  field :message, :type => String
end
