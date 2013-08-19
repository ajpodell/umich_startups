class SkillsController < ApplicationController
	def create
		@new_skill = current_user.skills.build(skill_params)
		if @new_skill.save
			flash[:success] = @new_skill.skill
			redirect_to current_user
		else
			render 'users/add_skill'
		end
	end

	def destroy
		#should automatically destroy memberships
		skill = Skill.find(params[:id])
		skill.destroy
		flash[:success] = "#{skill.skill} has been removed from your profile"
		redirect_to current_user
	end

	private
		def skill_params
			params.require(:skill).permit(:skill, :user_id)
		end
end