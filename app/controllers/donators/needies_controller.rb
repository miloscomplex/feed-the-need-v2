class Donators::NeediesController < ApplicationController

  def index
    @needies = Needy.all
  end

  def show
    @needy = Needy.find_by(id: params[:needy_id])
  end

end
