font_families.update(
 "DejaVu" => { :bold => "fonts/dejavu-sans/DejaVuSans-Bold.ttf",
                :normal => "fonts/dejavu-sans/DejaVuSans.ttf" })

font "DejaVu"

text "Produkt: "+@product.name,align: :center, style: :bold, size: 24
move_down 5



text "Mierzone cechy:" , style: :bold
move_down 2
@product.metrics.uniq{|m| m.id }.collect {|metric| metric.name}.each do|metric|

  #create a bounding box for the list-item label
  #float it so that the cursor doesn't move down
  float do
    bounding_box [15,cursor], :width => 10 do
      text "•"
    end
  end

  #create a bounding box for the list-item content
  bounding_box [25,cursor], :width => 600 do
    text metric
  end

  #provide a space between list-items
  move_down(5)
end

text "Receptura" , style: :bold
move_down 5
text "Składniki:"
move_down 2
@product.recipes.eager_load(:ingredient).each do|recipe|

  #create a bounding box for the list-item label
  #float it so that the cursor doesn't move down
  float do
    bounding_box [15,cursor], :width => 10 do
      text "•"
    end
  end

  #create a bounding box for the list-item content
  bounding_box [25,cursor], :width => 600 do
    text recipe.ingredient.name+" " +recipe.amount.to_s + "g"
  end

  #provide a space between list-items
  move_down(5)
end


text "Opis:",style: :bold
text @product.description

move_down 20
@product.experiment_definitions.each do |definition|
text "Metryka: "+definition.metric.try(:name) ,:align => :center, style: :bold
text "Serie: "+definition.series.to_s
text "Powtórzenia: "+definition.repetitions.to_s
samples = @product.samples_with_metric(definition.metric_id).distinct

headers = []
values = {}

(1..definition.series).each do |serie|
 values[serie] = []
    (0..definition.repetitions-1).each do |repetition|
          values[serie][repetition]=[]
     end
  end 

samples.each do |sample|
  headers<<sample.additive.try(:name)+" "+sample.amount.to_s+"%"

  (1..definition.series).each do |serie|
    (1..definition.repetitions).each do |repetition|
       analysis = sample.sensory_analyses.where("repetition_id=? AND serie_id=?",repetition,serie).first
      

         if analysis and analysis.value
          values[serie][repetition-1]<<analysis.value
         else
          values[serie][repetition-1]<<"-"
         end
     
     end
  end 
end
data=[headers]
values.each_with_index do |serie,i|
  data<<[{:content=>"seria "+(i+1).to_s,:colspan=>headers.size,:background_color => "66FF66"}]
  serie[1].each do |value|
    data<<value
  end
end
table(data,
:header=>true,
:position=>:center)do |t|
	t.row(0).background_color = "d6d6c2"
end
move_down 20
end
@charts.each do |chart|
image "app/assets/images/"+chart,:position => :center
end