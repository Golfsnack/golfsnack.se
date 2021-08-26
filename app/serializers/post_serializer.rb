# frozen_string_literal: true

class PostSerializer < ActiveModel::Serializer
  attributes :id,
             :body,
             :club,
             :comments_count,
             :images,
             :mainimage,
             :preamble,
             :tags,
             :title,
             :user,
             :youtube_url
end
