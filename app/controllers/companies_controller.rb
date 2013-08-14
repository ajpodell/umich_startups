class CompaniesController < ApplicationController

	def create
		# @company = current_user.companies.build(params[:company])
		@company = current_user.companies.build(company_params)
		@company.title = @company.title.titleize
		
		if @company.save && current_user.join_company!(@company)
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
		#should automatically destroy memberships
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
		if company.update_attributes(company_params)
			unless current_user.member?(company)
				current_user.join_company!(company)
			end
	        flash[:success] = "Company updated"
	        redirect_to current_user
	    else
	        render 'edit'
	    end
	end

	private
		def company_params
			params.require(:company).permit(:title, :user_id, :creator, :description, :mission)
		end

end
