class ResponsesController < ApplicationController
  before_action :require_user, only: [:create, :update]

  def create
    @question = Question.find(params[:question_id])
    response = @question.responses.new(response_params)
    response.user_id = current_user.id
    if response.save
      respond_to do |format|
        format.html do
          flash[:notice] = "Answer Successfully Added!"
        end
        format.js
      end
    else
      flash[:alert] = "There was a problem submitting your answer"
      redirect_to :back
    end
  end

  def update
    response = Response.find(params[:id])

    if params[:response][:best]
      Response.all.each do |r|
        unless r == response
          r.best = false
          r.save
        end
      end
    end
    response.update(response_params)
    redirect_to user_path(current_user)
  end

  def vote
    @response = Response.find(params[:id])
    @vote = Vote.create(voteable: @response, vote: params[:vote], user_id: current_user.id)
    respond_to do |format|
      format.html do
        @vote.valid? ? flash[:notice] = 'Your vote was counted.' :  flash[:error] = 'You can only vote on a post once.'
        redirect_to :back
      end
      format.js
    end
  end

  private
  def response_params
    params.require(:response).permit(:answer, :best)
  end



end
