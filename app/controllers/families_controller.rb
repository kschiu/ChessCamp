class FamiliesController < ApplicationController
before_action :set_family, only: [:show, :edit, :update, :destroy]

	def create
		@family = Family.new(family_params)
		if @family.save
			redirect_to @family, notice: "#{@family.parent_first_name} was added to the system."
		else
			render action: 'new'
		end
	end

	def new
		@family = Family.new
	end

	def update
		if @family.update(family_params)
			redirect_to @family, notice: "#{@family.parent_first_name} was revised in the system."
		else
			render action: 'edit'
		end
	end

	def destroy
		@family.destroy
		redirect_to families_url, notice: "#{@family.parent_first_name} was removed from the system."
	end

	def index
		@active_families = Family.active.alphabetical.paginate(:page => params[:page]).per_page(10)
		@inactive_families = Family.inactive.alphabetical.paginate(:page => params[:page]).per_page(10)
	end

	def edit
	end

	def show
	end

  	private
    def set_family
    	@family = Family.find(params[:id])
    end

    def family_params
    	params.require(:instructor).permit(:family_name, :parent_first_name, :email, :phone, :active)
    end

end
