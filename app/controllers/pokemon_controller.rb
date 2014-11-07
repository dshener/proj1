class PokemonController < ApplicationController
	def new
	end

	def create
		puts 5
    	@pokemon = Pokemon.new(pokemon_params)
    	@pokemon.health = 100
    	@pokemon.level = 1
    	@pokemon.trainer_id = current_trainer.id
    	if @pokemon.valid?
    		@pokemon.save
      		redirect_to trainer_path(id: current_trainer.id)
    	else
      		flash[:error] = @pokemon.errors.full_messages.to_sentence
      		redirect_to new_pokemon_path
    	end
  	end

	def capture
		@pokemon = Pokemon.find(params[:id])
		if @pokemon.update_attribute(:trainer_id, current_trainer.id)
			redirect_to root_path
		end
	end

	def damage
    	@pokemon = Pokemon.find(params[:id])
		@pokemon.update_attribute(:health, @pokemon.health-10)
		if @pokemon.health<=0
			@pokemon.destroy
		end
		redirect_to trainer_path(current_trainer.id)
	end

	private

  	def pokemon_params
    	params.require(:pokemon).permit(:name, :level, :health, :trainer_id)
  	end
end
