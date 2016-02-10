class ExperimentDefinition < ActiveRecord::Base
  belongs_to :product
  belongs_to :metric
end
