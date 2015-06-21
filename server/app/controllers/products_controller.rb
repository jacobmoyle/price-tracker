require 'shopsense'

class ProductsController < ApplicationController

  before_action :product_find, only: [:show, :edit, :destroy]

  def index

    client = Shopsense::API.new('partner_id' => 'uid5001-30368749-95')
    response = client.search(params[:search])
    # Search needs to be a parameter that is passed in from the user.
    raw_products = JSON.parse(response)["products"]

    @id = []
    
    @products = raw_products.map do |product|
      @id << product.values[0]
      # This gives us all of the id's of the products returned by the search
    end
    # render json: @id
  end

  #renamed from search to results: showing the results from shopstyle API
  #create custom route for search 
  #specific product 
  #relates to form in html 
  

  def results
    @products = Product.search(params[:search])
  end

  def show
    render json: {product: @product}
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(id: params[:id], shopstyle_id: params[:shopstyle_id])
    if @product.save
      render json: { product: @product }, status: :created
    else
      render json: @product.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
  end

  private

  def product_find
    @product = Product.find(params[:id])
  end

end


