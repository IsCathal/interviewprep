require "test_helper"

class CommentTest < ActiveSupport::TestCase
  test "valid with content and post" do
    post = Post.create!(title: "Sample", content: "Post body")
    comment = Comment.new(content: "Nice post!", post: post)
    assert comment.valid?
  end

  test "invalid without content" do
    post = Post.create!(title: "Sample", content: "Post body")
    comment = Comment.new(post: post)
    assert_not comment.valid?
    assert_includes comment.errors[:content], "can't be blank"
  end

  test "invalid without post" do
    comment = Comment.new(content: "No post attached")
    assert_not comment.valid?
    assert_includes comment.errors[:post], "must exist"
  end
end
