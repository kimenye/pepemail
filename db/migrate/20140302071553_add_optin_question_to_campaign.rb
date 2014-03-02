class AddOptinQuestionToCampaign < ActiveRecord::Migration
  def change
    add_column :campaigns, :optin_question, :text
  end
end
