require 'prawn'

class AttachmentService
	def self.generate_pdf renewal
		doc = Prawn::Document.new do |pdf|
			pdf.image "#{Rails.root}/app/assets/images/aon.png", :scale => 0.4, :vposition => 0, :position => :left
			pdf.bounding_box([290, pdf.cursor+60], :width => 275) do
		      # pdf.stroke_bounds
		      pdf.text "Aon Kenya Insurance Brokers Limited - Personal Lines Division", :align => :right, :size => 9, :vposition => 0
		      pdf.text "Aon Minet House, Off Nyerere road", :align => :right, :size => 9
		      pdf.text "P. O. Box 48279 00100 GPO Nairobi, Kenya", :align => :right, :size => 9
		      pdf.text "Tel.: 254 020 4974000/5000 Cell: 0722 612948, 0733 617500", :align => :right, :size => 9
		      pdf.text "Fax: 254 020 2722740 / 2722574", :align => :right, :size => 9
		      pdf.formatted_text [ 
		        {:text => "Email: ", :styles => [:italic] },
		        {:text => "pld@aon.co.ke", :color => "0000FF", :link => "mailto:pld@aon.co.ke" },
		        {:text => " Web: ", :styles => [:italic] },
		        {:text => "www.aon.com/ke/en", :color => "0000FF", :link => "http://www.aon.com/ke/en"}
		        ], :align => :right, :size => 7
		    end

	        pdf.pad(8) { pdf.text Time.now.strftime("#{Time.now.day.ordinalize} %b %Y"), :size => 9 }  
		    pdf.text "#{renewal.first_name} #{renewal.last_name}", :size => 9  
    		pdf.text "P.O Box 30589", :size => 9
    		pdf.text "NAIROBI", :size => 9

    		pdf.pad(6) { pdf.text "Dear  customer,", :size => 9 }
		    pdf.pad(6) { pdf.formatted_text [{ :text => "RE: #{renewal.expiry_date.year} MOTOR INSURANCE RENEWAL- #{renewal.renewal_date.strftime("%d %b %Y")}", :size => 10, :styles => [:bold, :underline], :lead => 5}] }

		    pdf.text "We write to invite renewal of your vehicle detailed below: ", :size => 9 
		    pdf.move_down 3  

		    summary = [
		      ["<color rgb='FFFFFF'>REG NO:   #{renewal.registration_number}</color>" , "<color rgb='FFFFFF'>SCOPE OF COVER: #{renewal.renewal_type}</color>"],
		      ["VALUE     KSHS. #{renewal.value.to_s}" , ""],
		      ["<color rgb='FFFFFF'>RENEWAL DATE: #{renewal.renewal_date.strftime("%d %b %Y")}</color>" , "<color rgb='FFFFFF'>NEW EXPIRY DATE: #{renewal.expiry_date.strftime("%d %b %Y")}</color>"],
		    ]  

		    pdf.table summary, :cell_style => { :inline_format => true, :size => 8 }, :width => 530, :column_widths => [265, 265] do
		      row(0).background_color = "C70005"
		      # row(0).color = "C70005"
		      row(2).background_color = "C70005"
		      row(0).border_color = "FFFFFF"
		      row(1).border_color = "FFFFFF"
		      row(2).border_color = "FFFFFF"
		    end

		    pdf.move_down 5

		    pdf.pad(6) { pdf.formatted_text [{ :text => "RENEWAL PREMIUM COMPUTATION", :size => 9, :styles => [:bold, :underline], :lead => 5}] }
		      
		    data = [
		      ["<b>COVER</b>", "<b>PREMIUM</b>"],
		      ["Basic premium pro rated including political violence riot and strike", "29750"],
		      ["Excess Protector - Optional", "1750"],
		      ["Additional loss of use for 10 days - optional", "3000"],
		      ["Auto Assured Rescue- optional", "5800"],
		      ["Levies", "439"],
		      ["Total premium", "40739"],
		      ["<b>Benefits</b>", ""],
		      ["No excess payment in the event of an accident", ""],
		      ["Loss of use for up to 10 days @ 3,000/per day", "Inclusive"],
		      ["Personal Accident cover for an authorized driver up to a limit of up to 250,000/=", "Inclusive"],
		      ["Third Party Property Damage - up to 20 million", "Inclusive"],
		      ["Passenger Legal Liability - up to kshs. 5 million per person and 50 million per event", "Inclusive"],
		      ["Loss of use for up to 10 days @ 3,000/per day", "Inclusive"]
		    ]

		    pdf.table data, :cell_style => { :inline_format => true, :size => 8 }, :width => 530, :column_widths => [400, 130] 
		    pdf.move_down 10
		    pdf.text "For ease of administration of your account and to enable us serve you better, we have realigned your renewal date and charged the applicable pro rata premium. Your new renewal date is as indicated above.", :size => 9
		    pdf.move_down 5
		    pdf.formatted_text [
		           {:text => "Kindly contact us on email "},
		           {:text => "Edward.Mwenda@aon.co.ke", :color => "0000FF", :styles => [:underline], :link => "mailto:Edward.Mwenda@aon.co.ke" }, {:text => ", "},
		           {:text => "lizza.kawira@aon.co.ke", :color => "0000FF", :styles => [:underline], :link => "mailto:Edward.Mwenda@aon.co.ke" },  {:text => ", "},
		           {:text => "Ebenezer.odeyo@aon.co.ke", :color => "0000FF", :styles => [:underline], :link => "mailto:Ebenezer.odeyo@aon.co.ke" }, {:text => " or "},
		           {:text => "pld@aon.co.ke", :color => "0000FF", :styles => [:underline], :link => "mailto:pld@aon.co.ke" },
		           {:text => " or visit any of the Aon Retail centers listed below:"}
		    ], :size => 9

		    pdf.move_down 3
		    pdf.text "-   Aon Head Office located at AON Minet House on Mamlaka Hill off Nyerere Road. Call 4974521/33", :size => 9, :indent_paragraphs => 20
		    pdf.move_down 3
		    pdf.text "-   Aon Town office located in City Center, Jubilee House, Ground Floor, Mama Ngina/Gen. Kago roads Junction. Call 4974516", :size => 9, :indent_paragraphs => 20
		    pdf.move_down 3
		    pdf.text "-   Aon Nakumatt Mega office located at Nakumatt Mega on Uhuru Highway. Call 4974540", :size => 9, :indent_paragraphs => 20
		    
		    pdf.move_down 3
		    pdf.text  "Kindly avail copies of your National ID, vehicle logbook and PIN certificate at renewal.", :size => 9              
		    pdf.move_down 5
		    pdf.text  "Yours Faithfully,", :size => 9              
		    pdf.image "#{Rails.root}/app/assets/images/signature.jpg"
		    pdf.formatted_text [{:text => "Carolyne Kioria | Account Manager - Affinity Department", :styles => [:bold]}], :size => 9	
		end
		doc
	end

    def self.generate_korient_pdf renewal
		doc = Prawn::Document.new do |pdf|
			pdf.image "#{Rails.root}/app/assets/images/korient.png", :scale => 0.7, :vposition => 0, :position => :left
			pdf.bounding_box([290, pdf.cursor+60], :width => 275) do
		      # pdf.stroke_bounds
		      pdf.text " ", :size => 9
		      pdf.text "Kenya Orient Insurance Limited", :align => :right, :size => 9, :vposition => 9
		      pdf.text "Capitol Hill Towers", :align => :right, :size => 9
		      
		      pdf.text "Tel.: 020 2962000", :align => :right, :size => 9
		      pdf.text " ", :align => :right, :size => 9
		      pdf.formatted_text [ 
		        {:text => " ", :styles => [:italic] },
		        {:text => " ", :color => "0000FF", :link => "#" },
		        {:text => " ", :styles => [:italic] },
		        {:text => " ", :color => "0000FF", :link => "#"}
		        ], :align => :right, :size => 7
		    end

            pdf.text " ", :size => 9
	        pdf.pad(8) { pdf.text Time.now.strftime("#{Time.now.day.ordinalize} %b %Y"), :size => 9 }  
		    pdf.text "#{renewal.first_name} #{renewal.last_name}", :size => 9  
    		pdf.text "P.O Box 30589", :size => 9
    		pdf.text "NAIROBI", :size => 9

    		pdf.pad(6) { pdf.text "Dear  customer,", :size => 9 }
		    pdf.pad(6) { pdf.formatted_text [{ :text => "RE: #{renewal.expiry_date.year} #{renewal.product_type.upcase}- #{renewal.renewal_date.strftime("%d %b %Y")}", :size => 10, :styles => [:bold, :underline], :lead => 5}] }

		    pdf.text "We write to invite renewal of your vehicle detailed below: ", :size => 9 
		    pdf.move_down 3  

		    summary = [
		      ["<color rgb='FFFFFF'>REG NO:   #{renewal.registration_number}</color>" , "<color rgb='FFFFFF'>SCOPE OF COVER: #{renewal.renewal_type}</color>"],
		      ["VALUE     KSHS. #{renewal.value.to_s}" , ""],
		      ["<color rgb='FFFFFF'>RENEWAL DATE: #{renewal.renewal_date.strftime("%d %b %Y")}</color>" , "<color rgb='FFFFFF'>NEW EXPIRY DATE: #{renewal.expiry_date.strftime("%d %b %Y")}</color>"],
		    ]  

		    pdf.table summary, :cell_style => { :inline_format => true, :size => 8 }, :width => 530, :column_widths => [265, 265] do
		      row(0).background_color = "C70005"
		      # row(0).color = "C70005"
		      row(2).background_color = "C70005"
		      row(0).border_color = "FFFFFF"
		      row(1).border_color = "FFFFFF"
		      row(2).border_color = "FFFFFF"
		    end

		    pdf.move_down 5

		    pdf.pad(6) { pdf.formatted_text [{ :text => "RENEWAL PREMIUM COMPUTATION", :size => 9, :styles => [:bold, :underline], :lead => 5}] }
		      
		    data = [
		      ["<b>COVER</b>", "<b>PREMIUM</b>"],
		      ["Basic premium pro rated including political violence riot and strike", "29750"],
		      ["Excess Protector - Optional", "1750"],
		      ["Additional loss of use for 10 days - optional", "3000"],
		      ["Auto Assured Rescue- optional", "5800"],
		      ["Levies", "439"],
		      ["Total premium", "40739"],
		      ["<b>Benefits</b>", ""],
		      ["No excess payment in the event of an accident", ""],
		      ["Loss of use for up to 10 days @ 3,000/per day", "Inclusive"],
		      ["Personal Accident cover for an authorized driver up to a limit of up to 250,000/=", "Inclusive"],
		      ["Third Party Property Damage - up to 20 million", "Inclusive"],
		      ["Passenger Legal Liability - up to kshs. 5 million per person and 50 million per event", "Inclusive"],
		      ["Loss of use for up to 10 days @ 3,000/per day", "Inclusive"]
		    ]

		    pdf.table data, :cell_style => { :inline_format => true, :size => 8 }, :width => 530, :column_widths => [400, 130] 
		    pdf.move_down 10
		    pdf.text "For ease of administration of your account and to enable us serve you better, we have realigned your renewal date and charged the applicable pro rata premium. Your new renewal date is as indicated above.", :size => 9
		    pdf.move_down 5
		    pdf.formatted_text [
		           {:text => "Kindly contact us on email "},
		           {:text => "Mariam@korient.co.ke", :color => "0000FF", :styles => [:underline], :link => "mailto:Mariam@korient.co.ke" }, {:text => ", "},
		           {:text => " or visit our office:"}
		    ], :size => 9

		    pdf.move_down 3
		    pdf.text "-   Kenya Orient Insurance Limited Headquarters, Capitol Hill, 6th Floor. Call 020 2962000", :size => 9, :indent_paragraphs => 20
		    
		    
		    pdf.move_down 3
		    pdf.text  "Kindly avail copies of your National ID, vehicle logbook and PIN certificate at renewal.", :size => 9              
		    pdf.move_down 5
		    pdf.text  "Yours Faithfully,", :size => 9              
		    pdf.image "#{Rails.root}/app/assets/images/signature.jpg"
		    pdf.formatted_text [{:text => "Mariam Ahmed | Customer Experience  Manager", :styles => [:bold]}], :size => 9	
		end
		doc
	end
end
