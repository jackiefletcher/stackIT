class Response < ActiveRecord::Base
  validates :answer, :presence => true
  belongs_to :question
  belongs_to :user
  has_many :votes, as: :voteable
  after_create :send_notification
  default_scope { order('best DESC')}

  def send_notification
    UserMailer.response_notification(self.question.user).deliver_now
  end

  def up_votes
    self.votes.where(vote: true).size
  end

  def down_votes
    self.votes.where(vote: false).size
  end

  def total_votes
    up_votes - down_votes
  end

end
