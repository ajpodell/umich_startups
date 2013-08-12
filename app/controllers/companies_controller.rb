class CompaniesController < ApplicationController
	def create
		# @company = current_user.companies.build(params[:company])
		@company = current_user.companies.build(company_params)
		
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

	def destroy
		company = Company.find(params[:id])
		company.destroy
		flash[:success] = "#{company.title} has been deleted"
		redirect_to current_user
	end

	def edit 
		@company = Company.find(params[:id])
	end

	def update
		company = Company.find(params[:id])
		if company.update_attributes(params[:company])
	        flash[:success] = "Company updated"
	        redirect_to current_user
	    else
	        render 'edit'
	    end
	end

	private
		def company_params
			params.require(:company).permit(:title, :user_id, :description, :mission)
		end

end
