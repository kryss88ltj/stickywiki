 class WikiPolicy

  attr_reader :user, :wiki

  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end

  def index?
    true
  end

  def new?
    !!user
  end

  def edit?
    !!user
  end


  def create?
    !!user #returns true if user ISNT nil
    #user.nil? (returns true if user is nil)
  end

  def destroy?
    !!user
  end
  
  def owned?
    if user
      user.id == wiki.user_id
    else
      false
    end    
  end
  
end

