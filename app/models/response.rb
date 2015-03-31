class Response < ActiveRecord::Base
  validates :answer, :presence => true
  belongs_to :question
  belongs_to :user
  after_create :send_notification
  default_scope { order('best DESC')}

  def send_notification
    UserMailer.response_notification(self.question.user).deliver_now
  end



end
