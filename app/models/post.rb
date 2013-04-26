class Post < ActiveRecord::Base
  has_and_belongs_to_many :categories
  attr_accessible :body, :modify_date, :release_date, :title, :url_title, :hidden, :hits

  validates :title,
    presence: true,
    length: { maximum: 100, minimum: 2 }

  validates :body,
    presence: true

  validates :url_title,
    presence: true,
    uniqueness: true,
    length: { maximum: 100, minimum: 2 },
    format: /^[a-zA-Z0-9_-]*$/

  validates :release_date,
    presence: true

  validates :modify_date,
    presence: true

  validate :release_before_modify

  def release_before_modify
    errors.add(:release_date, "must be before modify date") unless 
      self.release_date <= self.modify_date
  end

  def self.latest
    Post.where( :hidden => 0 ).last
  end

  def self.all_visible
    Post.where( "hidden" => 0 ).order("release_date DESC, id DESC")
  end

  def to_param
    self.url_title
  end

  def next
    Post.where(
      "(release_date > ?) OR (release_date = ? AND id > ?)",
      self.release_date, self.release_date, self.id
    ).order("release_date ASC, id ASC").first
  end

  def previous
    Post.where(
      "(release_date < ?) OR (release_date = ? AND id < ?)",
      self.release_date, self.release_date, self.id
    ).order("release_date DESC, id DESC").first
  end

  def fulltitle
     "#{self.title}"
  end

end
