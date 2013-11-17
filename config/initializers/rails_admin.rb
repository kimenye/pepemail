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
		end

		collection :upload_renewals do
			register_instance_option :link_icon do
				'icon-upload'
			end

			register_instance_option :visible? do
				binding.pry
			end
		end
	end
end