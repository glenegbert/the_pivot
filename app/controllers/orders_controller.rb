class OrdersController < ApplicationController
  before_action :authenticate_user
  before_action :set_order, only: [:show]

  def create
    if session[:cart_items].empty?
      redirect_to confirmation_path
    else
      items_by_store_id = session[:cart_items].group_by{|item| Item.find(item[0].to_i).store_id }

      orders = []
      items_by_store_id.each do |store_id, items|
        order = Order.create(user_id: session[:user_id], status: "ordered", store_id: store_id)
        items.map do |item_id, quantity|
          order.order_items.new(item_id: item_id, quantity: quantity)
        end
        order.address_id = params[:address]
        order.save
        orders << order
      end
      ConfirmationMailer.confirmation_email(current_user, orders).deliver
      session[:cart_items] = {}
      redirect_to confirmation_path
    end
  end

  def index
    @orders = current_user.orders
  end

  def new
    @addresses = Address.where(user_id: session[:id])
    if cart.empty?
      redirect_to cart_path, notice: 'Please add items to your cart before checking out. Thank you!'
    else
      @subtotal = Cart.subtotal(session)
      @tax = Cart.tax(session)
      @total = Cart.total(session)
    end
  end

  def show
  end

  def update
  end

  def edit
  end

  private
  def authenticate_user
    unless current_user
      flash[:notice] = 'Please log in or create account to complete order'
      session[:return_to] = cart_path
      redirect_to new_user_path
    end
  end

  def set_order
    if current_user.orders.collect { |order| order.id }.include?(params[:id].to_i)
      @order = current_user.orders.find(params[:id])
    else
      redirect_to :root
    end
  end
end
