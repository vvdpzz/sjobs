class Location
  include Mongoid::Document
  field :user_id, :type => Integer
  field :user_name
  field :receive_time, :type => Time
  attr_accessor :latitude
  attr_accessor :longtitude
  field :lat_long, :type => Array
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
