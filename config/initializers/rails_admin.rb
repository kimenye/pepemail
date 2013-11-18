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

			register_instance_option :controller do
				Proc.new do
					binding.pry
					redirect_to back_or_index
				end
			end
		end
	end
end