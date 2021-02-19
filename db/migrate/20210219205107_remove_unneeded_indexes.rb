class RemoveUnneededIndexes < ActiveRecord::Migration[6.1]
  def change
    remove_index :badges_sashes, name: "index_badges_sashes_on_badge_id", column: :badge_id
    remove_index :comments, name: "index_comments_on_commentable_type", column: :commentable_type
    remove_index :friendly_id_slugs, name: "index_friendly_id_slugs_on_slug_and_sluggable_type", column: [:slug, :sluggable_type]
    remove_index :taggings, name: "index_taggings_on_tag_id", column: :tag_id
    remove_index :taggings, name: "index_taggings_on_taggable_id", column: :taggable_id
    remove_index :taggings, name: "index_taggings_on_tagger_id", column: :tagger_id
    remove_index :users_roles, name: "index_users_roles_on_user_id", column: :user_id
  end
end
