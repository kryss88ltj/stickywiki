class User < ActiveRecord::Base
  has_many :wikis
  has_many :collaborations
  has_one :subscription, :dependent => :destroy
  
  scope :not_current_user, lambda { |user| where.not("id = ?", user.id ) }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  validates :name, presence: true
  after_create :create_a_customer
 
         def create_a_customer
          token = self.stripe_card_token
          
          customer = Stripe::Customer.create(
          :card => token, 
          :email => self.email
          )         
         end       

  def role?(base_role)
    role == base_role.to_s
  end

end





