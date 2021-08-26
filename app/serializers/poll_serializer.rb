# frozen_string_literal: true

class PollSerializer < ActiveModel::Serializer
  attributes :id, :name, :archived, :poll_questions #, :poll_answers
end
