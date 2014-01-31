class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
    can :access, :rails_admin   # grant access to rails_admin
    can :dashboard              # grant access to the dashboard
    

    if user.is_admin
        can :manage, :all
    else
        can :read, Contact, :user_id => user.id
        can :edit, Contact, :user_id => user.id
        can :new, Contact
        can :export, Contact, :user_id => user.id
        can :show, Contact, :user_id => user.id
        can :upload_contacts, Contact
        can :bulk_delete, Contact
        can :export, Contact, :user_id =>  user.id
        can :destroy, Contact
        
        can :read, User, :id => user.id
        can :edit, User, :id => user.id
        

        can :read, Renewal, :user_id => user.id
        can :new, Renewal
        can :export, Renewal, :user_id => user.id
        can :show, Renewal, :user_id => user.id    
        can :send_renewals, Renewal
        can :upload_renewals, Renewal
        can :destroy, Renewal
        can :history, Renewal  



        can :read, Url, :user_id => user.id
        can :edit, Url, :user_id => user.id
        can :new, Url  
        can :export, Url, :user_id => user.id
        can :show, Url, :user_id => user.id    
        can :destroy, Url
        can :history, Url
        can :send_link, Url, :user_id => user.id 

    end    
  end
end
