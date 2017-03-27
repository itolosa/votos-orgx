require 'csv'

class Activist < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, #:registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :section
  has_many :activist_fronts, dependent: :destroy
  has_many :fronts, through: :activist_fronts
  belongs_to :vote

  accepts_nested_attributes_for :activist_fronts
  accepts_nested_attributes_for :fronts

  has_secure_token

  before_save :format_fields
  #before_validation :fill_pass

  def fill_pass
    random_pass = Devise.friendly_token.first(12)
    self.password = random_pass
    self.password_confirmation = random_pass
  end

  def voted?
    self.vote_id?
  end

  def format_fields
    self.name = self.name.strip.titleize
    self.email = self.email.strip.downcase
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |activist|
        csv << activist.attributes.values_at(*column_names)
      end
    end
  end

  def self.accessible_attributes
    ['name', 'email']
  end

  def self.send_mail_all
    all.each do |activist|
      ActivistMailer.sample_email(activist).deliver_later
    end
  end
end
