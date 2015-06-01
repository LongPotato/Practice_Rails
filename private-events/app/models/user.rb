class User < ActiveRecord::Base
  validates :name, presence: true
  validates :email, presence: true

  has_many :events, :foreign_key => :creator_id
  has_many :invites, :foreign_key => "attendee_id"
  has_many :attended_events, :through => :invites

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def User.encript_token(string)
    Digest::SHA1.hexdigest(string.to_s)
  end

  def authenticated_token(token)
    return true if User.find_by(remember_token: token)
  end

  def upcoming_events
    self.attended_events.upcoming
  end

  def previous_events
    self.attended_events.past
  end

  def attending?(event)
    event.attendees.include?(self)
  end

  def attend!(event)
    self.invites.create!(attended_event_id: event.id)
  end

  def cancel!(event)
    self.invites.find_by(attended_event_id: event.id).destroy
  end

  private

    def insert_token
      self.remember_token = User.encript_token(User.new_token)
    end
end
