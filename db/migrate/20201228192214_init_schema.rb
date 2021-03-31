# frozen_string_literal: true

class InitSchema < ActiveRecord::Migration
  def up
    # These are extensions that must be enabled in order to support this database
    enable_extension 'plpgsql'
    create_table 'action_text_rich_texts' do |t|
      t.string 'name', null: false
      t.text 'body'
      t.string 'record_type', null: false
      t.bigint 'record_id', null: false
      t.datetime 'created_at', precision: 6, null: false
      t.datetime 'updated_at', precision: 6, null: false
      t.index %w[record_type record_id name], name: 'index_action_text_rich_texts_uniqueness', unique: true
    end
    create_table 'active_storage_attachments' do |t|
      t.string 'name', null: false
      t.string 'record_type', null: false
      t.bigint 'record_id', null: false
      t.bigint 'blob_id', null: false
      t.datetime 'created_at', null: false
      t.index ['blob_id'], name: 'index_active_storage_attachments_on_blob_id'
      t.index %w[record_type record_id name blob_id], name: 'index_active_storage_attachments_uniqueness',
                                                      unique: true
    end
    create_table 'active_storage_blobs' do |t|
      t.string 'key', null: false
      t.string 'filename', null: false
      t.string 'content_type'
      t.text 'metadata'
      t.bigint 'byte_size', null: false
      t.string 'checksum', null: false
      t.datetime 'created_at', null: false
      t.string 'service_name', null: false
      t.index ['key'], name: 'index_active_storage_blobs_on_key', unique: true
    end
    create_table 'active_storage_variant_records' do |t|
      t.bigint 'blob_id', null: false
      t.string 'variation_digest', null: false
      t.index %w[blob_id variation_digest], name: 'index_active_storage_variant_records_uniqueness', unique: true
    end
    create_table 'activities' do |t|
      t.string 'trackable_type'
      t.bigint 'trackable_id'
      t.string 'owner_type'
      t.bigint 'owner_id'
      t.string 'key'
      t.text 'parameters'
      t.string 'recipient_type'
      t.bigint 'recipient_id'
      t.datetime 'created_at', null: false
      t.datetime 'updated_at', null: false
      t.index %w[owner_id owner_type], name: 'index_activities_on_owner_id_and_owner_type'
      t.index %w[owner_type owner_id], name: 'index_activities_on_owner'
      t.index %w[recipient_id recipient_type], name: 'index_activities_on_recipient_id_and_recipient_type'
      t.index %w[recipient_type recipient_id], name: 'index_activities_on_recipient'
      t.index %w[trackable_id trackable_type], name: 'index_activities_on_trackable_id_and_trackable_type'
      t.index %w[trackable_type trackable_id], name: 'index_activities_on_trackable'
    end
    create_table 'articles' do |t|
      t.integer 'user_id'
      t.string 'title'
      t.string 'image'
      t.text 'body'
      t.datetime 'created_at', precision: 6, null: false
      t.datetime 'updated_at', precision: 6, null: false
      t.string 'slug'
      t.text 'preamble'
      t.index ['slug'], name: 'index_articles_on_slug', unique: true
    end
    create_table 'badges_sashes' do |t|
      t.integer 'badge_id'
      t.integer 'sash_id'
      t.boolean 'notified_user', default: false
      t.datetime 'created_at'
      t.index %w[badge_id sash_id], name: 'index_badges_sashes_on_badge_id_and_sash_id'
      t.index ['badge_id'], name: 'index_badges_sashes_on_badge_id'
      t.index ['sash_id'], name: 'index_badges_sashes_on_sash_id'
    end
    create_table 'clubs' do |t|
      t.string 'import_guid'
      t.string 'name'
      t.string 'lat'
      t.string 'lng'
      t.text 'description'
      t.datetime 'created_at', precision: 6, null: false
      t.datetime 'updated_at', precision: 6, null: false
      t.integer 'posts_count'
      t.integer 'users_count'
    end
    create_table 'comments' do |t|
      t.string 'title', limit: 50, default: ''
      t.text 'comment'
      t.string 'commentable_type'
      t.bigint 'commentable_id'
      t.bigint 'user_id'
      t.string 'role', default: 'comments'
      t.datetime 'created_at', precision: 6, null: false
      t.datetime 'updated_at', precision: 6, null: false
      t.index ['commentable_id'], name: 'index_comments_on_commentable_id'
      t.index %w[commentable_type commentable_id], name: 'index_comments_on_commentable_type_and_commentable_id'
      t.index ['commentable_type'], name: 'index_comments_on_commentable_type'
      t.index ['user_id'], name: 'index_comments_on_user_id'
    end
    create_table 'courses' do |t|
      t.string 'import_guid'
      t.integer 'club_id'
      t.integer 'import_id'
      t.string 'name'
      t.integer 'holes_count'
      t.integer 'par'
      t.text 'description'
      t.string 'architect'
      t.datetime 'created_at', precision: 6, null: false
      t.datetime 'updated_at', precision: 6, null: false
    end
    create_table 'follows' do |t|
      t.string 'followable_type', null: false
      t.bigint 'followable_id', null: false
      t.string 'follower_type', null: false
      t.bigint 'follower_id', null: false
      t.boolean 'blocked', default: false, null: false
      t.datetime 'created_at', precision: 6, null: false
      t.datetime 'updated_at', precision: 6, null: false
      t.index %w[followable_id followable_type], name: 'fk_followables'
      t.index %w[followable_type followable_id], name: 'index_follows_on_followable_type_and_followable_id'
      t.index %w[follower_id follower_type], name: 'fk_follows'
      t.index %w[follower_type follower_id], name: 'index_follows_on_follower_type_and_follower_id'
    end
    create_table 'friendly_id_slugs' do |t|
      t.string 'slug', null: false
      t.integer 'sluggable_id', null: false
      t.string 'sluggable_type', limit: 50
      t.string 'scope'
      t.datetime 'created_at'
      t.index %w[slug sluggable_type scope],
              name: 'index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope', unique: true
      t.index %w[slug sluggable_type], name: 'index_friendly_id_slugs_on_slug_and_sluggable_type'
      t.index %w[sluggable_type sluggable_id], name: 'index_friendly_id_slugs_on_sluggable_type_and_sluggable_id'
    end
    create_table 'holes' do |t|
      t.integer 'course_id'
      t.integer 'number'
      t.integer 'par'
      t.integer 'index'
      t.datetime 'created_at', precision: 6, null: false
      t.datetime 'updated_at', precision: 6, null: false
    end
    create_table 'invitations' do |t|
      t.integer 'user_id'
      t.string 'email'
      t.string 'code'
      t.datetime 'claimed_at'
      t.datetime 'created_at', precision: 6, null: false
      t.datetime 'updated_at', precision: 6, null: false
      t.index ['email'], name: 'index_invitations_on_email', unique: true
      t.index ['user_id'], name: 'index_invitations_on_user_id'
    end
    create_table 'merit_actions' do |t|
      t.integer 'user_id'
      t.string 'action_method'
      t.integer 'action_value'
      t.boolean 'had_errors', default: false
      t.string 'target_model'
      t.integer 'target_id'
      t.text 'target_data'
      t.boolean 'processed', default: false
      t.datetime 'created_at', precision: 6, null: false
      t.datetime 'updated_at', precision: 6, null: false
    end
    create_table 'merit_activity_logs' do |t|
      t.integer 'action_id'
      t.string 'related_change_type'
      t.integer 'related_change_id'
      t.string 'description'
      t.datetime 'created_at'
    end
    create_table 'merit_score_points' do |t|
      t.bigint 'score_id'
      t.bigint 'num_points', default: 0
      t.string 'log'
      t.datetime 'created_at'
      t.index ['score_id'], name: 'index_merit_score_points_on_score_id'
    end
    create_table 'merit_scores' do |t|
      t.bigint 'sash_id'
      t.string 'category', default: 'default'
      t.index ['sash_id'], name: 'index_merit_scores_on_sash_id'
    end
    create_table 'posts' do |t|
      t.string 'title'
      t.text 'body'
      t.integer 'round_id'
      t.integer 'user_id'
      t.datetime 'created_at', precision: 6, null: false
      t.datetime 'updated_at', precision: 6, null: false
      t.integer 'comments_count'
      t.integer 'club_id'
      t.text 'preamble'
      t.index ['user_id'], name: 'index_posts_on_user_id'
    end
    create_table 'roles' do |t|
      t.string 'name'
      t.string 'resource_type'
      t.bigint 'resource_id'
      t.datetime 'created_at', precision: 6, null: false
      t.datetime 'updated_at', precision: 6, null: false
      t.index %w[name resource_type resource_id], name: 'index_roles_on_name_and_resource_type_and_resource_id'
      t.index %w[resource_type resource_id], name: 'index_roles_on_resource'
    end
    create_table 'sashes' do |t|
      t.datetime 'created_at', precision: 6, null: false
      t.datetime 'updated_at', precision: 6, null: false
    end
    create_table 'users' do |t|
      t.string 'email', default: '', null: false
      t.string 'encrypted_password', default: '', null: false
      t.string 'reset_password_token'
      t.datetime 'reset_password_sent_at'
      t.datetime 'remember_created_at'
      t.integer 'sign_in_count', default: 0, null: false
      t.datetime 'current_sign_in_at'
      t.datetime 'last_sign_in_at'
      t.inet 'current_sign_in_ip'
      t.inet 'last_sign_in_ip'
      t.string 'confirmation_token'
      t.datetime 'confirmed_at'
      t.datetime 'confirmation_sent_at'
      t.datetime 'last_seen'
      t.datetime 'created_at', precision: 6, null: false
      t.datetime 'updated_at', precision: 6, null: false
      t.string 'first_name'
      t.string 'last_name'
      t.string 'golf_id'
      t.string 'avatar'
      t.integer 'sash_id'
      t.integer 'level', default: 0
      t.integer 'club_id'
      t.index ['confirmation_token'], name: 'index_users_on_confirmation_token', unique: true
      t.index ['email'], name: 'index_users_on_email', unique: true
      t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
    end
    create_table 'users_roles', id: false do |t|
      t.bigint 'user_id'
      t.bigint 'role_id'
      t.index ['role_id'], name: 'index_users_roles_on_role_id'
      t.index %w[user_id role_id], name: 'index_users_roles_on_user_id_and_role_id'
      t.index ['user_id'], name: 'index_users_roles_on_user_id'
    end
    create_table 'votes' do |t|
      t.string 'votable_type'
      t.bigint 'votable_id'
      t.string 'voter_type'
      t.bigint 'voter_id'
      t.boolean 'vote_flag'
      t.string 'vote_scope'
      t.integer 'vote_weight'
      t.datetime 'created_at', precision: 6, null: false
      t.datetime 'updated_at', precision: 6, null: false
      t.index %w[votable_id votable_type vote_scope],
              name: 'index_votes_on_votable_id_and_votable_type_and_vote_scope'
      t.index %w[votable_type votable_id], name: 'index_votes_on_votable_type_and_votable_id'
      t.index %w[voter_id voter_type vote_scope], name: 'index_votes_on_voter_id_and_voter_type_and_vote_scope'
      t.index %w[voter_type voter_id], name: 'index_votes_on_voter_type_and_voter_id'
    end
    add_foreign_key 'active_storage_attachments', 'active_storage_blobs', column: 'blob_id'
    add_foreign_key 'active_storage_variant_records', 'active_storage_blobs', column: 'blob_id'
  end

  def down
    raise ActiveRecord::IrreversibleMigration, 'The initial migration is not revertable'
  end
end
