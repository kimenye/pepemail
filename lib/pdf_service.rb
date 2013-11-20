require 'prawn'

# I am sure there is a better way
require 'active_support/core_ext/integer/inflections'
t = Time.new
# day_ord = t.day.ordinalize
# @current_date = t.strftime("#{day_ord} / %B / %Y")
@current_date = "#{t.day.ordinalize} / #{t.strftime("%B / %Y")}"
#

email_title = @email_title
user_address = @user_address #Address of the pepemail user eg AON
user_logo = @user_logo # users logo eg AON
user_sales = @user_sales #email addresses for their sales agents default value is default company email
client_name = @client_name #client is who the company is sending the pdf to
client_postal_address = @client_postal_address
client_email = @client_email
car_reg = @car_reg
car_value = @car_value
renewal_date = @renewal_date
exp_date = @exp_date
scope_cover = @scope_cover

def generate email_title = "You can add a title", user_address = "", user_logo = "logo", user_sales = "default", client_name = "John Doe", client_postal_address = "12345 Nairobi", client_email = "", car_reg = "", car_value = "500 000", renewal_date = "(As per current policy)", exp_date = "1/2/13", scope_cover = "COMPREHENSIVE"
  Prawn::Document.generate('attachment.pdf') do |pdf|
    pdf.image "logo.png", :scale => 0.7, :vposition => 0, :position => :left

    pdf.bounding_box([290, pdf.cursor+60], :width => 250) do
      # pdf.stroke_bounds
      pdf.text "Aon Kenya Insurance Brokers Limited - Personal Lines Division", :align => :right, :size => 9, :vposition => 0
      pdf.text "Aon Minet House, Off Nyerere road", :align => :right, :size => 9
      pdf.text "P. O. Box 48279 00100 GPO Nairobi, Kenya", :align => :right, :size => 9
      pdf.text "Tel.: 254 020 4974000/5000 Cell: 0722 612948, 0733 617500", :align => :right, :size => 9
      pdf.text "Fax: 254 020 2722740 / 2722574", :align => :right, :size => 9
      pdf.formatted_text [
        {:text => "Email: ", :styles => [:italic] },
        {:text => @user_sales, :color => "0000FF", :link => "mailto:@user_sales" },
        {:text => " Web: ", :styles => [:italic] },
        {:text => "www.aon.com/ke/en", :color => "ff0000", :link => "http://www.aon.com/ke/en"}
        ], :align => :right, :size => 9
    end

    pdf.pad(8) { pdf.text "#{@current_date}", :size => 9 }
    pdf.text @client_name, :size => 9
    pdf.text "P.O Box 30589", :size => 9
    pdf.text "NAIROBI", :size => 9

    pdf.pad(6) { pdf.text "Dear #{@client_name},", :size => 9 }
    pdf.pad(6) { pdf.formatted_text [{ :text => "#{@email_title} - #{@current_date}", :size => 10, :styles => [:bold, :underline], :lead => 5}] }

    pdf.text "We write to invite renewal of your vehicle detailed below: ", :size => 9
    pdf.move_down 5

    summary = [
      ["<color rgb='FFFFFF'>REG NO:   #{@car_reg}/color>" , "<color rgb='FFFFFF'>SCOPE OF COVER: #{@scope_cover}</color>"],
      ["VALUE     KSHS. #{@car_value}" , ""],
      ["<color rgb='FFFFFF'>RENEWAL DATE #{@renewal_date}</color>" , "<color rgb='FFFFFF'>NEW EXPIRY DATE: #{@exp_date}</color>"],
    ]

    pdf.table summary, :cell_style => { :inline_format => true, :size => 8 }, :width => 530, :column_widths => [265, 265] do
      row(0).background_color = "C70005"
      # row(0).color = "C70005"
      row(2).background_color = "C70005"
      row(0).border_color = "FFFFFF"
      row(1).border_color = "FFFFFF"
      row(2).border_color = "FFFFFF"
    end

    pdf.move_down 10

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

    pdf.move_down 5
    pdf.text "-   Aon Head Office located at AON Minet House on Mamlaka Hill off Nyerere Road. Call 4974521/33", :size => 9, :indent_paragraphs => 20
    pdf.move_down 5
    pdf.text "-   Aon Town office located in City Center, Jubilee House, Ground Floor, Mama Ngina/Gen. Kago roads Junction. Call 4974516", :size => 9, :indent_paragraphs => 20
    pdf.move_down 5
    pdf.text "-   Aon Nakumatt Mega office located at Nakumatt Mega on Uhuru Highway. Call 4974540", :size => 9, :indent_paragraphs => 20

    pdf.move_down 5
    pdf.text  "Kindly avail copies of your National ID, vehicle logbook and PIN certificate at renewal.", :size => 9
    pdf.move_down 10
    pdf.text  "Yours Faithfully,", :size => 9
    pdf.image "signature.jpg"
    pdf.formatted_text [{:text => "Carolyne KIoria | Account Manager - Affinity Department", :styles => [:bold]}], :size => 9
  end
end

generate @client_name = "John Gitau", @user_sales = "new@email.address", @car_value = 500000, @email_title = "What is this"

#