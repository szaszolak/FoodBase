class Sample < ActiveRecord::Base
	belongs_to :product
	belongs_to :additive
	belongs_to :medium

	has_many :sensory_analyses, dependent: :destroy
	has_many :metrics, through: :sensory_analyses


end
