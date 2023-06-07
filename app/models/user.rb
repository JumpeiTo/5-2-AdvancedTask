class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_one_attached :profile_image
  # フォローする側 follower
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :active_relationships, source: :followerd
  # フォローされる側 followerd
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followerd_id", dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower
  # DM
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
  # 閲覧数
  has_many :view_counts, dependent: :destroy
  # グループ
  has_many :group_users
  has_many :groups, through: :group_users

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }


  
  
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
  
  def followed_by?(user)
    # 今自分(引数のuser)がフォローしようとしているユーザー(レシーバー)が
    # フォローされているユーザー(つまりpassive)の中から、引数に渡されたユーザー(自分)がいるかどうかを調べる
    passive_relationships.find_by(follower_id: user.id).present?
  end

# 検索条件分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @user = User.where("name LIKE?", "#{word}")
    elsif search == "forward_match"
      @user = User.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @user = User.where("name LIKE?","%#{word}")
    elsif search == "partial_match"
      @user = User.where("name LIKE?","%#{word}%")
    else
      @user = User.all
    end
  end
  
end