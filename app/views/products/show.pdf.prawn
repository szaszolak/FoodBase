pdf.font_families.update(
 "DejaVu" => { :bold        => "fonts/dejavu-sans/DejaVuSans-Bold.ttf",
                         :normal      => "fonts/dejavu-sans/DejaVuSans.ttf" })
pdf.font "DejaVu"
pdf.text "Produkt: "+@product.name

move_down 20
@product.samples.each do |sample|
pdf.text sample.additive.name + " " +sample.amount.to_s+" %"
data = [sample.metrics.uniq{|m| m.name}.collect{|x| x.name}]
if sample.product.repetitions && sample.product.repetitions >=1
			(1..sample.product.repetitions).each do |i|
				
					data.push(sample.sensory_analyses.where(repetition_id: i).map{|x|x.value})
					
				
			end
		end
pdf.table(data,:header=>true)
move_down 20
end
@charts.each do |chart|
pdf.image "app/assets/images/"+chart
end