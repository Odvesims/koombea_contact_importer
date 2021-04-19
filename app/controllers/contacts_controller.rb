class ContactsController < ApplicationController
  before_action :authenticate_user!

  def index
    @contacts = Contact.where("user_id = #{current_user.id}").paginate(:page => params[:page], :per_page => 30)
  end

end