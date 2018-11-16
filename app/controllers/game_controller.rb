class GameController < ApplicationController
  before_action :set_info, only: :results

  def index
    session[:game] = {}
  end

  def results
    current_version = session[:game]
    result = {}
    unless current_version.key(@info[:id])
      current_version[@info[:id].to_sym] = current_version.keys.count.odd? ? 'O' : 'X'
      session[:game] = current_version
      result[:value] = current_version[@info[:id].to_sym]
      result[:win] = check_winner
    end
    render json: result
  end

  private

  def set_info
    @info = params.permit(:id)
  end

  def check_winner
    [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]].each do |comb|
      return true if check_combination(comb)
    end
    false
  end

  def check_combination(comb)
    values = session[:game].select{ |k,v| comb.include?(k.to_s.to_i) }.values
    values.length == 3 && values.uniq.length == 1
  end

end
