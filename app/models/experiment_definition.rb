class ExperimentDefinition < ActiveRecord::Base
  belongs_to :product
  belongs_to :metric
  
  validates :product_id, :metric_id , presence: true
  validates_uniqueness_of :metric_id, :scope => :product_id
end
