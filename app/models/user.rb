class User < ApplicationRecord
  has_many :news
  has_many :comments
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         has_many :news
         has_many :comments

         enum role: { user: "user", admin: "admin" }
end
