class TelevisitController < ApplicationController
    def create
        # TODO: Create Televisits
    end
    
    def show
        # TODO: Show Televisit
    end

    def end
        # TODO: end a televisit
        render json: {message: 'ended'}
    end

    def destroy
        # TODO: Cancel the televisit
    end
end