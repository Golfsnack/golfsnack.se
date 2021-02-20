# Be sure to restart your server when you modify this file.
#
# Points are a simple integer value which are given to "meritable" resources
# according to rules in +app/models/merit/point_rules.rb+. They are given on
# actions-triggered, either to the action user or to the method (or array of
# methods) defined in the +:to+ option.
#
# 'score' method may accept a block which evaluates to boolean
# (recieves the object as parameter)

module Merit
  class PointRules
    include Merit::PointRulesMethods

    # TODO, write tests for these, controller tests + expect
    def initialize
      score 1, to: :post_creator, on: 'comments#create', category: 'comment_activity' do |comment|
        comment.comment.present?
      end

      score 1, on: 'RegistrationsController#create'
      score 1, on: 'likes#create'
      score -1, on: 'likes#destroy'

      # score 15, :on => 'reviews#create', :to => [:reviewer, :reviewed]

      score 3, on: [
        'comments#create',
        'polls#vote'
      ]

      score 10, on: ['posts#create']

      # score -10, :on => 'comments#destroy'
    end
  end
end
