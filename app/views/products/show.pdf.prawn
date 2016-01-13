font_families.update(
 "DejaVu" => { :bold => "fonts/dejavu-sans/DejaVuSans-Bold.ttf",
                :normal => "fonts/dejavu-sans/DejaVuSans.ttf" })

font "DejaVu"

text "Produkt: "+@product.name,align: :center, style: :bold, size: 24
move_down 5

text "Próbki: "+@product.samples_count.to_s
text "Powtórzenia: "+@product.repetitions.to_s
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
@product.samples.each do |sample|
text "Próbka: "+sample.additive.name + " " +sample.amount.to_s+" %",:align => :center, style: :bold
text "Temperatura smażenia: " +sample.temperature.to_s + "\uc2b0C",:align => :center
data = [sample.metrics.uniq{|m| m.name}.collect{|x| x.name}]
if sample.product.repetitions && sample.product.repetitions >=1
			(1..sample.product.repetitions).each do |i|
				
					data.push(sample.sensory_analyses.where(repetition_id: i).map{|x|x.value})
					
				
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