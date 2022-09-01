module CurrentWish

  private

    def set_wish
      @wish = Wish.find(session[:wish_id])
    rescue ActiveRecord::RecordNotFound
      @wish = Wish.create
      session[:wish_id] = @wish.id
    end

end