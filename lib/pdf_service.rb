#class PdfService
#
#  def generate
#
#  end
#end

require 'prawn'

#
Prawn::Document.generate('attachment.pdf') do |pdf|
  #pdf.text("Hello Prawn!")
  #pdf.bounding_box([100, 300], :width => 300, :height => 200) do
    #pdf.image "logo.png"

    #pdf.rectangle [0, 100], 100, 100
  #end

  pdf.define_grid(:columns => 2, :rows => 6, :gutter => 10)
  # pdf.grid.show_all
  pdf.grid(0,0).bounding_box do
    #add the logo
    pdf.image "logo.png", :scale => 0.7
  end

  pdf.grid(0,1).bounding_box do
    pdf.text "Aon Kenya Insurance Brokers Limited - Personal Lines Division", :align => :right, :size => 9
    pdf.text "Aon Minet House, Off Nyerere road", :align => :right, :size => 9
    pdf.text "P. O. Box 48279 00100 GPO Nairobi, Kenya", :align => :right, :size => 9
    pdf.text "Tel.: 254 020 4974000/5000 Cell: 0722 612948, 0733 617500", :align => :right, :size => 9
    pdf.text "Fax: 254 020 2722740 / 2722574", :align => :right, :size => 9
    # pdf.text "Email: pld@aon.co.ke Website:www.aon.com/ke/en", :align => :right, :size => 9
    pdf.formatted_text [ 
      {:text => "Email: ", :styles => [:italic] },
      {:text => "pld@aon.co.ke", :color => "0000FF", :link => "mailto:pld@aon.co.ke" },
      {:text => " Web: ", :styles => [:italic] },
      {:text => "www.aon.com/ke/en", :color => "0000FF", :link => "http://www.aon.com/ke/en"}
    ], :align => :right, :size => 9
  end

  pdf.grid([1,0],[2,0],[1,1],[2,1]).bounding_box do
    pdf.pad(10) { pdf.text "8th November 2013", :size => 10 }
    
    
    pdf.text "Caroline Kioria", :size => 10
    
    pdf.text "P.O Box 30589", :size => 10
    pdf.text "NAIROBI", :size => 10

    pdf.pad(10) { pdf.text "Dear Customer,", :size => 10 }
    pdf.pad(10) { pdf.formatted_text [{ :text => "RE: 2012 MOTOR INSURANCE RENEWAL- 14-03-2013", :size => 10, :styles => [:bold, :underline], :lead => 5}] }

    pdf.text "We write to invite renewal of your vehicle detailed below: ", :size => 10 
    pdf.move_down 5    
  end

  pdf.grid([3,0],[4,0],[5,0],[3,1],[4,1],[5,1]).bounding_box do
    pdf.pad(10) { pdf.formatted_text [{ :text => "RENEWAL PREMIUM COMPUTATION", :size => 10, :styles => [:bold, :underline], :lead => 5}] }

    
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
    # table.draw
  end

end

