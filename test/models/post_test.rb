require "test_helper"

class PostTest < ActiveSupport::TestCase
  test "is valid with title and content" do
    post = Post.new(title: "Hello", content: "This is a blog post")
    assert post.valid?
  end

  test "is invalid without title" do
    post = Post.new(content: "Missing title")
    assert_not post.valid?
    assert_includes post.errors[:title], "can't be blank"
  end

  test "is invalid without content" do
    post = Post.new(title: "Missing content")
    assert_not post.valid?
    assert_includes post.errors[:content], "can't be blank"
  end
end
