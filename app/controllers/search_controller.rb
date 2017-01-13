class SearchController < ApplicationController
	after_action :authenticate_user!

  def common
  	@notes = Note.es.search(params[:query]).results
  	self_or_public_access(@notes)
  end

  def user_notes
  	@notes = []
  	aux_notes = Note.es.search(params[:query]).results
  	aux_notes.each do |note|
  		@notes << note if note.user == current_user
  	end
  end

  private
  def self_or_public_access(results = [])
  	results.each do |result|
  		if result.instance_of? Note
  			render :unauthorized_page unless result.privacy == "public" || result.user == current_user
  		end
  	end
  end
end
