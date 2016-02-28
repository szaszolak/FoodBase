class CompareController < ApplicationController
  def index
    get_compared_products
    get_compared_products_metrics
  end

  def show
  end

  private
    def get_compared_products
      ids = JSON.parse(params.require(:competitors_ids))
      @competitors = Product.find(ids)
      @competitors.sort_by! {|x| x.metrics.count}.reverse!
    end

    def get_compared_products_metrics
      @metrics = []
      @competitors.each do |competitor|
      	@metrics+=competitor.metrics
      end

      @metrics = @metrics.uniq
    end
end
