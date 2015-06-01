class Event < ActiveRecord::Base
  belongs_to :creator, :class_name => "User"
  has_many :invites, :foreign_key => "attended_event_id"
  has_many :attendees, :through => :invites

  scope :upcoming, -> { where("Date >= ?", Time.zone.now).order('Date ASC') }
  scope :past, -> { where("Date < ?", Time.zone.now).order('Date DESC') }
end
