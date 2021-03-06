class VotesController < ApplicationController
  skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json'}

  def create
    puts params
    puts params[:vote]
    previous_vote = Vote.where('voter_id = ? AND voteable_id = ? AND voteable_type = ?', params[:vote][:voter_id], params[:vote][:voteable_id], params[:vote][:voteable_type])
    if previous_vote.length > 0
      raise 'You already voted!'
    else
      Vote.create(vote_params)
    end
    logger.info "after the if statement"
    new_number = Vote.where('voteable_id = ? AND voteable_type = ?', params[:vote][:voteable_id], params[:vote][:voteable_type]).count.to_s
    puts 'NEW NUMBER #{new_number}'
    render json: new_number
  end



private

  def vote_params
    params[:thing_id] = params[:thing_id].to_i
    params.require(:vote).permit(:voter_id, :voteable_id, :voteable_type)
  end

end
