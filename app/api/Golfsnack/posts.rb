# frozen_string_literal: true

module Golfsnack
  class Posts < Grape::API
    resource :posts do
      desc 'Return posts'
      params do
        optional :tag, type: String, desc: 'tag to filter by'
        optional :per, type: Integer, desc: 'How many to get (default 50)'
        optional :page, type: Integer, desc: 'What page to get (default 0)'
      end
      get '' do
        per = params[:per] || 50
        if params[:tag]
          Post.tagged_with(params[:tag]).includes(user: [avatar_attachment: :blob]).includes([:club]).order('created_at desc').page(params[:page]).per(per)
        else
          Post.includes(user: [avatar_attachment: :blob]).includes([:club]).order('created_at desc').page(params[:page]).per(per)
        end
      end

      desc 'Return a specific post'
      params do
        requires :id, type: String, desc: 'ID of the post'
      end
      get ':id' do
        Post.where(id: permitted_params[:id]).first!
      end
    end
  end
end
