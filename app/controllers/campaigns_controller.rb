class CampaignsController < ApplicationController
  layout "mobile"
  has_mobile_fu false
  # before_filter :authenticate_user!

  # GET /campaigns
  # GET /campaigns.json
  def index
    @campaigns = Campaign.joins('inner join items on items.id = campaigns.item_id').where('items.user_id = ?',current_user.id)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @campaigns }
    end
  end

  def preview
    @campaign = Campaign.find(params[:id])
    render :preview, :layout => "public"
  end

  # GET /campaigns/1
  # GET /campaigns/1.json
  def show
    @campaign = Campaign.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @campaign }
    end
  end

  # GET /campaigns/new
  # GET /campaigns/new.json
  def new
    @campaign = Campaign.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @campaign }
    end
  end

  # GET /campaigns/1/edit
  def edit
    @campaign = Campaign.find(params[:id])
  end

  def opt_in
    @opt_in = CampaignOptIn.find_by_request_hash(params[:id])
    if !@opt_in.is_expired?
      @opt_in.user_agent = request.user_agent
      @opt_in.ip_address = request.remote_ip

      # set a cookie with the phone number, and user agent and time
      @opt_in.cookie_hash = Digest::MD5.hexdigest("#{@opt_in.contact.phone_number}#{@opt_in.campaign.id}#{@opt_in.user_agent}")
      cookies[:opt_in_secret] = @opt_in.cookie_hash

      @opt_in.counter += 1
      @opt_in.save!
    end
  end

  def decision    
    @opt_in = CampaignOptIn.find_by_request_hash(params[:id])
    if !@opt_in.decided
      if params.has_key?(:agree)
        @opt_in.opted_in = true
        @opt_in.decided = true
        CampaignService.send_key_visual @opt_in
      else
        @opt_in.opted_in = false
        @opt_in.decided = true
      end
      @opt_in.save!
    end
  end

  def mms
    @opt_in = CampaignOptIn.find_by_request_hash(params[:id])
    if @opt_in.is_consumed?
      render "consumed"
    else
      binding.pry
      secret = request.cookies["opt_in_secret"]
      check = Digest::MD5.hexdigest("#{@opt_in.contact.phone_number}#{@opt_in.campaign.id}#{@opt_in.user_agent}")
      if secret == check
        @opt_in.viewed = true
        @opt_in.view_counter += 1
        @opt_in.save!

        render 'visual'
      else
        render 'consumed'
      end
    end
  end

  # POST /campaigns
  # POST /campaigns.json
  def create
    @campaign = Campaign.new(params[:campaign])

    respond_to do |format|
      if @campaign.save
        format.html { redirect_to edit_campaign_path(@campaign), notice: 'Campaign was successfully created.' }
        format.json { render json: @campaign, status: :created, location: @campaign }
      else
        format.html { render action: "new" }
        format.json { render json: @campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /campaigns/1
  # PUT /campaigns/1.json
  def update
    @campaign = Campaign.find(params[:id])

    respond_to do |format|
      if @campaign.update_attributes(params[:campaign])
        format.html { redirect_to edit_campaign_path(@campaign), notice: 'Campaign was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /campaigns/1
  # DELETE /campaigns/1.json
  def destroy
    @campaign = Campaign.find(params[:id])
    @campaign.destroy

    respond_to do |format|
      format.html { redirect_to campaigns_url }
      format.json { head :no_content }
    end
  end
end
