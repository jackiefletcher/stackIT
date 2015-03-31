class ResponsesController < ApplicationController
  before_action :require_user, only: [:create, :update]

  def create
    question = Question.find(params[:question_id])
    response = question.responses.new(response_params)
    response.user_id = current_user.id
    if response.save
      flash[:notice] = "Answer Successfully Added!"
    else
      flash[:alert] = "There was a problem submitting your answer"
    end
    redirect_to :back
  end

  def update
    response = Response.find(params[:id])
    response.update(response_params)
    response.save
    redirect_to user_path(current_user)
  end

  private
  def response_params
    params.require(:response).permit(:answer, :best)
  end

end
