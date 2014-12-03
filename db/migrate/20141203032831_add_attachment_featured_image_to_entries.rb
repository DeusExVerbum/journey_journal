class AddAttachmentFeaturedImageToEntries < ActiveRecord::Migration
  def self.up
    change_table :entries do |t|
      t.attachment :featured_image
    end
  end

  def self.down
    remove_attachment :entries, :featured_image
  end
end
