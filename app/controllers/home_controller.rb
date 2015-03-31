class HomeController <ApplicationController
  def index
    redirect_to questions_path if logged_in?
  end

end
