class FailedContactsController < ApplicationController
  before_action :authenticate_user!

  def index
    @contacts = FailedContact.where(:user_id => current_user.id).paginate(:page => params[:page]).order('id DESC')
  end

end