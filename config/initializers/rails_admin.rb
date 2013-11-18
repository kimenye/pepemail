RailsAdmin.config do |config|
	config.actions do
		dashboard
		index
    	new
    	show
    	edit
    	delete
		
		collection :send_renewals do
			register_instance_option :link_icon do
          		'icon-envelope-alt'
        	end
			register_instance_option :visible? do
				bindings[:abstract_model].to_s == "Renewal"
			end
		end

		collection :upload_renewals do
			register_instance_option :link_icon do
				'icon-upload'
			end

			register_instance_option :visible? do
				bindings[:abstract_model].to_s == "Renewal"
			end

			register_instance_option :http_methods do
			    [:get, :post]
			end

			register_instance_option :pjax? do
          		false
        	end


			register_instance_option :controller do
				Proc.new do
					if params.has_key?(:import_file)
						doc = SimpleXlsxReader.open(params[:import_file].tempfile)
        
    					main_sheet = doc.sheets.first
    					count = 0
    					main_sheet.rows[1..main_sheet.rows.length].each do |row|      
    						renewal = Renewal.create! :first_name => row[0], :last_name => row[1],
    							:postal_address => row[2], :city => row[3], :ref => row[7], :mobile_number => row[5],
    							:email_address => row[6], :value => row[8], :registration_number => row[9],
    							:renewal_date => row[10], :expiry_date => row[11], :amount_due => row[12], :renewal_type => row[13],
    							:computation => row[14] 
    						count += 1
    					end
    					redirect_to back_or_index, notice: "#{count} Renewals imported"
					end
				end
			end
		end
	end
end