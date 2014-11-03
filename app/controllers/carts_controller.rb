class CartsController < ApplicationController
  def show
    session[:return_to] = new_order_path
    @addresses = Address.where(user_id: session[:id])
    if cart.items.any?
    @subtotal = Cart.subtotal(session)
    @tax = Cart.tax(session)
    @total = Cart.total(session)
    end
  end

  def add_item
    cart.add_item(params[:item_id])
    redirect_to categories_path
  end

  def remove_item
    cart.remove_item(params[:item_id])
    redirect_to cart_path
  end

  def update_quantity
    cart.update_quantity(params[:item_id], params[:quantity].to_i)
    redirect_to cart_path
  end
end
