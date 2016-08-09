class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  attr_encrypted :salary, key: '8762b1f8c0d5708d1d2f4dd3959f393eb8ea9827056ba575eb7588519afda192f0937c9fdb5e64b155217313977dca4b2d44cde83783d3f13d2f03444f725bcb'

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum role: [ :user, :admin ]
end
