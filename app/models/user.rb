class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  before_save :default_values
  has_many :archivos

  ROLES = %w[ninguno usuario moderador administrador]

  def role?(base_role)
    if role.nil?
      return false
    end
    ROLES.index(base_role.to_s) <= ROLES.index(role)
  end

  def default_values
    self.role ||= 'usuario'
    nil
  end
end
