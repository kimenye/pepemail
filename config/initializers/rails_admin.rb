RailsAdmin.config do |config|
	config.authorize_with :cancan
	config.excluded_models << Item
	config.excluded_models << Photo
	# config.excluded_models << CampaignOptIn
	# config.excluded_models << Visit
	config.excluded_models << Renewal


	config.model 'Contact' do
		edit do
			field :name
			field :email
			field :phone_number
			field :source

			field :user_id, :hidden do
		    	default_value do
		        	bindings[:view]._current_user.id
		      	end
		    end
		end

		export do
			field :name
			field :email
			field :phone_number
			field :source
		end
	end

	config.model 'Campaign' do
		edit do
			field :name
			field :start_date
			field :end_date
			field :tagline do 
				label "Opt In Message"
			end
			field :optin_question
			field :description do
				label "Main Message"
			end
			field :background_color
			field :hero  do
				label "Key Visual"
			end
		end
	end

	config.model 'Url' do
		edit do
			field :title
			field :from
			field :to
			field :message
			field :num_clicks
			field :success_url
			field :expired_url
			field :user_id, :hidden do
				default_value do
					binding[:view]._current_user.id
				end
			end
		end
	end

	config.model 'Renewal' do
		edit do			
			field :first_name
			field :last_name
			field :postal_address
			field :city
			field :mobile_number
			field :ref
			field :computation
			field :registration_number
			field :amount_due
			field :expiry_date
			field :renewal_date
			field :renewal_type
			field :value
			field :user_id, :hidden do
		    	default_value do
		        	bindings[:view]._current_user.id
		      	end
		    end
		end
	end

	config.actions do
		dashboard
		index
    	new
    	show
    	edit
    	delete
    	export
    	bulk_delete

    	member :launch_campaign do
    		register_instance_option :link_icon  do
    			'icon-envelope-alt'
    		end

    		register_instance_option :visible? do
				bindings[:abstract_model].to_s == "Campaign"
			end

			register_instance_option :http_methods do
			    [:get, :post]
			end

			register_instance_option :controller do
				Proc.new do
					if params.has_key?(:submit)
						campaign = Campaign.find_by_id(params[:id]) 
						count = CampaignService.launch_campaign campaign, current_user.id
						redirect_to back_or_index, notice: "Campaign launched"
					else
						render "launch_campaign"
					end
				end
			end
    	end

		collection :send_renewals do
			register_instance_option :link_icon do
          		'icon-envelope-alt'
        	end
			register_instance_option :visible? do
				bindings[:abstract_model].to_s == "Renewal"
			end

			register_instance_option :http_methods do
			    [:get, :post]
			end

			register_instance_option :controller do
				Proc.new do
					if params.has_key?(:submit)
						count = RenewalService.send_renewals
						redirect_to back_or_index, notice: "#{count} Renewals sent"
					else
						render "send_renewals"
					end
				end
			end
		end

		member :send_renewal do
			register_instance_option :visible? do
				bindings[:abstract_model].to_s == "Renewal"
			end

			register_instance_option :link_icon do
				'icon-envelope-alt'
			end

			register_instance_option :http_methods do
				[:get, :post]
			end

			register_instance_option :controller do
				Proc.new do
					if params.has_key?(:submit)
						renewal = Renewal.find_by_id(params[:id]) 
						RenewalService.send_renewal renewal
						redirect_to back_or_index, notice: "Email and SMS sent"
					else
						render "send_renewal"
					end
				end
			end				
		end

		member :send_link do
			register_instance_option :visible?  do
				bindings[:abstract_model].to_s == "Url"
			end
			
			register_instance_option :link_icon do
				'icon-share-alt'
			end

			register_instance_option :http_methods do
				[:get, :post]
			end

			register_instance_option :controller do
				Proc.new do
					if params.has_key?(:submit)
						url = Url.find_by_id(params[:id])
						contacts = Contact.where(user_id: current_user.id).to_a
						contacts.each do |contact|
							SmsService.send_link contact, url
						end
						redirect_to back_or_index, notice: "Link sent to #{contacts.count} contacts"
					else
						render "send_link"
					end
				end
			end
		end

		collection :upload_contacts do
			register_instance_option :link_icon do
				'icon-upload'
			end

			register_instance_option :visible? do
				bindings[:abstract_model].to_s == "Contact"
			end

			register_instance_option :http_methods do
				[:get, :post]
			end

			register_instance_option :pjax? do
				true
			end

			register_instance_option :controller do
				Proc.new do
					if params.has_key?(:import_file)
						doc = SimpleXlsxReader.open(params[:import_file].tempfile)
						main_sheet = doc.sheets.first
						count = 0
						errors = 0
						curr_user = User.find(current_user.id)
						
						main_sheet.rows[1..main_sheet.rows.length].each do |row|
							contact = Contact.new :user => curr_user, :name => row[0],
								:email => row[2], :source => row[3], :phone_number => PhoneConverter.convert(row[1])

							if contact.valid?
								contact.save!
								count += 1
							else
								errors += 1
							end
						end

						redirect_to back_or_index, notice: "#{count} Contacts imported. #{errors} Contacts skipped."
					end
				end
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
          		true
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
    							:computation => row[14], :user_id => current_user.id
    						count += 1
    					end
    					redirect_to back_or_index, notice: "#{count} Renewals imported"
					end
				end
			end
		end
	end
end