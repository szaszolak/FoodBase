json.array!(@sensory_analyses) do |sensory_analysis|
  json.extract! sensory_analysis, :id, :color_L, :color_A, :color_B, :cutting_strength, :fat, :humidity
  json.url sensory_analysis_url(sensory_analysis, format: :json)
end
