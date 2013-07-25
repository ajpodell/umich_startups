class CompaniesController < ApplicationController
	def create
		@company = current_user.companies.build(params[:company])
		
		if@company.save
			flash[:success] = "Company created"
			redirect_to current_user
		else
			render 'new'
		end
	end

	def new
		@company = current_user.companies.build(params[:company])
	end

end
