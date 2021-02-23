class AddProductsCountToCategories < ActiveRecord::Migration[6.1]
  def change
    add_column :categories, :articles_count, :integer, null: false, default: 0
    add_column :clubs, :courses_count, :integer, null: false, default: 0
    add_column :poll_questions, :poll_answers_count, :integer, null: false, default: 0
    add_column :polls, :poll_questions_count, :integer, null: false, default: 0
    add_column :polls, :poll_answers_count, :integer, null: false, default: 0
    add_column :users, :follows_count, :integer, null: false, default: 0
    add_column :users, :followers_count, :integer, null: false, default: 0
    add_column :users, :posts_count, :integer, null: false, default: 0

    Article.counter_culture_fix_counts
    Course.counter_culture_fix_counts
    Hole.counter_culture_fix_counts
    Course.counter_culture_fix_counts
    PollAnswer.counter_culture_fix_counts
    PollQuestion.counter_culture_fix_counts
    User.counter_culture_fix_counts
  end
end
