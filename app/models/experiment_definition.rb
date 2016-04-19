class ExperimentDefinition < ActiveRecord::Base
  belongs_to :product
  belongs_to :metric
  
  validates_numericality_of :series, greater_than: 0, :only_integer
  validates_numericality_of :repetitions, greater_than: 0, :only_integer

  validates :product_id, :metric_id , presence: true
  validates_uniqueness_of :metric_id, :scope => :product_id
end
