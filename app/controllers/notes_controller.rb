class NotesController < ApplicationController
	before_action :authenticate_user!
	before_action :self_access, only: [:update, :delete]
	before_action :self_or_public_access, only: [:show]

	def new
		@note = Note.new
	end
	def index
		@notes = current_user.notes
	end
	def show
		@note = Note.find(params[:id])
		update_params = {visualizations: @note.visualizations + 1}
		update_params[:first_visualization] = Time.now unless @note.visualizations >= 1
		@note.update(update_params)
	end
	def edit
		@note = Note.find(params[:id])
	end
	def update
		@note = Note.find_or_create_by(_id: params[:id])
		if(@note.update(note_params))
			render json: @note.to_json()
		else
			render json: @note.errors.to_json()
		end
	end
	def delete
		@note = Note.find(params[:id])
		@note.destroy

		head :no_content
	end

	private
	def note_params
		p = params.require(:note).permit(:title, :content, :privacy, :status)
		p[:user] = current_user
		return p
	end
	def self_access
		begin
			note = Note.find(params[:id])
		rescue
			# do nothing if we didn't find the resource
		end
		unauthorized_page if note.present? && note.user != current_user
	end
	def self_or_public_access
		note = Note.find(params[:id])
		unauthorized_page unless note.user == current_user || note.privacy == "public"
	end
end
